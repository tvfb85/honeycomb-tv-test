require './models/delivery'

describe Delivery do
  subject { Delivery.new :standard, 10 }

  context 'initialize' do

    it 'has a name' do
      expect(subject.name).to eq :standard
    end

    it 'takes a symbol as its name' do
      expect(subject.name).to be_kind_of Symbol
    end

    it 'has a price' do
      expect(subject.price).to eq 10
    end

    it 'takes an integer as price' do
      expect(subject.price).to be_kind_of Integer
    end

  end

end
