# Sales Tax Calculator

Simple calculator for sales tax and import duty on shopping items.

## Usage

Input items like this:
```
1 book at 12.49
2 imported chocolates at 10.00
```

Rates:
- 10% basic sales tax (skipped for books, food, medicine)
- 5% import duty on imported items

Output shows each item with tax, total tax, and final total.

## Running

Test cases:
```bash
ruby main.rb
```

Tests:
```bash
bundle exec rspec
```

## Notes

Code is split into a few modules - tax calculation logic is separated from parsing and receipt generation. Exemptions are checked by matching keywords in item names. Tax rates are in `TaxConfig` if you need to tweak them.
