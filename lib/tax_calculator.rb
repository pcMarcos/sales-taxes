# frozen_string_literal: true

require_relative 'exemption_rules/exemption_detector'
require_relative 'import_detector'
require_relative 'tax_config'

class TaxCalculator
  def initialize(
    exemption_detector: ExemptionRules::ExemptionDetector.standard,
    import_detector: ImportDetector.new
  )
    @exemption_detector = exemption_detector
    @import_detector = import_detector
  end

  def calculate(item)
    basic_tax = basic_tax(item)
    import_tax = import_tax(item)

    rounded_basic = round_up_to_5_cents(basic_tax)
    rounded_import = round_up_to_5_cents(import_tax)

    (rounded_basic + rounded_import) * item.quantity
  end

  private

  def basic_tax(item)
    @exemption_detector.exempt?(item.name) ? 0.0 : item.price * TaxConfig::BASIC_SALES_TAX_RATE
  end

  def import_tax(item)
    @import_detector.imported?(item.name) ? item.price * TaxConfig::IMPORT_DUTY_RATE : 0.0
  end

  def round_up_to_5_cents(amount)
    (amount / TaxConfig::ROUNDING_INCREMENT).ceil * TaxConfig::ROUNDING_INCREMENT
  end
end
