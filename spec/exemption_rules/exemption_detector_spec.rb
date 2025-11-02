# frozen_string_literal: true

require 'rspec'
require_relative '../../lib/exemption_rules/exemption_detector'

RSpec.describe ExemptionRules::ExemptionDetector do
  subject(:detector) { ExemptionRules::ExemptionDetector.new(item_keywords) }
  let(:item_keywords) { [['book'], ['chocolate']] }

  describe '#exempt?' do
    it 'returns true if any keyword array matches' do
      expect(detector.exempt?('book')).to be true
      expect(detector.exempt?('chocolate bar')).to be true
      expect(detector.exempt?('music CD')).to be false
    end

    it 'is case insensitive' do
      expect(detector.exempt?('BOOK')).to be true
    end

    context 'with standard detector' do
      subject(:detector) { ExemptionRules::ExemptionDetector.standard }

      it 'returns true if any standard keyword array matches' do
        expect(detector.exempt?('book')).to be true
        expect(detector.exempt?('chocolate bar')).to be true
        expect(detector.exempt?('packet of headache pills')).to be true
        expect(detector.exempt?('music CD')).to be false
      end
    end
  end
end
