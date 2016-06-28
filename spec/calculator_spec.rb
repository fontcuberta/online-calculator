require 'rspec'
require 'rack/test'
require_relative('../lib/calculator.rb')

RSpec.describe('Online Calculator self-corrected exercise') do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  let(:calculator){ Calculator.new }

  context 'Iteration 1' do
    describe '#add' do
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
    describe '#substract' do
      context 'when not valid' do
        it 'receive two parameters' do
          expect(calculator).to respond_to(:substract).with(2).argument
        end

        it 'omits the letters as parameters' do
          expect(calculator.substract(1, "a")).to eq(1)
        end
      end

      context 'when valid' do
        it 'substracts the parameters' do
          expect(calculator.substract(1,1)).to eq(0)
        end

        it 'substracts the parameters as integers' do
          expect(calculator.substract("1", "1")).to eq(0)
        end
      end
    end

    describe '#multiply' do
      context 'when not valid' do
        it 'receive two parameters' do
          expect(calculator).to respond_to(:multiply).with(2).argument
        end

        it 'omits the letters as parameters' do
          expect(calculator.multiply(1, "a")).to eq(0)
        end
      end

      context 'when valid' do
        it 'multiplies the parameters' do
          expect(calculator.multiply(1,1)).to eq(1)
        end

        it 'multiplies the parameters as integers' do
          expect(calculator.multiply("1", "1")).to eq(1)
        end
      end
    end

    describe '#divide' do
      context 'when not valid' do
        it 'receive two parameters' do
          expect(calculator).to respond_to(:divide).with(2).argument
        end

        it 'omits the letters as parameters' do
          expect(calculator.divide("a", 1)).to eq(0)
        end
      end

      context 'when valid' do
        it 'divides the parameters' do
          expect(calculator.divide(4, 2)).to eq(2)
        end

        it 'divides the parameters as integers' do
          expect(calculator.divide("4", "2")).to eq(2)
        end

        it 'returns "INFINITE" where the second parameter is 0' do
          expect(calculator.divide(1, 0)).to eq('INFINITE')
        end

        it 'returns "INFINITE" where the second parameter is a letter' do
          expect(calculator.divide(1, "a")).to eq('INFINITE')
        end
      end
    end
  end

  context 'Iteration 3' do
  end

  context 'Iteration 4' do
  end
end