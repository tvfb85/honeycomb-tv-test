class PromoMultiBuy
  attr_accessor :description, :multibuy_price

  def initialize(description, multibuy_price)
    self.description = description
    self.multibuy_price = multibuy_price
  end

  def qualifies_for_discount(order)
    count_express_items(order) > 1
  end

  def calculate_discount(order)
    count_express_items(order) * multibuy_price
  end

  def count_express_items(order)
    order.items.count { |item| item.delivery.name == :express }
  end

end
