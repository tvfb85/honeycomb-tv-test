describe 'Features' do
  let(:order) { Order.new promo_one, promo_two }

  let(:promo_one) { PromoMultiBuy.new('Express Multibuy offer', 5) }
  let(:promo_two) { PromoDiscount.new('10 percent off 30', 30, 10) }

  let(:broadcaster_1) { Broadcaster.new(1, 'Viacom') }
  let(:broadcaster_2) { Broadcaster.new(2, 'Disney') }
  let(:broadcaster_3) { Broadcaster.new(3, 'Discovery') }
  let(:broadcaster_4) { Broadcaster.new(4, 'ITV') }
  let(:broadcaster_5) { Broadcaster.new(5, 'Channel 4') }
  let(:broadcaster_6) { Broadcaster.new(6, 'Bike Channel') }
  let(:broadcaster_7) { Broadcaster.new(7, 'Horse and Country') }

  let(:clock_number_one) { Material.new 'WNP/SWCL001/010' }
  let(:clock_number_two) { Material.new 'ZDW/EOWW005/010' }

  let(:standard_delivery) { Delivery.new(:standard, 10.0) }
  let(:express_delivery) { Delivery.new(:express, 20.0) }

  it 'checks example one is valid' do
    order.add clock_number_one, broadcaster_2, standard_delivery
    order.add clock_number_one, broadcaster_3, standard_delivery
    order.add clock_number_one, broadcaster_1, standard_delivery
    order.add clock_number_one, broadcaster_7, express_delivery

    expect(order.output).to include "Total: $45"
  end

  it 'checks example two is valid' do
    order.add clock_number_two, broadcaster_2, express_delivery
    order.add clock_number_two, broadcaster_3, express_delivery
    order.add clock_number_two, broadcaster_1, express_delivery

    expect(order.output).to include "Total: $40.5"
  end

  it 'calculates the correct price for mixed orders' do
    order.add clock_number_one, broadcaster_2, standard_delivery
    order.add clock_number_one, broadcaster_1, standard_delivery
    order.add clock_number_one, broadcaster_3, express_delivery
    order.add clock_number_two, broadcaster_2, express_delivery
    order.add clock_number_two, broadcaster_7, standard_delivery
    order.add clock_number_two, broadcaster_1, express_delivery
    order.add clock_number_two, broadcaster_5, standard_delivery

    expect(order.output).to include "Total: $76.5"
  end

end
