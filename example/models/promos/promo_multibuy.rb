class PromoMultiBuy
  attr_accessor :description, :multibuy_discount

  def initialize(description, multibuy_discount)
    self.description = description
    self.multibuy_discount = multibuy_discount
  end

  def qualifies_for_discount(items)
    count_express_items(items) > 1
  end

  def calculate_discount(items)
    count_express_items(items) * multibuy_discount
  end

  def count_express_items(items)
    count = 0
    items.each_pair do |k, v|
      count += v.count { |item| item.delivery.name == :express }
    end
    count
  end

end
