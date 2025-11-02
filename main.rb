# frozen_string_literal: true

require_relative 'lib/item'
require_relative 'lib/tax_calculator'
require_relative 'lib/shopping_basket'
require_relative 'lib/receipt_generator'
require_relative 'lib/input_parser'

class SalesTaxApp
  def self.run_test_cases
    puts 'Sales Tax Calculator - Test Cases'
    puts '=' * 50

    test_cases = [
      {
        name: 'Input 1',
        input: "2 book at 12.49\n1 music CD at 14.99\n1 chocolate bar at 0.85",
        expected_output: "2 book: 24.98\n1 music CD: 16.49\n1 chocolate bar: 0.85\nSales Taxes: 1.50\nTotal: 42.32"
      },
      {
        name: 'Input 2',
        input: "1 imported box of chocolates at 10.00\n1 imported bottle of perfume at 47.50",
        expected_output: "1 imported box of chocolates: 10.50\n" \
                          "1 imported bottle of perfume: 54.65\n" \
                          "Sales Taxes: 7.65\nTotal: 65.15"
      },
      {
        name: 'Input 3',
        input: "1 imported bottle of perfume at 27.99\n" \
               "1 bottle of perfume at 18.99\n" \
               "1 packet of headache pills at 9.75\n" \
               '3 imported boxes of chocolates at 11.25',
        expected_output: "1 imported bottle of perfume: 32.19\n" \
                          "1 bottle of perfume: 20.89\n" \
                          "1 packet of headache pills: 9.75\n" \
                          "3 imported boxes of chocolates: 35.55\n" \
                          "Sales Taxes: 7.90\nTotal: 98.38"
      }
    ]

    test_cases.each_with_index do |test_case, _index|
      puts "\n#{test_case[:name]}:"
      puts '-' * 20

      basket = ShoppingBasket.new
      basket.add_items_from_string(test_case[:input])

      receipt_generator = ReceiptGenerator.new
      receipt = receipt_generator.generate_receipt(basket)
      puts receipt

      if receipt.strip == test_case[:expected_output].strip
        puts "\033[32mTEST CASE PASSED\033[0m"
      else
        puts "\033[31mTEST CASE FAILED\033[0m"
        puts 'Expected:'
        puts test_case[:expected_output]
        puts 'Got:'
        puts receipt
      end
    end
  end
end

SalesTaxApp.run_test_cases if __FILE__ == $PROGRAM_NAME
