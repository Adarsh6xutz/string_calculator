require 'spec_helper'
require_relative '../app/string_calculator'

RSpec.describe StringCalculator do
  let(:calculator) { StringCalculator.new }
  
  describe '#add' do
    it 'Should return 0 for empty string' do
      expect(calculator.add("")).to eq(0)
    end

    it 'Should return the number for single number input' do
      expect(calculator.add("1")).to eq(1)
      expect(calculator.add("5")).to eq(5)
    end

    it 'Should return sum for two numbers' do
      expect(calculator.add("1,2")).to eq(3)
      expect(calculator.add("5,7")).to eq(12)
    end

    it 'Should return sum for multiple numbers' do
      expect(calculator.add("1,2,3")).to eq(6)
      expect(calculator.add("5,7,8,10")).to eq(30)
    end

    it 'Should return sum for numbers ignoring new line delimiter' do
      expect(calculator.add("1\n2,3")).to eq(6)
      expect(calculator.add("1,2\n3")).to eq(6)
      expect(calculator.add("1\n2\n3")).to eq(6)
    end
  end
end
