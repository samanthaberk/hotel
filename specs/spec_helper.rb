require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/reporters'
require_relative '../lib/booking_manager'


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
