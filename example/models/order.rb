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

  def material_already_in_order?(material)
    items.has_key? material
  end

  def total_cost
    items.inject(0) { |memo, (_, delivery)| memo += delivery.price }
  end

  def output
    [].tap do |result|
      result << "Order summary:"

      result << COLUMNS.map { |name, width| name.to_s.ljust(width) }.join(' | ')
      result << output_separator

      items.each_pair do |k, v|
        v.each do |value|
          result << [
            k.identifier.ljust(COLUMNS[:material]),
            value.broadcaster.name.ljust(COLUMNS[:broadcaster]),
            value.delivery.name.to_s.ljust(COLUMNS[:delivery]),
            ("$#{value.delivery.price}").ljust(COLUMNS[:price])
          ].join(' | ')
        end
      end

      result << output_separator
      result << "Sub-total: $#{sub_total_cost}"
      # result << "Total: $#{total_cost(sub_total_cost)}"
    end.join("\n")
  end

  private

  def sub_total_cost
    sub_total = 0
    items.each_pair { |k, v| sub_total += v.inject(0) { |memo, (_, delivery)| memo += _.delivery.price } }
    sub_total
  end

  def output_separator
    @output_separator ||= COLUMNS.map { |_, width| '-' * width }.join(' | ')
  end
end
