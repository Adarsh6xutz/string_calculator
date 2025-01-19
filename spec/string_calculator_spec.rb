require 'spec_helper'
require_relative '../app/string_calculator'

RSpec.describe StringCalculator do
  let(:calculator) { StringCalculator.new }
  
  describe '#add' do
    context 'success' do
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

      it 'should return sum for numbers ignoring any custom delimiters' do
        expect(calculator.add("//;\n1;2")).to eq(3)
        expect(calculator.add("//*\n1*2*3")).to eq(6)
        expect(calculator.add("//|\n1|2|3")).to eq(6)
        expect(calculator.add("//&\n1&2&3")).to eq(6)
      end

      it 'should return sum for numbers ignoring any number greater than 1000' do
        expect(calculator.add("1,2,3,1003")).to eq(6)
        expect(calculator.add("1,2,3,2000")).to eq(6)
      end

      it 'should return sum for numbers ignoring any number greater than 1000 and newline delimiters' do
        expect(calculator.add("1\n2\n3,1003")).to eq(6)
        expect(calculator.add("1\n2,3,2000")).to eq(6)
      end

      it 'should return sum for numbers ignoring any number greater than 1000 and custom delimiters' do
        expect(calculator.add("//;\n1;2;2000")).to eq(3)
      end

      it 'should return product for numbers if the delimiter is *' do
        expect(calculator.add("//*\n1*2*4")).to eq(8)
        expect(calculator.add("//*\n1*2*3*1002")).to eq(6)
      end
    end

    context 'failure' do
      it 'Should raise exception for negative numbers' do
        expect { calculator.add("-1,2") }.to raise_error(
                                               StringCalculator::NegativesNotAllowedException,
                                               "negative numbers not allowed: -1"
                                             )
      end

      it 'Should raise exception with all negative numbers in message' do
        expect { calculator.add("2,-4,3,-5") }.to raise_error(
                                                    StringCalculator::NegativesNotAllowedException,
                                                    "negative numbers not allowed: -4,-5"
                                                  )
      end

      it 'Should raise exception with all negative numbers in message ignoring the newline delimiter' do
        expect { calculator.add("2\n-4\n3\n-5,7") }.to raise_error(
                                                         StringCalculator::NegativesNotAllowedException,
                                                         "negative numbers not allowed: -4,-5"
                                                       )
      end

      it 'Should raise exception with all negative numbers in message ignoring the custom delimiter' do
        expect { calculator.add("//;\n1;2;-3") }.to raise_error(
                                                      StringCalculator::NegativesNotAllowedException,
                                                      "negative numbers not allowed: -3"
                                                    )
      end
    end

    context 'test stub' do

      it 'Should return numbers without any delimiters' do
        allow_any_instance_of(StringCalculator).to receive(:sanitized_numbers).and_return([1,2,3])
        expect(calculator.add("1,2")).to eq(6)
      end
    end
  end
end
