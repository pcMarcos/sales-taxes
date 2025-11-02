# frozen_string_literal: true

module ExemptionRules
  class ExemptionDetector
    def initialize(keyword_arrays = [])
      @keyword_arrays = keyword_arrays
    end

    def exempt?(item_name)
      item_name_lower = item_name.downcase
      @keyword_arrays.any? do |keywords|
        keywords.any? { |keyword| item_name_lower.include?(keyword) }
      end
    end

    def self.standard
      require_relative 'products_keywords'
      new([ProductsKeywords::BOOK_KEYWORDS,
           ProductsKeywords::FOOD_KEYWORDS,
           ProductsKeywords::MEDICAL_KEYWORDS])
    end
  end
end
