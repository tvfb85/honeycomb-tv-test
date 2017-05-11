require './models/broadcaster'

describe Broadcaster do
  subject { Broadcaster.new 1, 'Viacom' }

  context 'initialize' do

    it 'has an id' do
      expect(subject.id).to eq 1
    end

    it 'takes a number as its id' do
      expect(subject.id).to be_kind_of Integer
    end

    it 'has a name' do
      expect(subject.name).to eq 'Viacom'
    end

    it 'takes a string as its name' do
      expect(subject.name).to be_kind_of String
    end

  end

end
