require "rubygems"
require "bundler"
Bundler.setup

class Day12
end

Dir[File.expand_path(File.dirname(__FILE__) + "/day12/*.rb")].each do |file|
  require file
end