defmodule MaycowMarket.Promotion do
  @moduledoc """
  The `MaycowMarket.Promotion` module defines a common behavior for applying promotions to a shopping cart.

  This behavior should be implemented by any module that handles specific promotion rules.
  Implementations of this behavior will provide the logic to modify the cart based on the promotion's conditions.

  ## Example Implementation

      defmodule MaycowMarket.Promotions.BuyOneGetOneFree do
        @behaviour MaycowMarket.Promotion

        @impl true
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

  @callback apply([ProductCart.t()]) :: [ProductCart.t()]
end
