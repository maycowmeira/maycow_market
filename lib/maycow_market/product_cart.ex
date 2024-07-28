defmodule MaycowMarket.ProductCart do
  @moduledoc """
  ProductCart module handles operations related to products in the cart.
  """
  alias MaycowMarket.Product

  defstruct product: %Product{}, amount: 0, total: 0.0
  @type t() :: %__MODULE__{product: Product.t(), amount: integer(), total: float()}

  @doc """
  Creates a new ProductCart for the given product with an initial amount of 1 and the total price set to the product price.

  ## Examples

      iex> product = %Product{code: "GR1", name: "Green tea", price: 3.11}
      iex> MaycowMarket.ProductCart.new(product)
      %MaycowMarket.ProductCart{product: product, amount: 1, total: 3.11}
  """
  def new(product) do
    %__MODULE__{product: product, amount: 1, total: product.price}
  end

  @doc """
  Increments the amount of the given ProductCart by 1 and updates the total price accordingly.

  ## Examples

      iex> product_cart = %MaycowMarket.ProductCart{product: %Product{code: "GR1", name: "Green tea", price: 3.11}, amount: 1, total: 3.11}
      iex> MaycowMarket.ProductCart.increment(product_cart)
      %MaycowMarket.ProductCart{product: product_cart.product, amount: 2, total: 6.22}
  """
  def increment(%__MODULE__{amount: amount} = product_cart) do
    %__MODULE__{
      product_cart
      | amount: amount + 1,
        total: product_cart.product.price * (amount + 1)
    }
  end
end
