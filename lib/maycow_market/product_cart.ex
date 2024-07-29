defmodule MaycowMarket.ProductCart do
  @moduledoc """
  The `MaycowMarket.ProductCart` module handles operations related to products in the cart.
  It defines a struct to represent a product in the cart, including the product itself, the amount, and the total price.
  """
  alias MaycowMarket.Product

  defstruct product: %Product{}, amount: 0, total: Decimal.new("0.0")
  @type t() :: %__MODULE__{product: Product.t(), amount: integer(), total: Decimal.t()}

  @doc """
  Creates a new `ProductCart` for the given product with an initial amount of 1 and the total price set to the product price.

  ## Parameters

    - product: The product to add to the cart, represented as a `Product` struct.

  ## Returns

    - A new `ProductCart` struct with the given product, an amount of 1, and the total price set to the product's price.

  ## Examples

      iex> product = %Product{code: "GR1", name: "Green tea", price: Decimal.new("3.11")}
      iex> MaycowMarket.ProductCart.new(product)
      %MaycowMarket.ProductCart{product: product, amount: 1, total: Decimal.new("3.11")}
  """
  @spec new(Product.t()) :: t()
  def new(product) do
    %__MODULE__{product: product, amount: 1, total: product.price}
  end

  @doc """
  Increments the amount of the given `ProductCart` by 1 and updates the total price accordingly.

  ## Parameters

    - product_cart: The `ProductCart` struct to be updated.

  ## Returns

    - An updated `ProductCart` struct with the amount incremented by 1 and the total price recalculated and rounded to 2 decimal places.

  ## Examples

      iex> product_cart = %MaycowMarket.ProductCart{product: %Product{code: "GR1", name: "Green tea", price: Decimal.new("3.11")}, amount: 1, total: Decimal.new("3.11")}
      iex> MaycowMarket.ProductCart.increment(product_cart)
      %MaycowMarket.ProductCart{product: product_cart.product, amount: 2, total: Decimal.new("6.22")}
  """
  @spec increment(t()) :: t()
  def increment(%__MODULE__{amount: amount} = product_cart) do
    new_amount = amount + 1

    total =
      product_cart.product.price
      |> Decimal.mult(Decimal.new(new_amount))
      |> Decimal.round(2)

    %__MODULE__{product_cart | amount: new_amount, total: total}
  end
end
