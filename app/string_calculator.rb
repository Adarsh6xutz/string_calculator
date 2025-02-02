class StringCalculator
  class NegativesNotAllowedException < StandardError; end
  MAX_NUMBER = 1000

  def add(numbers)
    return 0 if numbers.empty?

    numbers_array = sanitized_numbers(numbers)
    check_for_negatives(numbers_array)
    return  without_max_number(numbers_array).sum if @delimiter != '*'

    without_max_number(numbers_array).inject(&:*)
  end

  private

  def sanitized_numbers(numbers)
    if numbers.start_with?("//")
      delimiter = numbers[2]
      set_delimiter(delimiter)
      numbers_part = numbers.split("\n", 2)[1]
      numbers_part.gsub(delimiter, ",").split(',').map(&:to_i)
    else
      numbers.gsub("\n", ",").split(',').map(&:to_i)
    end
  end

  def check_for_negatives(numbers)
    negatives = numbers.select { |n| n < 0 }
    raise NegativesNotAllowedException, "negative numbers not allowed: #{negatives.join(',')}" if negatives.any?
  end

  def set_delimiter(delimiter)
    @delimiter = delimiter
  end

  def without_max_number(numbers)
    numbers.select{ |n| n < MAX_NUMBER }
  end
end
