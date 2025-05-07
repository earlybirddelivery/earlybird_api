class QuantityPattern < ApplicationRecord

  validate :validate_pattern

  private

  def validate_pattern
    if day4_quantity
      valid = day1_quantity && day2_quantity && day3_quantity
    elsif day3_quantity
      valid = day1_quantity && day2_quantity
    elsif day2_quantity
      valid = day2_quantity
    else
      raise(ArgumentError, 'Please provide atleast 2 days pattern')
    end

    return if valid

    raise(ArgumentError, 'Please provide valid day pattern')
  end
end
