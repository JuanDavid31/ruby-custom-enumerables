# spec/enumerables_spec.rb
require 'rspec'
require_relative '../app.rb'

describe 'Enumerables testing' do

  let(:range) { (1..3) }
  let(:array) { [1, 2, 3] }
  let(:predicate_block) { proc { |number| number > 1 } }

  describe '#my_each' do

    it 'does have the same behaviour as #each when a block is given' do
      result = ''
      array.each { |number| result += " #{number} " }
      result2 = ''
      array.my_each { |number| result2 += " #{number} " }
      expect(result).to be_eql(result2)
    end

    context 'When a range is given' do
      it 'does return an Enumerator' do
        expect(range.my_each).to be_an(Enumerator)
      end
    end

    context 'When an array is given' do
      it 'does return an Enumerator' do
        expect(array.my_each).to be_an(Enumerator)
      end
    end

  end

  describe '#my_each_with_index' do

    it 'does have the same behaviour as #each_with_index when a block is given' do
      result = ''
      array.each_with_index { |number, index| result += " #{number}-#{index} " }
      result2 = ''
      array.my_each_with_index { |number, index| result2 += " #{number}-#{index} " }
      expect(result).to be_eql(result2)
    end

    context 'When a range is given' do
      it 'does return an Enumerator' do
        expect(range.my_each_with_index).to be_an(Enumerator)
      end
    end

    context 'When an array is given' do
      it 'does return an Enumerator' do
        expect(array.my_each_with_index).to be_an(Enumerator)
      end
    end

  end

  describe '#my_select' do
    it 'does not change the original array' do
      cloned_array = array.clone
      array.my_select(&predicate_block)
      expect(array).to be_eql cloned_array
    end

    context 'When an array is given' do
      it 'does return an Enumerator' do
        expect(array.my_select).to be_an(Enumerator)
      end

      it 'does filter the same elements' do
        result = array.select(&predicate_block)
        result2 = array.my_select(&predicate_block)
        expect(result).to be_eql result2
      end
    end

    context 'When a range is given' do
      it 'does filter the same elements' do
        result = range.select(&predicate_block)
        result2 = range.my_select(&predicate_block)
        expect(result).to be_eql result2
      end

      it 'does return an Enumerator' do
        expect(range.my_select).to be_an(Enumerator)
      end
    end
  end

  describe '#my_all' do

    context 'No block is given' do
      it 'does return true' do
        expect(array.my_all?).to be true
      end
    end

    context 'When a truthy array is given without a block' do
      it 'does return false' do
        expect(array.all?).to be_eql array.my_all?
      end
    end

    context 'When a falsy array is given without a block' do
      let(:falsy_array) { [false, nil] }

      it 'does return true' do

        expect(falsy_array.all?).to be_eql falsy_array.my_all?
      end
    end

    context 'When a class is given' do
      let(:word_array) { %w[mini portable table] }

      it 'does return true' do
        expect(word_array.all?(String)).to be_eql word_array.my_all? String
      end

      it 'does return false' do
        expect(word_array.all?(Integer)).to be_eql word_array.my_all? Integer
      end
    end
  end

  describe '#my_any' do
    context 'No block is given' do
      it 'does return true' do
        expect(array.my_any?).to be true
      end
    end

    context 'When a truthy array is given without a block' do
      it 'does return true' do
        expect(array.my_any?).to be_eql array.any?
      end
    end

    context 'When a falsy array is given without a block' do
      let(:falsy_array) { [false, nil] }

      it 'does return false' do

        expect(falsy_array.any?).to be_eql falsy_array.my_any?
      end
    end

    context 'When a class is given' do
      let(:word_array) { %w[mini portable table] }

      it 'does return true' do
        expect(word_array.any?(String)).to be_eql word_array.my_any? String
      end

      it 'does return false' do
        expect(word_array.any?(Integer)).to be_eql word_array.my_any? Integer
      end
    end
  end

  describe '#my_none' do

  end

  describe '#my_count' do

  end

  describe '#my_map' do

  end

  describe '#my_inject' do

  end

end