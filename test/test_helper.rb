require 'simplecov'
SimpleCov.start do
  add_filter 'test'
end

require "minitest"
require "minitest/autorun"
require "minitest/reporters"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/block'
require_relative '../lib/calendar'
require_relative '../lib/reservation'




