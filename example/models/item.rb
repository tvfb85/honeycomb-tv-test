class Item
  attr_accessor :broadcaster, :delivery

  def initialize(broadcaster, delivery)
    self.broadcaster = broadcaster
    self.delivery = delivery
  end

end
