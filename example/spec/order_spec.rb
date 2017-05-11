require './models/broadcaster'
require './models/delivery'
require './models/material'
require './models/item'
require './models/order'

describe Order do
  subject { Order.new promo_one, promo_two }
  let(:promo_one) { PromoMultiBuy.new 'Express Multibuy Offer', 15 }
  let(:promo_two) { PromoDiscount.new '10 percent off 30', 30, 10 }
  let(:material) { Material.new 'HON/TEST001/010' }
  let(:standard_delivery) { Delivery.new(:standard, 10) }
  let(:express_delivery) { Delivery.new(:express, 20) }

  context 'empty' do
    it 'costs nothing' do
      expect(subject.total_cost).to eq(0)
    end
  end

  context 'with items' do
    it 'returns the total cost of all items' do
      broadcaster_1 = Broadcaster.new(1, 'Viacom')
      broadcaster_2 = Broadcaster.new(2, 'Disney')

      subject.add material, broadcaster_1, standard_delivery
      subject.add material, broadcaster_2, standard_delivery

      expect(subject.total_cost).to eq(20)
    end
  end
end
