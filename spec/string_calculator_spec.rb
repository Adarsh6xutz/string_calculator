require 'spec_helper'
require_relative '../app/string_calculator'

RSpec.describe StringCalculator do
  let(:calculator) { StringCalculator.new }
  
  describe '#add' do
    it 'returns 0 for empty string' do
      expect(calculator.add("")).to eq(0)
    end
  end
end
