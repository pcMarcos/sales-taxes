# frozen_string_literal: true

require_relative 'input_parser'
require_relative 'tax_calculator'

class ShoppingBasket
  attr_reader :items

  def initialize(tax_calculator: TaxCalculator.new)
    @items = []
    @tax_calculator = tax_calculator
  end

  def add_items_from_string(input_string)
    parsed_items = parser.parse_multiple(input_string)
    parsed_items.each { |item| add_item(item) }
  end

  def total_tax
    @items.sum { |item| @tax_calculator.calculate(item) }
  end

  def total_price
    @items.sum(&:total_price) + total_tax
  end

  def item_tax(item)
    @tax_calculator.calculate(item)
  end

  private

  def add_item(item)
    @items << item
  end

  def parser = InputParser.new
end
