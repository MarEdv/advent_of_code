require "rubygems"
require "bundler"
Bundler.setup

class Day10
end

Dir[File.expand_path(File.dirname(__FILE__) + "/day10/*.rb")].each do |file|
  require file
end