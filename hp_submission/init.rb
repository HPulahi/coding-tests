##### Lonely Planet Booking System
# 
# Launch this ruby file from the command line
# to get started
#

APP_ROOT = File.dirname(__FILE__)

$:.unshift(File.join(APP_ROOT, 'lib') )
require 'Main'

booker = Main.new
booker.execute
