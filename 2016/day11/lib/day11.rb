require "rubygems"
require "bundler"
Bundler.setup

class Day11
end

Dir[File.expand_path(File.dirname(__FILE__) + "/day11/*.rb")].each do |file|
  require file
end