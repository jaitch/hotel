require 'simplecov'
SimpleCov.start do
  add_filter 'test'
end

require "minitest"
require "minitest/autorun"
require "minitest/reporters"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative 'block'
require_relative 'calendar'
require_relative 'reservation'