class Order
  COLUMNS = {
    material: 20,
    broadcaster: 20,
    delivery: 8,
    price: 8
  }.freeze

  attr_accessor :promo_one, :promo_two, :items

  def initialize(promo_one, promo_two)
    self.promo_one = promo_one
    self.promo_two = promo_two
    self.items = {}
  end

  def add(material, broadcaster, delivery)
    material_already_in_order?(material) ? items[material] << Item.new(broadcaster, delivery) : items[material] = [Item.new(broadcaster, delivery)]
  end

  def output
    [].tap do |result|
      result << "Order summary:"

      result << COLUMNS.map { |name, width| name.to_s.ljust(width) }.join(' | ')
      result << output_separator

      items.each_pair do |clock_num, sub_items|
        sub_items.each do |sub_item|
          result << [
            clock_num.identifier.ljust(COLUMNS[:material]),
            sub_item.broadcaster.name.ljust(COLUMNS[:broadcaster]),
            sub_item.delivery.name.to_s.ljust(COLUMNS[:delivery]),
            ("$#{sub_item.delivery.price}").ljust(COLUMNS[:price])
          ].join(' | ')
        end
      end

      result << output_separator
      result << "Sub-total: $#{sub_total_cost}"
      result << "Total: $#{total_cost(sub_total_cost)}"
    end.join("\n")
  end

  private

  def material_already_in_order?(material)
    items.has_key? material
  end

  def sub_total_cost
    sub_total = 0
    items.each_pair { |clock_num, sub_items| sub_total += sub_items.inject(0) { |memo, (_, delivery)| memo += _.delivery.price } }
    sub_total
  end

  def total_cost(sub_total)
    items.empty? == true ? 0 : apply_discounts(sub_total)
  end

  def apply_discounts(sub_total)
    sub_total -= apply_promo_one
    sub_total -= apply_promo_two(sub_total)
  end

  def apply_promo_one
    promo_one.qualifies_for_discount(items) ? promo_one.calculate_discount(items) : 0
  end

  def apply_promo_two(sub_total)
    promo_two.qualifies_for_discount(sub_total) ? promo_two.calculate_discount(sub_total) : 0
  end

  def output_separator
    @output_separator ||= COLUMNS.map { |_, width| '-' * width }.join(' | ')
  end
end
