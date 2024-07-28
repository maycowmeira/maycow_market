defmodule MaycowMarket.Checkout do
  @moduledoc """
  Main module used to scan products.
  """
  alias MaycowMarket.{Cart, Product, ProductCart}

  @products_codes ~w(GR1 SR1 CF1)
  @products %{
    "GR1" => %Product{code: "GR1", name: "Green tea", price: 3.11},
    "SR1" => %Product{code: "SR1", name: "Strawberries", price: 5.00},
    "CF1" => %Product{code: "CF1", name: "Coffee", price: 11.23}
  }

  defstruct cart: [], total: 0.0
  @type t() :: %__MODULE__{cart: list(ProductCart.t()), total: float()}

  @doc """
  Receives a string with the code, searches in the products list, and adds it to the cart.

  Returns {:ok, %Checkout{}} if the product is found and added to the cart.
  Returns :error if the product is not found.

  ## Examples

      iex> checkout = %MaycowMarket.Checkout{}
      iex> MaycowMarket.Checkout.scan(checkout, "GR1")
      {:ok, %MaycowMarket.Checkout{cart: [%MaycowMarket.ProductCart{product: %Product{code: "GR1", name: "Green tea", price: 3.11}, amount: 1, total: 3.11}], total: 0.0}}

      iex> MaycowMarket.Checkout.scan(checkout, "UNKNOWN")
      :error
  """
  def scan(%__MODULE__{} = checkout, code) when is_binary(code) and code in @products_codes do
    product = @products[code]

    updated_cart = Cart.add_product(checkout.cart, product)
    updated_total = calculate_total(updated_cart)

    {:ok, %__MODULE__{checkout | cart: updated_cart, total: updated_total}}
  end

  def scan(_checkout, _code), do: :error

  @doc false
  defp calculate_total(cart) do
    Enum.reduce(cart, 0.0, fn %ProductCart{total: total}, acc -> acc + total end)
  end
end
