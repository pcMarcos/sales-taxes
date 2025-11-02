# frozen_string_literal: true

class Item
  attr_reader :name, :price, :quantity

  def initialize(name, price, quantity = 1)
    @name = name.strip
    @price = price.to_f
    @quantity = quantity.to_i
  end

  def total_price
    @price * @quantity
  end
end
