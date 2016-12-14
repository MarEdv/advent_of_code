require "rubygems"
require "bundler"
Bundler.setup

class Day9
end

Dir[File.expand_path(File.dirname(__FILE__) + "/day9/*.rb")].each do |file|
  require file
end