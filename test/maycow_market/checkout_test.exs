defmodule MaycowMarket.CheckoutTest do
  use ExUnit.Case
  alias MaycowMarket.Checkout

  describe "scan/2" do
    setup do
      initial_market = %Checkout{}
      %{initial_market: initial_market}
    end

    test "successfully adds a known product to the cart and updates the total", %{
      initial_market: initial_market
    } do
      {:ok, checkout} = Checkout.scan(initial_market, "GR1")

      assert Enum.any?(checkout.cart, fn item ->
               item.product.code == "GR1" and item.amount == 1
             end)

      assert checkout.total == 3.11
    end

    test "increments the amount of an existing product in the cart and updates the total", %{
      initial_market: initial_market
    } do
      {:ok, checkout} = Checkout.scan(initial_market, "GR1")
      {:ok, checkout} = Checkout.scan(checkout, "GR1")

      assert Enum.any?(checkout.cart, fn item ->
               item.product.code == "GR1" and item.amount == 2
             end)

      assert checkout.total == 6.22
    end

    test "returns :error for unknown product code", %{initial_market: initial_market} do
      assert Checkout.scan(initial_market, "UNKNOWN") == :error
    end

    test "successfully adds multiple different products to the cart and updates the total", %{
      initial_market: initial_market
    } do
      {:ok, checkout} = Checkout.scan(initial_market, "GR1")

      assert Enum.any?(checkout.cart, fn item ->
               item.product.code == "GR1" and item.amount == 1
             end)

      assert checkout.total == 3.11

      {:ok, checkout} = Checkout.scan(checkout, "SR1")

      assert Enum.any?(checkout.cart, fn item ->
               item.product.code == "SR1" and item.amount == 1
             end)

      assert Enum.any?(checkout.cart, fn item ->
               item.product.code == "GR1" and item.amount == 1
             end)

      assert checkout.total == 8.11
    end
  end
end
