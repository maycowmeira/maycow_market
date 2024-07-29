defmodule MaycowMarket.Promotions.TakeThreePayTwo do
  @moduledoc """
  The `MaycowMarket.Promotions.TakeThreePayTwo` module applies a promotion where,
  if you buy three or more of a specific product, you only pay for two-thirds of the total amount.

  This promotion currently applies to the product with code "CF1" (Coffee).
  """

  @behaviour MaycowMarket.Promotion

  alias MaycowMarket.{Product, ProductCart}

  @doc """
  Applies the "Take Three, Pay Two" promotion to the cart.

  For each product in the cart with code "CF1" and an amount of 3 or more,
  the total price is adjusted to reflect the promotion.

  ## Parameters

    - cart: The current shopping cart, represented as a list of `ProductCart` structs.

  ## Returns

    - The updated cart with the promotion applied, represented as a list of `ProductCart` structs.

  ## Examples

      iex> cart = [%ProductCart{product: %Product{code: "CF1", name: "Coffee", price: Decimal.new("11.23")}, amount: 3, total: Decimal.new("33.69")}]
      iex> MaycowMarket.Promotions.TakeThreePayTwo.apply(cart)
      [%ProductCart{product: %Product{code: "CF1", name: "Coffee", price: Decimal.new("11.23")}, amount: 3, total: Decimal.new("22.46")}]
  """
  @spec apply([ProductCart.t()]) :: [ProductCart.t()]
  def apply(cart), do: Enum.map(cart, &apply_promo/1)

  defp apply_promo(%ProductCart{product: %Product{code: "CF1"} = product, amount: amount} = item)
       when amount >= 3 do
    total =
      product.price
      |> two_thirds()
      |> Decimal.mult(Decimal.new(amount))
      |> Decimal.round(2)

    %ProductCart{item | total: total}
  end

  defp apply_promo(item), do: item

  @spec two_thirds(Decimal.t()) :: Decimal.t()
  defp two_thirds(price) do
    price |> Decimal.mult(Decimal.new("2")) |> Decimal.div(Decimal.new("3"))
  end
end
