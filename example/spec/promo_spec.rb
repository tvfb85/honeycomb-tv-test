require './models/promo'

describe Promo do

  describe 'discount one' do
    subject { Promo.new 'Express Multibuy Offer'}

    it 'has a description' do
      expect(subject.description).to eq 'Express Multibuy Offer'
    end

  end

  describe 'discount two' do
    subject { Promo.new '10 percent off 30'}

    it 'has a description' do
      expect(subject.description).to eq '10 percent off 30'
    end

  end

end
