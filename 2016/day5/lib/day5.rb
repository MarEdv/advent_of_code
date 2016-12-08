require "rubygems"
require "bundler"
require 'lazy_stream'
require 'digest'

Bundler.setup

class Day5
end

Dir[File.expand_path(File.dirname(__FILE__) + "/day5/*.rb")].each do |file|
  require file
end