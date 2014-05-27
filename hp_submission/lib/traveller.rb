require 'accommodation'
require 'support/number_helper'
class Traveller
  include NumberHelper
  
  @@saved_accommodations = [] 
   
  attr_accessor :id, :name, :priceRange, :requirements, :accommodation_id, :accommodation_name
  
  def initialize( id, name, priceRange, requirements )
    @id               =  id
    @name             =  name
    @priceRange       =  priceRange
    @requirements     =  requirements
  end
  
  def self.process
    Traveller.create_travellers
    Traveller.create_accommodations
    @travellers.each do |traveller|
      @accommodations.each do |accommodation|
        if accommodation.is_suitable_match?(traveller.priceRange) then traveller.assign(accommodation); break; end;
      end
    end
  end
  
  def self.create_travellers
    json = File.read('data/travellers.json')
    travellers = JSON.parse(json)
    @travellers = []   
    travellers.each do |traveller|
     @travellers << Traveller.new(traveller['id'], traveller['name'], traveller['priceRange'], traveller['requirements'] )
    end
    return @travellers
  end
  
  def self.create_accommodations
    json = File.read('data/accommodation.json')
    accommodations = JSON.parse(json)
    @accommodations = []   
    accommodations.each do |accommodation|
     @accommodations <<  Accommodation.new(accommodation['id'], accommodation['name'], accommodation['price'], accommodation['attributes'], accommodation['capacity'])
    end
    return @accommodations
  end
  
  def assign(accommodation)
    self.accommodation_id = accommodation.id
    self.accommodation_name = accommodation.name
    adjust_capacities_for(accommodation)
    book_traveller_into(accommodation)
    save_the_accommodation(accommodation)
  end
  
  def self.saved_accommodations
    @@saved_accommodations
  end
    
  def book_traveller_into(accommodation)
    accommodation.bookings << self
  end
  
  def adjust_capacities_for(accommodation)
    accommodation.capacity['free'] -= 1
  end

  def save_the_accommodation(accommodation)
    @@saved_accommodations << accommodation
  end
  
end

#puts "#{self.accommodation_id} -- b: #{accommodation.bookings.size} -- Capacity: #{accommodation.capacity['free']} -- Name: #{accommodation.name} --#{accommodation.price} -- #{self.name} -- #{self.priceRange['min']} ---- #{self.priceRange['max']}"
