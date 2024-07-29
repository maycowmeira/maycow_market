defmodule MaycowMarket.ProductCartTest do
  use ExUnit.Case
  alias MaycowMarket.{Product, ProductCart}

  describe "new/1" do
    test "creates a new ProductCart" do
      product = %Product{code: "GR1", name: "Green tea", price: Decimal.new("3.11")}
      product_cart = ProductCart.new(product)
      assert product_cart.product == product
      assert product_cart.amount == 1
      assert product_cart.total == Decimal.new("3.11")
    end
  end

  describe "increment/1" do
    test "increments the amount in the ProductCart" do
      product = %Product{code: "GR1", name: "Green tea", price: Decimal.new("3.11")}
      product_cart = ProductCart.new(product)
      product_cart = ProductCart.increment(product_cart)
      assert product_cart.amount == 2
      assert product_cart.total == Decimal.new("6.22")
    end
  end
end
