# frozen_string_literal: true

require 'rspec'
require_relative '../lib/tax_calculator'
require_relative '../lib/item'

RSpec.describe TaxCalculator do
  subject(:calculator) { TaxCalculator.new }

  let(:tax) { calculator.calculate(item) }
  let(:item) { Item.new(name, price) }

  describe '#calculate' do
    context 'basic sales tax' do
      context 'when the item is not exempt' do
        let(:name) { 'music CD' }
        let(:price) { 14.99 }

        it 'applies 10% tax to non-exempt items' do
          expect(tax).to eq(1.50)
        end
      end

      context 'when the item is exempt' do
        let(:name) { 'book' }
        let(:price) { 12.49 }

        it 'does not apply tax to exempt items' do
          expect(tax).to eq(0.0)
        end
      end
    end

    context 'import duty' do
      context 'when the item is imported' do
        let(:name) { 'imported box of chocolates' }
        let(:price) { 10.00 }

        it 'applies 5% import duty to imported items' do
          expect(tax).to eq(0.50)
        end
      end

      context 'when the item is not imported' do
        let(:name) { 'imported bottle of perfume' }
        let(:price) { 47.50 }

        it 'applies both basic tax and import duty to imported non-exempt items' do
          expect(tax).to eq(7.15)
        end
      end
    end

    context 'rounding' do
      context 'when the tax is not a multiple of 0.05' do
        let(:name) { 'music CD' }
        let(:price) { 14.99 }

        it 'rounds up to nearest 0.05' do
          expect(tax).to eq(1.50)
        end
      end

      context 'when the tax is a multiple of 0.05' do
        let(:name) { 'test item' }
        let(:price) { 1.00 }

        it 'handles exact rounding cases' do
          expect(tax).to eq(0.10)
        end
      end
    end
  end
end
