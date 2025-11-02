# frozen_string_literal: true

require 'rspec'
require_relative '../lib/receipt_generator'
require_relative '../lib/shopping_basket'
require_relative '../lib/item'

RSpec.describe ReceiptGenerator do
  subject(:receipt_generator) { ReceiptGenerator.new }
  let(:basket) { ShoppingBasket.new }

  let(:receipt) { receipt_generator.generate_receipt(basket) }

  describe '#generate_receipt' do
    let(:input) { "2 book at 12.49\n1 music CD at 14.99\n1 chocolate bar at 0.85" }
    let(:expected_lines) do
      [
        '2 book: 24.98',
        '1 music CD: 16.49',
        '1 chocolate bar: 0.85',
        'Sales Taxes: 1.50',
        'Total: 42.32'
      ]
    end

    it 'generates correct receipt format' do
      basket.add_items_from_string(input)

      expect(receipt).to eq(expected_lines.join("\n"))
    end

    context 'when handling imported items' do
      let(:input) { "1 imported box of chocolates at 10.00\n1 imported bottle of perfume at 47.50" }
      let(:expected_lines) do
        [
          '1 imported box of chocolates: 10.50',
          '1 imported bottle of perfume: 54.65',
          'Sales Taxes: 7.65',
          'Total: 65.15'
        ]
      end

      it 'handles imported items correctly' do
        basket.add_items_from_string(input)

        expect(receipt).to eq(expected_lines.join("\n"))
      end
    end
  end
end
