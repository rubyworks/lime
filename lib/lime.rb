module Lime
  $TEST_SUITE ||= []

  require 'lime/advice'
  require 'lime/feature'
  require 'lime/scenario'
  require 'lime/step'
end

# Ignore lime paths in backtraces
ignore_path   = File.expand_path(File.dirname(__FILE__) + '/lime')
ignore_regexp = Regexp.new(Regexp.escape(ignore_path))
RUBY_IGNORE_CALLERS = [] unless defined? RUBY_IGNORE_CALLERS
RUBY_IGNORE_CALLERS << ignore_regexp
RUBY_IGNORE_CALLERS << /bin\/ruby-test/

module Test
  extend self

  # Define a general test case.
  def Feature(label, &block)
    $TEST_SUITE << Lime::Feature.new(:label=>label, &block)
  end

  alias :feature :Feature
end

extend Test
