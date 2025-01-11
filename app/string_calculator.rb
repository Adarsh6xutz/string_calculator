class StringCalculator
  def add(numbers)
    return 0 if numbers.empty?

    if numbers.start_with?("//")
      delimiter = numbers[2]
      numbers_part = numbers.split("\n", 2)[1]
      numbers_part.gsub(delimiter, ",").split(',').map(&:to_i).sum
    else
      numbers.gsub("\n", ",").split(',').map(&:to_i).sum
    end
  end
end
