defmodule MaycowMarket.Checkout do
  @moduledoc """
  The `MaycowMarket.Checkout` module is the main module used to scan products and manage the shopping cart.

  It handles adding products to the cart, applying promotions, and calculating the total price.

  ## Module Attributes

    - `@products_codes`: A list of product codes available in the store.
    - `@products`: A map of product codes to product details.

  ## Struct

    - `cart`: A list of `ProductCart` structs representing the items in the cart.
    - `total`: A `Decimal` representing the total price of the items in the cart.
  """
  alias MaycowMarket.{Cart, Product, ProductCart}
  alias MaycowMarket.Promotions.{BuyOneGetOneFree, BulkDiscountFixedPrice, TakeThreePayTwo}

  @products_codes ~w(GR1 SR1 CF1)
  @products %{
    "GR1" => %Product{code: "GR1", name: "Green tea", price: Decimal.new("3.11")},
    "SR1" => %Product{code: "SR1", name: "Strawberries", price: Decimal.new("5.00")},
    "CF1" => %Product{code: "CF1", name: "Coffee", price: Decimal.new("11.23")}
  }

  defstruct cart: [], total: Decimal.new("0.0")
  @type t() :: %__MODULE__{cart: list(ProductCart.t()), total: Decimal.t()}

  @doc """
  Scans a product by its code, searches for it in the products list, and adds it to the cart.

  ## Parameters

    - `checkout`: The current state of the checkout, represented as a `Checkout` struct.
    - `code`: The product code to scan, represented as a string.

  ## Returns

    - `{:ok, %Checkout{}}` if the product is found and added to the cart.
    - `:error` if the product is not found.

  ## Examples

      iex> checkout = %MaycowMarket.Checkout{}
      iex> MaycowMarket.Checkout.scan(checkout, "GR1")
      {:ok, %MaycowMarket.Checkout{
        cart: [%MaycowMarket.ProductCart{
          product: %MaycowMarket.Product{code: "GR1", name: "Green tea", price: Decimal.new("3.11")},
          amount: 1,
          total: Decimal.new("3.11")
        }],
        total: Decimal.new("3.11")
      }}

      iex> checkout = %MaycowMarket.Checkout{}
      iex> MaycowMarket.Checkout.scan(checkout, "UNKNOWN")
      :error
  """
  @spec scan(t(), String.t()) :: {:ok, t()} | :error
  def scan(%__MODULE__{} = checkout, code) when is_binary(code) and code in @products_codes do
    product = @products[code]

    {updated_total, updated_cart} =
      checkout.cart
      |> Cart.add_product(product)
      |> apply_promotions()
      |> calculate_total()

    {:ok, %__MODULE__{checkout | cart: updated_cart, total: updated_total}}
  end

  def scan(_checkout, _code), do: :error

  @doc false
  @spec apply_promotions([ProductCart.t()]) :: [ProductCart.t()]
  defp apply_promotions(cart) do
    cart
    |> BuyOneGetOneFree.apply()
    |> BulkDiscountFixedPrice.apply()
    |> TakeThreePayTwo.apply()
  end

  @doc false
  @spec calculate_total([ProductCart.t()]) :: {Decimal.t(), [ProductCart.t()]}
  defp calculate_total(cart) do
    {
      Enum.reduce(cart, Decimal.new("0.0"), fn %ProductCart{total: total}, acc ->
        Decimal.add(acc, total)
      end),
      cart
    }
  end
end
