
# MaycowMarket

This project implements a simple checkout system for a supermarket, written in Elixir. The system scans products, applies special pricing rules, and calculates the total price of the basket.

## Features

- **Scan Products:** Add products to the basket.
- **Total Calculation:** Calculate the total price of the basket.
- **Special Pricing Rules:**
  - Buy-one-get-one-free offer for Green tea.
  - Bulk discount for Strawberries (3 or more).
  - Discount for Coffee when buying 3 or more.

## Versions

  - Elixir 1.17.2
  - Erlang 27.0.1

## Setup

1. Clone the repository:
    ```bash
    git clone https://github.com/yourusername/supermarket_checkout.git
    cd supermarket_checkout
    ```

2. Fetch dependencies:
    ```bash
    mix deps.get
    ```

## Running Tests

Run tests using:
```bash
mix test
```

## Usage

To use the MaycowMarket system in the terminal, follow these steps:

1. Start an interactive Elixir session:
    ```bash
    iex -S mix
    ```

2. Create a new checkout process:
    ```elixir
    checkout = %MaycowMarket.Checkout{}
    ```

3. Scan products by their codes:
    ```elixir
    {:ok, checkout} = MaycowMarket.Checkout.scan(checkout, "GR1")
    {:ok, checkout} = MaycowMarket.Checkout.scan(checkout, "SR1")
    {:ok, checkout} = MaycowMarket.Checkout.scan(checkout, "CF1")
    ```

4. View the current state of the checkout:
    ```elixir
    IO.inspect(checkout)
    ```

5. Calculate the total price of the basket:
    ```elixir
    checkout.total
    ```

## Example Usage

Here is a full example of how to use the MaycowMarket system:

```elixir
# Start a new checkout
checkout = %MaycowMarket.Checkout{}

# Scan products
{:ok, checkout} = MaycowMarket.Checkout.scan(checkout, "GR1")
{:ok, checkout} = MaycowMarket.Checkout.scan(checkout, "SR1")
{:ok, checkout} = MaycowMarket.Checkout.scan(checkout, "CF1")
{:ok, checkout} = MaycowMarket.Checkout.scan(checkout, "SR1")
{:ok, checkout} = MaycowMarket.Checkout.scan(checkout, "SR1")

# View the current state of the checkout
IO.inspect(checkout)

# Calculate the total price
checkout.total
```

## License

Licensed under the MIT License.
