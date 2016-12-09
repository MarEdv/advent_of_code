require "rubygems"
require "bundler"

Bundler.setup

class Day6
end

Dir[File.expand_path(File.dirname(__FILE__) + "/day6/*.rb")].each do |file|
  require file
end