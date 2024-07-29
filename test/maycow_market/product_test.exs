defmodule MaycowMarket.ProductTest do
  use ExUnit.Case

  alias MaycowMarket.Product

  describe "Type definitions" do
    test "type t/0 is correctly defined" do
      assert is_map(%Product{})
      assert %Product{}.__struct__ == MaycowMarket.Product
    end
  end

  describe "Product struct" do
    test "successfully creates a product struct with default values" do
      product = %Product{}
      assert product.code == ""
      assert product.name == ""
      assert product.price == Decimal.new("0.0")
    end

    test "successfully creates a product struct with specified values" do
      product = %Product{code: "GR1", name: "Green tea", price: Decimal.new("3.11")}
      assert product.code == "GR1"
      assert product.name == "Green tea"
      assert product.price == Decimal.new("3.11")
    end
  end
end
