require './models/material'

describe Material do
  subject { Material.new 'WNP/SWCL001/010'}

  it 'has an identifier' do
    expect(subject.identifier).not_to be_empty
  end

end
