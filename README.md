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

## License

Licensed under the MIT License.
