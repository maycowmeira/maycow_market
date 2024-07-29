defprotocol MaycowMarket.Promotion do
  @moduledoc """
  The `MaycowMarket.Promotion` protocol defines a common interface for applying promotions to a shopping cart.

  This protocol should be implemented by any module that handles specific promotion rules.
  Implementations of this protocol will provide the logic to modify the cart based on the promotion's conditions.

  ## Example Implementation

      defmodule MaycowMarket.Promotions.BuyOneGetOneFree do
        @behaviour MaycowMarket.Promotion

        def apply(cart) do
          # Implementation logic for buy-one-get-one-free promotion
        end
      end
  """

  @doc """
  Applies the promotion to the cart and returns the updated cart.

  ## Parameters

    - cart: The current shopping cart, represented as a list of `ProductCart` structs.

  ## Returns

    - The updated cart with the promotion applied, represented as a list of `ProductCart` structs.
  """
  @spec apply([ProductCart.t()]) :: [ProductCart.t()]
  def apply(cart)
end
