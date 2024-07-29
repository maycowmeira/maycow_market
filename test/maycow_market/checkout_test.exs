defmodule MaycowMarket.CheckoutTest do
  use ExUnit.Case
  alias MaycowMarket.Checkout

  describe "scan/2" do
    setup do
      initial_market = %Checkout{}
      %{initial_market: initial_market}
    end

    # Basic Functionality
    test "successfully adds a green tea to the cart and updates the total", %{
      initial_market: initial_market
    } do
      {:ok, checkout} = Checkout.scan(initial_market, "GR1")

      assert Enum.any?(checkout.cart, fn item ->
               item.product.code == "GR1" and item.amount == 1
             end)

      assert checkout.total == Decimal.new("3.11")
    end

    test "successfully adds a coffee to the cart and updates the total", %{
      initial_market: initial_market
    } do
      {:ok, checkout} = Checkout.scan(initial_market, "CF1")

      assert Enum.any?(checkout.cart, fn item ->
               item.product.code == "CF1" and item.amount == 1
             end)

      assert checkout.total == Decimal.new("11.23")
    end

    test "successfully adds a strawberry to the cart and updates the total", %{
      initial_market: initial_market
    } do
      {:ok, checkout} = Checkout.scan(initial_market, "SR1")

      assert Enum.any?(checkout.cart, fn item ->
               item.product.code == "SR1" and item.amount == 1
             end)

      assert checkout.total == Decimal.new("5.00")
    end

    test "successfully adds multiple different products to the cart and updates the total", %{
      initial_market: initial_market
    } do
      {:ok, checkout} = Checkout.scan(initial_market, "GR1")

      assert Enum.any?(checkout.cart, fn item ->
               item.product.code == "GR1" and item.amount == 1
             end)

      assert checkout.total == Decimal.new("3.11")

      {:ok, checkout} = Checkout.scan(checkout, "SR1")

      assert Enum.any?(checkout.cart, fn item ->
               item.product.code == "SR1" and item.amount == 1
             end)

      assert checkout.total == Decimal.new("8.11")

      {:ok, checkout} = Checkout.scan(checkout, "CF1")

      assert Enum.any?(checkout.cart, fn item ->
               item.product.code == "CF1" and item.amount == 1
             end)

      assert checkout.total == Decimal.new("19.34")
    end

    test "returns :error for unknown product code", %{initial_market: initial_market} do
      assert Checkout.scan(initial_market, "UNKNOWN") == :error
    end

    # Promotions
    test "applies the bulk discount for strawberries", %{initial_market: initial_market} do
      {:ok, checkout} = Checkout.scan(initial_market, "SR1")
      {:ok, checkout} = Checkout.scan(checkout, "SR1")
      {:ok, checkout} = Checkout.scan(checkout, "SR1")

      assert Enum.any?(checkout.cart, fn item ->
               item.product.code == "SR1" and item.amount == 3
             end)

      assert checkout.total == Decimal.new("13.50")
    end

    test "applies the coffee discount correctly", %{initial_market: initial_market} do
      {:ok, checkout} = Checkout.scan(initial_market, "CF1")
      {:ok, checkout} = Checkout.scan(checkout, "CF1")
      {:ok, checkout} = Checkout.scan(checkout, "CF1")

      assert Enum.any?(checkout.cart, fn item ->
               item.product.code == "CF1" and item.amount == 3
             end)

      # Coffee discount applied
      assert checkout.total == Decimal.new("22.46")
    end

    # Complex Scenarios

    test "handles mixed promotions", %{initial_market: initial_market} do
      {:ok, checkout} = Checkout.scan(initial_market, "GR1")
      {:ok, checkout} = Checkout.scan(checkout, "GR1")
      {:ok, checkout} = Checkout.scan(checkout, "SR1")
      {:ok, checkout} = Checkout.scan(checkout, "SR1")
      {:ok, checkout} = Checkout.scan(checkout, "SR1")
      {:ok, checkout} = Checkout.scan(checkout, "CF1")
      {:ok, checkout} = Checkout.scan(checkout, "CF1")
      {:ok, checkout} = Checkout.scan(checkout, "CF1")

      assert Enum.any?(checkout.cart, fn item ->
               item.product.code == "GR1" and item.amount == 2
             end)

      assert Enum.any?(checkout.cart, fn item ->
               item.product.code == "SR1" and item.amount == 3
             end)

      assert Enum.any?(checkout.cart, fn item ->
               item.product.code == "CF1" and item.amount == 3
             end)

      assert checkout.total == Decimal.new("39.07")
    end

    test "handles multiple promotions for the same product", %{initial_market: initial_market} do
      {:ok, checkout} = Checkout.scan(initial_market, "GR1")
      {:ok, checkout} = Checkout.scan(checkout, "GR1")
      {:ok, checkout} = Checkout.scan(checkout, "GR1")
      {:ok, checkout} = Checkout.scan(checkout, "GR1")

      assert Enum.any?(checkout.cart, fn item ->
               item.product.code == "GR1" and item.amount == 4
             end)

      assert checkout.total == Decimal.new("6.22")
    end

    # Main Scenarios
    test "chandles the scenario with basket: GR1,SR1,GR1,GR1,CF1", %{
      initial_market: initial_market
    } do
      {:ok, checkout} = Checkout.scan(initial_market, "GR1")
      {:ok, checkout} = Checkout.scan(checkout, "SR1")
      {:ok, checkout} = Checkout.scan(checkout, "GR1")
      {:ok, checkout} = Checkout.scan(checkout, "GR1")
      {:ok, checkout} = Checkout.scan(checkout, "CF1")

      assert Enum.any?(checkout.cart, fn item ->
               item.product.code == "GR1" and item.amount == 3
             end)

      assert Enum.any?(checkout.cart, fn item ->
               item.product.code == "SR1" and item.amount == 1
             end)

      assert Enum.any?(checkout.cart, fn item ->
               item.product.code == "CF1" and item.amount == 1
             end)

      assert checkout.total == Decimal.new("22.45")
    end

    test "handles the scenario with basket: GR1, GR1
          applies the buy-one-get-one-free offer for green tea",
         %{initial_market: initial_market} do
      {:ok, checkout} = Checkout.scan(initial_market, "GR1")
      {:ok, checkout} = Checkout.scan(checkout, "GR1")

      assert Enum.any?(checkout.cart, fn item ->
               item.product.code == "GR1" and item.amount == 2
             end)

      assert checkout.total == Decimal.new("3.11")
    end

    test "handles the scenario with basket: SR1, SR1, GR1, SR1", %{initial_market: initial_market} do
      {:ok, checkout} = Checkout.scan(initial_market, "SR1")
      {:ok, checkout} = Checkout.scan(checkout, "SR1")
      {:ok, checkout} = Checkout.scan(checkout, "GR1")
      {:ok, checkout} = Checkout.scan(checkout, "SR1")

      assert Enum.any?(checkout.cart, fn item ->
               item.product.code == "SR1" and item.amount == 3
             end)

      assert Enum.any?(checkout.cart, fn item ->
               item.product.code == "GR1" and item.amount == 1
             end)

      assert checkout.total == Decimal.new("16.61")
    end

    test "handles the scenario with basket: GR1, CF1, SR1, CF1, CF1", %{
      initial_market: initial_market
    } do
      {:ok, checkout} = Checkout.scan(initial_market, "GR1")
      {:ok, checkout} = Checkout.scan(checkout, "CF1")
      {:ok, checkout} = Checkout.scan(checkout, "SR1")
      {:ok, checkout} = Checkout.scan(checkout, "CF1")
      {:ok, checkout} = Checkout.scan(checkout, "CF1")

      assert Enum.any?(checkout.cart, fn item ->
               item.product.code == "GR1" and item.amount == 1
             end)

      assert Enum.any?(checkout.cart, fn item ->
               item.product.code == "CF1" and item.amount == 3
             end)

      assert Enum.any?(checkout.cart, fn item ->
               item.product.code == "SR1" and item.amount == 1
             end)

      assert checkout.total == Decimal.new("30.57")
    end
  end
end
