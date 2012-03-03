# Ignore lime paths in backtraces
ignore_path   = File.expand_path(File.dirname(__FILE__) + '/lime')
ignore_regexp = Regexp.new(Regexp.escape(ignore_path))
$RUBY_IGNORE_CALLERS ||= []
$RUBY_IGNORE_CALLERS << ignore_regexp

# Make sure the global test array is defined.
$TEST_SUITE ||= []

module Lime

  require 'lime/advice'
  require 'lime/feature'
  require 'lime/scenario'
  require 'lime/step'

  # Toplevel DSL.
  #
  module DSL

    #
    # Define a feature.
    #
    def Feature(label, &block)
      require_featurettes(File.dirname(caller[0]))

      $TEST_SUITE << Lime::Feature.new(:label=>label, &block)
    end

    alias :feature :Feature

    #
    # Require any featurettes located in `{feature_dir}/featurettes` directory.
    #
    def require_featurettes(feature_dir)
      featurettes_dir = File.join(feature_dir, 'featurettes')
      if File.directory?(featurettes_dir)
        featurette_files = Dir[File.join(featurettes_dir, '*.rb')]
        featurette_files.each do |file|
          require file
        end
      end
    end

  end

end

extend Lime::DSL
