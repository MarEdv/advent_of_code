require "rubygems"
require "bundler"
Bundler.setup

class Day8
end

Dir[File.expand_path(File.dirname(__FILE__) + "/day8/*.rb")].each do |file|
  require file
end