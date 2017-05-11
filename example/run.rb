#!/usr/bin/env ruby

require './models/broadcaster'
require './models/delivery'
require './models/material'
require './models/promos/promo_discount'
require './models/promos/promo_multibuy'
require './models/order'

standard_delivery = Delivery.new(:standard, 10.0)
express_delivery = Delivery.new(:express, 20.0)

broadcaster_1 = Broadcaster.new(1, 'Viacom')
broadcaster_2 = Broadcaster.new(2, 'Disney')
broadcaster_3 = Broadcaster.new(3, 'Discovery')
broadcaster_4 = Broadcaster.new(4, 'ITV')
broadcaster_5 = Broadcaster.new(5, 'Channel 4')
broadcaster_6 = Broadcaster.new(6, 'Bike Channel')
broadcaster_7 = Broadcaster.new(7, 'Horse and Country')

clock_number_one = Material.new('WNP/SWCL001/010')
clock_number_two = Material.new('ZDW/EOWW005/010')

promo_one = PromoMultiBuy.new('Express Multibuy offer', 15)
promo_two = PromoDiscount.new('10 percent off 30', 0, 10)

order = Order.new()

order.add clock_number_one, broadcaster_2, standard_delivery
order.add clock_number_one, broadcaster_3, standard_delivery
order.add clock_number_one, broadcaster_1, standard_delivery
order.add clock_number_one, broadcaster_7, express_delivery
# order.add clock_number_two, broadcaster_2, express_delivery
# order.add clock_number_two, broadcaster_3, express_delivery
# order.add clock_number_two, broadcaster_1, express_delivery

print order.output
print "\n"
