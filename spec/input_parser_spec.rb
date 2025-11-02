# frozen_string_literal: true

require 'rspec'
require_relative '../lib/input_parser'
require_relative '../lib/item'

RSpec.describe InputParser do
  subject(:parser) { InputParser.new }

  describe '#parse_multiple' do
    let(:items) { parser.parse_multiple(input) }
    let(:input) { "2 book at 12.49\n1 music CD at 14.99" }

    it 'parses multiple lines' do
      expect(items.length).to eq(2)
      expect(items[0].name).to eq('book')
      expect(items[0].quantity).to eq(2)
      expect(items[0].price).to eq(12.49)
      expect(items[1].name).to eq('music CD')
    end

    context 'when the input is invalid' do
      let(:input) { "2 book at 12.49\ninvalid input\n1 music CD at 14.99" }

      it 'filters out invalid lines' do
        expect(items.length).to eq(2)
        expect(items[0].name).to eq('book')
        expect(items[1].name).to eq('music CD')
      end
    end
  end
end
