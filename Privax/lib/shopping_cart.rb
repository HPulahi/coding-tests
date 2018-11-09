require 'product'
require 'item'
class ShoppingCart

  def initialize
    @items = []
  end

  def add_item(product, amount)
    item = find_item_in_cart(product) 
    item ? item.quantity += amount : @items << Item.new(name: product, quantity: amount)
  end

  def get_price_of(product)
    product = Product.find(product)
    item    = find_item_in_cart(product.name)
    product.unit_price(item.quantity)
  end

  def get_total_sum
    output_table(@items)
    output_footer
  end

  private

  def find_item_in_cart(product)
    @items.find{ |item| item.name == product }
  end

  def total_price
    item_totals = @items.map{ |item| get_price_of(item.name) * item.quantity }
    item_totals.reduce(:+)
  end

  def output_table(items=[])
    @items.each do |item|
      line =  " " << item.quantity.to_s.ljust(10)
      line << " " + item.name.capitalize.ljust(20)
      line << " lb" + ( get_price_of(item.name) * item.quantity ).to_s.rjust(6)
      puts line
    end
    puts "-" * 40
  end

  def output_footer
    footer = " " << "Total:".ljust(10)
    footer << " " + " ".ljust(20)
    footer << " lb" + total_price.to_s.rjust(6)
    puts footer
  end
end
