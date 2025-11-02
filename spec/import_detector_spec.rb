# frozen_string_literal: true

require 'rspec'
require_relative '../lib/import_detector'

RSpec.describe ImportDetector do
  subject(:detector) { ImportDetector.new }

  describe '#imported?' do
    it 'returns true for imported items' do
      expect(detector.imported?('imported box of chocolates')).to be true
    end

    it 'returns false for non-imported items' do
      expect(detector.imported?('book')).to be false
    end

    it 'is case insensitive' do
      expect(detector.imported?('IMPORTED bottle of perfume')).to be true
    end
  end
end
