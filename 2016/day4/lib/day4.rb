require "rubygems"
require "bundler"
Bundler.setup

class Day4
end

Dir[File.expand_path(File.dirname(__FILE__) + "/day4/*.rb")].each do |file|
  require file
end