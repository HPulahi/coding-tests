require 'support/number_helper'
class Accommodation
  include NumberHelper
  
  attr_accessor :id, :name, :price, :attributes, :capacity

  def initialize(id, name, price, attributes, capacity)
    @id               =  id
    @name             =  name
    @price            =  price
    @attributes       =  attributes
    @capacity         =  capacity
    @bookings         =  []
  end
  
  def is_suitable_match?(priceRange)
    return false unless within_travellers_price_range(priceRange)
    # return false unless has_all_traveller_requirements?
    return false unless has_capacity?
    return true
  end
  
  def within_travellers_price_range(priceRange)
    (priceRange['min']..priceRange['max']).include?(self.price)
  end
  
  def has_all_traveller_requirements?
    # make sure the accommodation requirements array includes all the traveller requirements array elements
    # return false unless traveller.requirements == self.attributes
  end
  
  def has_capacity?
    true if self.capacity['free'] != 0
  end

  def bookings
    @bookings
  end
  
  def formatted_price
    number_to_currency(@price)
  end
end