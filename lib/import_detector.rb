# frozen_string_literal: true

class ImportDetector
  IMPORT_KEYWORD = 'imported'

  def imported?(item_name)
    item_name.downcase.include?(IMPORT_KEYWORD)
  end
end
