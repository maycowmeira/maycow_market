defmodule MaycowMarket.Product do
  @moduledoc """

  Product module is meant to be used as products struct definition and functions related to it.
  There is a map with the list of existing products to ease access to its info.
  """

  defstruct code: "", name: "", price: 0.0

  @type t() :: %__MODULE__{code: String.t(), name: String.t(), price: float()}
end
