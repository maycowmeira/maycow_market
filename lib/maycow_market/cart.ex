defmodule MaycowMarket.Cart do
  @moduledoc """
  Cart module handles operations related to the shopping cart.
  """
  alias MaycowMarket.ProductCart

  @doc """
  Adds a product to the cart. If the product is already in the cart, increments the amount. Otherwise, creates a new entry.

  ## Examples

      iex> product = %Product{code: "GR1", name: "Green tea", price: 3.11}
      iex> MaycowMarket.Cart.add_product([], product)
      [%MaycowMarket.ProductCart{product: product, amount: 1, total: 3.11}]
  """
  def add_product(cart, product) do
    case find_product_cart(cart, product) do
      nil ->
        [ProductCart.new(product) | cart]

      product_cart ->
        updated_product_cart = ProductCart.increment(product_cart)
        update_cart(cart, updated_product_cart)
    end
  end

  @doc false
  defp find_product_cart(cart, product) do
    Enum.find(cart, fn product_cart -> product_cart.product.code == product.code end)
  end

  @doc false
  defp update_cart(cart, new_product_cart) do
    cart
    |> Enum.reject(&(&1.product.code == new_product_cart.product.code))
    |> List.insert_at(0, new_product_cart)
  end
end
