require 'simplecov'
SimpleCov.start do
  add_filter 'test'
end

require "minitest"
require "minitest/autorun"
require "minitest/reporters"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/date_range'
require_relative '../lib/front_desk'
require_relative '../lib/room'
require_relative '../lib/reservation'
