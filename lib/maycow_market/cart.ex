defmodule MaycowMarket.Cart do
  @moduledoc """
  The `MaycowMarket.Cart` module handles operations related to the shopping cart,
  such as adding products and updating the cart.
  """
  alias MaycowMarket.ProductCart

  @doc """
  Adds a product to the cart. If the product is already in the cart, increments the amount.
  Otherwise, creates a new entry.

  ## Parameters

    - cart: The current shopping cart, represented as a list of `ProductCart` structs.
    - product: The product to add to the cart, represented as a `Product` struct.

  ## Returns

    - The updated cart, which is a list of `ProductCart` structs.

  ## Examples

      iex> product = %Product{code: "GR1", name: "Green tea", price: Decimal.new("3.11")}
      iex> MaycowMarket.Cart.add_product([], product)
      [%MaycowMarket.ProductCart{product: product, amount: 1, total: Decimal.new("3.11")}]
  """
  @spec add_product([ProductCart.t()], Product.t()) :: [ProductCart.t()]
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
  @spec find_product_cart([ProductCart.t()], Product.t()) :: ProductCart.t() | nil
  defp find_product_cart(cart, product) do
    Enum.find(cart, fn product_cart -> product_cart.product.code == product.code end)
  end

  @doc false
  @spec update_cart([ProductCart.t()], ProductCart.t()) :: [ProductCart.t()]
  defp update_cart(cart, new_product_cart) do
    cart
    |> Enum.reject(&(&1.product.code == new_product_cart.product.code))
    |> List.insert_at(0, new_product_cart)
  end
end
