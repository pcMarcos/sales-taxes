# frozen_string_literal: true

require_relative 'item'

class InputParser
  INPUT_PATTERN = /^(\d+)\s+(.+?)\s+at\s+(\d+\.?\d*)$/

  def parse_multiple(input_string)
    input_string.strip.split("\n").map { |line| parse_line(line) }.compact
  end

  private

  def parse_line(line)
    match = line.match(INPUT_PATTERN)
    return nil unless match

    quantity, name, price = match.captures

    create_item(quantity, name, price)
  end

  def create_item(quantity, name, price)
    Item.new(name, price, quantity)
  end
end
