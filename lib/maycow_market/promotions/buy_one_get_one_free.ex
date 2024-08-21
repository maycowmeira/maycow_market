defmodule MaycowMarket.Promotions.BuyOneGetOneFree do
  @moduledoc """
  The `MaycowMarket.Promotions.BulkDiscountFixedPrice` module implements the `MaycowMarket.Promotion` behavior.

  The `MaycowMarket.Promotions.BuyOneGetOneFree` module applies a promotion where,
  if you buy one, you get one free for specific products.

  This promotion currently applies to the product with code "GR1" (Green Tea).
  """
  @behaviour MaycowMarket.Promotion

  alias MaycowMarket.{Product, ProductCart}

  @doc """
  Implements the `apply/1` callback from the `MaycowMarket.Promotion` behavior.

  Applies the "Buy One, Get One Free" promotion to the cart.

  For each product in the cart with code "GR1", the total price is adjusted to reflect the promotion.

  ## Parameters

    - cart: The current shopping cart, represented as a list of `ProductCart` structs.

  ## Returns

    - The updated cart with the promotion applied, represented as a list of `ProductCart` structs.

  ## Examples

      iex> cart = [%ProductCart{product: %Product{code: "GR1", name: "Green Tea", price: Decimal.new("3.11")}, amount: 2, total: Decimal.new("6.22")}]
      iex> MaycowMarket.Promotions.BuyOneGetOneFree.apply(cart)
      [%ProductCart{product: %Product{code: "GR1", name: "Green Tea", price: Decimal.new("3.11")}, amount: 2, total: Decimal.new("3.11")}]
  """
  @impl true
  @spec apply([ProductCart.t()]) :: [ProductCart.t()]
  def apply(cart), do: Enum.map(cart, &apply_promo/1)

  @spec apply_promo(ProductCart.t()) :: ProductCart.t()
  defp apply_promo(%ProductCart{product: %Product{code: "GR1"} = product, amount: amount} = item) do
    free_items = div(amount, 2)
    total = Decimal.mult(product.price, Decimal.new(amount - free_items)) |> Decimal.round(2)
    %ProductCart{item | total: total}
  end

  defp apply_promo(item), do: item
end
