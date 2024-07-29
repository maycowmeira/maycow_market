defmodule MaycowMarket.Promotions.BulkDiscountFixedPrice do
  @moduledoc """
  The `MaycowMarket.Promotions.BulkDiscountFixedPrice` module applies a promotion where,
  if you buy three or more of a specific product, the price is fixed to a discounted rate per item.

  This promotion currently applies to the product with code "SR1" (Strawberries).
  """
  @behaviour MaycowMarket.Promotion

  alias MaycowMarket.{Product, ProductCart}
  @fixed_discount_sr1_price Decimal.new("4.50")

  @doc """
  Applies the bulk discount fixed price promotion to the cart.

  For each product in the cart with code "SR1" and an amount of 3 or more,
  the total price is adjusted to reflect the fixed discounted rate per item.

  ## Parameters

    - cart: The current shopping cart, represented as a list of `ProductCart` structs.

  ## Returns

    - The updated cart with the promotion applied, represented as a list of `ProductCart` structs.

  ## Examples

      iex> cart = [%ProductCart{product: %Product{code: "SR1", name: "Strawberries", price: Decimal.new("5.00")}, amount: 3, total: Decimal.new("15.00")}]
      iex> MaycowMarket.Promotions.BulkDiscountFixedPrice.apply(cart)
      [%ProductCart{product: %Product{code: "SR1", name: "Strawberries", price: Decimal.new("5.00")}, amount: 3, total: Decimal.new("13.50")}]
  """
  @spec apply([ProductCart.t()]) :: [ProductCart.t()]
  def apply(cart), do: Enum.map(cart, &apply_promo/1)

  @spec apply_promo(ProductCart.t()) :: ProductCart.t()
  defp apply_promo(%ProductCart{product: %Product{code: "SR1"}, amount: amount} = item)
       when amount >= 3 do
    total =
      Decimal.mult(@fixed_discount_sr1_price, Decimal.new(amount))
      |> Decimal.round(2)

    %ProductCart{item | total: total}
  end

  defp apply_promo(item), do: item
end
