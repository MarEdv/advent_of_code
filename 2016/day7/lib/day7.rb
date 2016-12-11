require "rubygems"
require "bundler"
Bundler.setup

class Day7
end

Dir[File.expand_path(File.dirname(__FILE__) + "/day7/*.rb")].each do |file|
  require file
end