# Ignore lime paths in backtraces
ignore_path   = File.expand_path(File.dirname(__FILE__) + '/lime')
ignore_regexp = Regexp.new(Regexp.escape(ignore_path))
RUBY_IGNORE_CALLERS = [] unless defined? RUBY_IGNORE_CALLERS
RUBY_IGNORE_CALLERS << ignore_regexp

# Make sure the global test array is defined.
$TEST_SUITE ||= []

module Lime

  require 'lime/advice'
  require 'lime/feature'
  require 'lime/scenario'
  require 'lime/step'

  # Toplevel DSL.
  module DSL

    # Define a feature.
    def Feature(label, &block)
      $TEST_SUITE << Lime::Feature.new(:label=>label, &block)
    end

    alias :feature :Feature

  end

end

extend Lime::DSL
