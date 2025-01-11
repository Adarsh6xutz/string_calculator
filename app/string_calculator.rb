class StringCalculator
  class NegativesNotAllowedException < StandardError; end

  def add(numbers)
    return 0 if numbers.empty?

    numbers_array = sanitized_numbers(numbers)
    check_for_negatives(numbers_array)
    numbers_array.sum
  end

  private

  def sanitized_numbers(numbers)
    if numbers.start_with?("//")
      delimiter = numbers[2]
      numbers_part = numbers.split("\n", 2)[1]
      numbers_part.gsub(delimiter, ",").split(',').map(&:to_i).select{ |n| n < 1000 }
    else
      numbers.gsub("\n", ",").split(',').map(&:to_i).select{ |n| n < 1000 }
    end
  end

  def check_for_negatives(numbers)
    negatives = numbers.select { |n| n < 0 }
    raise NegativesNotAllowedException, "negative numbers not allowed: #{negatives.join(',')}" if negatives.any?
  end
end
