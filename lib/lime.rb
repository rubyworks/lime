module Lime
  $TEST_SUITE ||= []

  require 'lime/advice'
  require 'lime/feature'
  require 'lime/scenario'
  require 'lime/step'
end

module Test
  extend self

  # Define a general test case.
  def Feature(label, &block)
    Lime::Feature.new(:label=>label, &block)
  end

  alias :feature :Feature
end

extend Test
