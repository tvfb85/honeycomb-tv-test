require './models/promos/promo_multibuy'

describe PromoMultiBuy do
  subject { PromoMultiBuy.new 'Express Multibuy Offer', 15}
  let(:order) { Order.new material }
  let(:material) { Material.new 'HON/TEST001/010' }
  let(:broadcaster_1) { Broadcaster.new(1, 'Viacom') }
  let(:broadcaster_2) { Broadcaster.new(2, 'Disney') }
  let(:express_delivery) { Delivery.new(:express, 20) }

  it 'has a description' do
    expect(subject.description).to eq 'Express Multibuy Offer'
  end

  it 'has a discount price' do
    expect(subject.multibuy_price).to eq 15
  end

  context 'order does not qualify' do

    it 'knows when the order does not qualify' do
      expect(subject.qualifies_for_discount(order)).to eq false
    end

  end

  context 'order qualifies' do

    before(:each) do
      order.add broadcaster_1, express_delivery
      order.add broadcaster_2, express_delivery
    end

    it 'checks whether the order qualifies for discount' do
      expect(subject.qualifies_for_discount(order)).to eq true
    end

    it 'calculates the discount' do
      expect(subject.calculate_discount(order)).to eq 10
    end

  end

end
