defmodule MaycowMarket.Product do
  @moduledoc """
  The `MaycowMarket.Product` module defines a struct for representing products and functions related to them.

  The struct includes:

    - `code`: A string representing the product code.
    - `name`: A string representing the product name.
    - `price`: A decimal representing the product price.

  This module can be used to create and manage products, providing a standardized structure for product information.
  """

  defstruct code: "", name: "", price: Decimal.new("0.0")

  @type t() :: %__MODULE__{code: String.t(), name: String.t(), price: Decimal.t()}
end
