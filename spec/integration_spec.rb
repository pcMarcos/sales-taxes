# frozen_string_literal: true

require 'rspec'
require_relative '../lib/shopping_basket'
require_relative '../lib/receipt_generator'

RSpec.describe 'Integration Tests' do
  let(:basket) { ShoppingBasket.new }
  let(:receipt_generator) { ReceiptGenerator.new }
  let(:receipt) { receipt_generator.generate_receipt(basket) }

  describe 'Test Case 1' do
    let(:input) do
      <<~INPUT.chomp
        2 book at 12.49
        1 music CD at 14.99
        1 chocolate bar at 0.85
      INPUT
    end
    let(:expected) do
      <<~EXPECTED.chomp
        2 book: 24.98
        1 music CD: 16.49
        1 chocolate bar: 0.85
        Sales Taxes: 1.50
        Total: 42.32
      EXPECTED
    end

    it 'matches expected output exactly' do
      basket.add_items_from_string(input)

      expect(receipt).to eq(expected)
    end
  end

  describe 'Test Case 2' do
    let(:input) { "1 imported box of chocolates at 10.00\n1 imported bottle of perfume at 47.50" }
    let(:expected) do
      <<~EXPECTED.chomp
        1 imported box of chocolates: 10.50
        1 imported bottle of perfume: 54.65
        Sales Taxes: 7.65
        Total: 65.15
      EXPECTED
    end

    it 'matches expected output exactly' do
      basket.add_items_from_string(input)

      expect(receipt).to eq(expected)
    end
  end

  describe 'Test Case 3' do
    let(:input) do
      <<~INPUT.chomp
        1 imported bottle of perfume at 27.99
        1 bottle of perfume at 18.99
        1 packet of headache pills at 9.75
        3 imported boxes of chocolates at 11.25
      INPUT
    end
    let(:expected) do
      <<~EXPECTED.chomp
        1 imported bottle of perfume: 32.19
        1 bottle of perfume: 20.89
        1 packet of headache pills: 9.75
        3 imported boxes of chocolates: 35.55
        Sales Taxes: 7.90
        Total: 98.38
      EXPECTED
    end

    it 'matches expected output exactly' do
      basket.add_items_from_string(input)

      expect(receipt).to eq(expected)
    end
  end
end
