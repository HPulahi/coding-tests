class Item
  attr_accessor :name, :quantity

  def initialize(args={})
    @name     = args[:name]
    @quantity = args[:quantity]
  end

end
