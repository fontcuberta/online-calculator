require 'rspec'
require_relative('../lib/calculator.rb')

RSpec.describe('Online Calculator self-corrected exercise') do
  context 'Iteration 1' do
    describe '#add' do
      let(:calculator){ Calculator.new }

      context 'when not valid' do
        it 'receive two parameters' do
          expect(calculator).to respond_to(:add).with(2).argument
        end

        it 'omits the letters as parameters' do
          expect(calculator.add(1, "a")).to eq(1)
        end
      end

      context 'when valid' do
        it 'sums the parameters' do
          expect(calculator.add(1,1)).to eq(2)
        end

        it 'sums the parameters as integers' do
          expect(calculator.add("1", "1")).to eq(2)
        end
      end
    end
  end

  context 'Iteration 2' do
  end

  context 'Iteration 3' do
  end

  context 'Iteration 4' do
  end
end