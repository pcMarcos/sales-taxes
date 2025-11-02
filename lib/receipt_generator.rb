# frozen_string_literal: true

class ReceiptGenerator
  def generate_receipt(basket)
    lines = basket.items.map do |item|
      item_tax = basket.item_tax(item)
      item_total = item.total_price + item_tax
      "#{item.quantity} #{item.name}: #{format_price(item_total)}"
    end

    lines << "Sales Taxes: #{format_price(basket.total_tax)}"
    lines << "Total: #{format_price(basket.total_price)}"
    lines.join("\n")
  end

  private

  def format_price(amount)
    format('%.2f', amount)
  end
end
