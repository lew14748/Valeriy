require 'simplecov'
require 'byebug'

SimpleCov.start do
  add_filter '/spec/'
end
SimpleCov.minimum_coverage 90
