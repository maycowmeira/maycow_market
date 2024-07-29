defmodule MaycowMarket.CartTest do
  use ExUnit.Case
  alias MaycowMarket.{Cart, Product}

  describe "add_product/2" do
    test "adds a new product to the cart" do
      product = %Product{code: "GR1", name: "Green tea", price: Decimal.new("3.11")}
      cart = Cart.add_product([], product)
      assert Enum.any?(cart, fn item -> item.product.code == "GR1" and item.amount == 1 end)
    end

    test "increments the amount of an existing product in the cart" do
      product = %Product{code: "GR1", name: "Green tea", price: Decimal.new("3.11")}
      cart = Cart.add_product([], product)
      cart = Cart.add_product(cart, product)
      assert Enum.any?(cart, fn item -> item.product.code == "GR1" and item.amount == 2 end)
    end
  end
end
