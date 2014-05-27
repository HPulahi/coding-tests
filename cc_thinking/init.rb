##### Concurrent Thinking
# 
# Launch this ruby file from the command line
# to get started
#
APP_ROOT = File.dirname(__FILE__)

$:.unshift(File.join(APP_ROOT, 'lib') )
require 'App'

DataCenterApi::App.run