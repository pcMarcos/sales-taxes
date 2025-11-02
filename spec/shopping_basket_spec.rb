# frozen_string_literal: true

require 'rspec'
require_relative '../lib/shopping_basket'
require_relative '../lib/item'

RSpec.describe ShoppingBasket do
  subject(:basket) { ShoppingBasket.new }

  describe '#add_items_from_string' do
    let(:input) { "2 book at 12.49\n1 music CD at 14.99" }

    context 'when handling multiple items' do
      it 'parses multiple items from string input' do
        basket.add_items_from_string(input)

        expect(basket.items.length).to eq(2)
        expect(basket.items[0].name).to eq('book')
        expect(basket.items[0].quantity).to eq(2)
        expect(basket.items[0].price).to eq(12.49)
        expect(basket.items[1].name).to eq('music CD')
        expect(basket.items[1].quantity).to eq(1)
        expect(basket.items[1].price).to eq(14.99)
      end
    end

    context 'when handling single item input' do
      let(:input) { '1 chocolate bar at 0.85' }

      it 'handles single item input' do
        basket.add_items_from_string(input)

        expect(basket.items.length).to eq(1)
        expect(basket.items[0].name).to eq('chocolate bar')
        expect(basket.items[0].quantity).to eq(1)
        expect(basket.items[0].price).to eq(0.85)
      end
    end
  end

  describe '#total_tax' do
    let(:input) { "2 book at 12.49\n1 music CD at 14.99\n1 chocolate bar at 0.85" }

    before { basket.add_items_from_string(input) }

    it 'calculates total tax for all items' do
      expect(basket.total_tax).to eq(1.50)
    end
  end

  describe '#total_price' do
    let(:input) { "2 book at 12.49\n1 music CD at 14.99\n1 chocolate bar at 0.85" }

    before { basket.add_items_from_string(input) }

    it 'calculates total price including tax' do
      expect(basket.total_price).to eq(42.32)
    end
  end
end
