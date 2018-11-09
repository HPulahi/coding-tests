#### Privax Shopping Cart ###
#
# Created by Herjit Pulahi
#

APP_ROOT = File.dirname(__FILE__)

$:.unshift( File.join(APP_ROOT, 'lib') )
require 'shopping_cart'

filepath = "./data/products.json"
Product.load(filepath)
