class PromoDiscount
  attr_accessor :description, :min_spend, :pct_discount

  def initialize(description, min_spend, pct_discount)
    self.description = description
    self.min_spend = min_spend
    self.pct_discount = pct_discount
  end

  def qualifies_for_discount(order)
    order.total_cost > min_spend
  end

  def calculate_discount(order)
    order.total_cost / pct_discount
  end

end
