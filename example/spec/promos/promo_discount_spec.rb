require './models/promos/promo_discount'

describe PromoDiscount do
  subject { PromoDiscount.new '10 percent off 30', 30, 10 }
  let(:order) { Order.new promo_one, subject }
  let(:promo_one) { PromoMultiBuy.new 'Express Multibuy Offer', 15 }
  let(:material) { Material.new 'HON/TEST001/010' }
  let(:broadcaster_1) { Broadcaster.new(1, 'Viacom') }
  let(:broadcaster_2) { Broadcaster.new(2, 'Disney') }
  let(:express_delivery) { Delivery.new(:express, 20) }

  it 'has an offer description' do
    expect(subject.description).to eq '10 percent off 30'
  end

  it 'knows the qualifying spend for the offer' do
    expect(subject.min_spend).to eq 30
  end

  it 'knows the percentage discount on offer' do
    expect(subject.pct_discount).to eq 10
  end

  context 'order does not qualify' do

    it 'knows when the order does not qualify' do
      sub_total_cost = 0
      expect(subject.qualifies_for_discount(sub_total_cost)).to eq false
    end

  end

  context 'order qualifies' do

    before(:each) do
      order.add material, broadcaster_1, express_delivery
      order.add material, broadcaster_2, express_delivery
    end

    it 'checks whether the order qualifies for discount' do
      sub_total_cost = 40
      expect(subject.qualifies_for_discount(sub_total_cost)).to eq true
    end

    it 'calculates the discount' do
      sub_total_cost = 40
      expect(subject.calculate_discount(sub_total_cost)).to eq 4
    end

  end

end
