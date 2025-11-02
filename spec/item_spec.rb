# frozen_string_literal: true

require 'rspec'
require_relative '../lib/item'

RSpec.describe Item do
  let(:name) { 'book' }
  let(:price) { 12.49 }

  describe '#initialize' do
    context 'when all the parameters are provided' do
      subject(:item) { Item.new(name, price, quantity) }

      let(:quantity) { 2 }

      it 'creates an item with name, price, and quantity' do
        expect(item.name).to eq(name)
        expect(item.price).to eq(price)
        expect(item.quantity).to eq(quantity)
      end
    end

    context 'when the quantity is not provided' do
      subject(:item) { Item.new(name, price) }

      it 'defaults quantity to 1' do
        expect(item.quantity).to eq(1)
      end

      context 'when the name has whitespace' do
        let(:name) { '  book  ' }

        it 'strips whitespace from name' do
          expect(item.name).to eq('book')
        end
      end
    end
  end

  describe '#total_price' do
    let(:item) { Item.new(name, price, 2) }

    it 'calculates total price correctly' do
      expect(item.total_price).to eq(24.98)
    end
  end
end
