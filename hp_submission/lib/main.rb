require "rubygems"
require 'json/pure'
require 'traveller'
require 'support/string_extend'
class Main
  
  class Config
   @@actions = ['list', 'find', 'search', 'quit']
   def self.actions
    @@actions
   end
  end
  
  def initialize 
    @travellers = Traveller.process
  end
 
  def execute
    introduction
    result = nil
    until result == :quit
      action, args = get_action
      result = do_action( action, args )
    end
    conclusion
  end
    
  def introduction
    puts "\n\n<<< Welcome to the Lonely Planet Booking System >>>>\n\n"
    puts "This is an Interactive Accommodation Matching System to help you find the best play to stay!\n\n"
  end
  
  def get_action
    action = nil
    until Main::Config.actions.include?(action)
      puts "Actions " + Main::Config.actions.join(", ") if action
      print "> "
      user_response = gets.chomp
      args = user_response.downcase.strip.split(' ')
      action = args.shift
    end
    return action, args
  end
  
  def do_action(action, args=[])
    case action
    when 'list'
      accommodation_id = args.shift
      list(accommodation_id)
    when 'search'
      min_price, max_price, requirement_1, requirement_2, requirement_3 = args
      search(min_price, max_price, requirement_1, requirement_2)
    when 'find'
      keyword = args.shift
      find(keyword)
    when 'quit'
      return :quit
    else 
      puts 'I dont understand that command'
    end
  end
  
  def search( min_price, max_price, requirement_1=nil, requirement_2=nil )
    output_action_header("Best Matches Accommodations")
    if min_price && max_price
      accommodations = Traveller.saved_accommodations.uniq
      found = accommodations.select do |accommodation|
        accommodation.price.to_i >= min_price.to_i && accommodation.price.to_i <= max_price.to_i ||
        accommodation.attributes.include?(requirement_1) || accommodation.attributes.include?(requirement_2)
      end
      output_search_table(found)
    elsif min_price
      puts "Please enter a minimum price AND a maximum price to use this search tool properly"
    else
      puts "Find the your best accommodation match, by using an the correct format"
      puts "Examples: '120 150 internet'\n\n"
    end  
  end
  
  def list(accommodation_id)
    output_action_header("Listing Accommodations")
    if accommodation_id
      accommodations = Traveller.saved_accommodations.uniq
      found = accommodations.select do |accommodation|
        accommodation.id.to_i == accommodation_id.to_i
      end    
      output_list_table(found)
    else
      puts "Find the your best accommodation match, by using an id number"
      puts "Examples: 'list 12345'\n\n"
    end    
  end
  
  def find(keyword="")
    output_action_header("Find the best Accommodation")
    if keyword
      accommodations = Traveller.saved_accommodations.uniq
      found = accommodations.select do |accommodation|
        accommodation.name.downcase.include?(keyword.downcase) || accommodation.price.to_i <= keyword.to_i
      end
      output_table(found)
    else
      puts "Find the your best accommodation match, using price and requirements\n\n"
    end
  end 
   
  def conclusion
    puts "\n\n<<< Goodbye and Happy Travelling!! >>>>\n\n\n"
  end
  
  private 
  
  def output_action_header(text)
    puts "\n#{text.upcase.center(60)}\n\n"
  end
  
  def output_table(accommodations=[])
    print " " + "Name".ljust(30)
    print " " + "Capacity".rjust(20)
    print " " + "Price".rjust(6) + "\n"
    puts "-" * 60
    accommodations.each do |accommodation|
      line =  " " << accommodation.name.titleize.ljust(30)
      line << " " + accommodation.name.titleize.ljust(20)
      line << " " + accommodation.formatted_price.rjust(6)
      puts line
    end
    puts "-" * 60
  end
  
  def output_list_table(accommodations=[])
    print " " + "Accommodation Name".ljust(15)
    print " " + "Bookings".rjust(15)
    print " " + "Free Capacity".rjust(15) + "\n"
    puts "-" * 60
    accommodations.each do |accommodation|
      line =  " " << "#{accommodation.name.titleize.ljust(15)}"
      line << " " +  "#{accommodation.bookings.size.to_s.rjust(15)}"
      line << " " +  "#{accommodation.capacity['free'].to_s.rjust(15)}" + "\n"
      puts line
      puts "-" * 60
      print " " + "Features".ljust(15)  + "\n"
      puts "-" * 60
      "#{accommodation.attributes.each {|a| puts a + "\n"}}"
    end
    puts "-" * 60
  end
  
  def output_search_table(accommodations=[])
    print " " + "Accommodation Name".ljust(20)
    print " " + "Free Capacity".rjust(20) 
    print " " + "Price".rjust(10) + "\n"
    puts "-" * 60
    accommodations.each do |accommodation|
      line =  " " << "#{accommodation.name.titleize.ljust(20)}"
      line << " " +  "#{accommodation.capacity['free'].to_s.rjust(20)}" 
      line << " " + accommodation.formatted_price.rjust(10) + "\n"
      puts line
    end
    puts "-" * 60
  end
end
