#require 'lime/pending'
require 'lime/advice'
require 'lime/scenario'

module Lime

  # The TestFeature ...
  #
  # The `advice` are _given_, _when_ and _then_ rules.
  #
  class Feature

    # Brief description of the feature.
    attr :label

    #
    attr :story

    # List of tests and sub-cases.
    attr :scenarios

    # Advice are labeled procedures, such as before
    # and after advice.
    attr :advice

    # Module for evaluating tests.
    attr :scope

    #
    def initialize(settings={}, &block)
      @label   = settings[:label]
      @setup   = settings[:setup]

      @advice  = Advice.new
      @scope   = Module.new

      @story     = []
      @scenarios = []

      # TODO: Don't really like this here, but how else to do it?
      $TEST_SUITE << self

      @scope.extend DSL.new(self, &block)
    end

    # Iterate over each scenario.
    def each(&block)
      scenarios.each(&block)
    end

    # Number of scenarios.
    def size
      scenarios.size
    end

    # Subclasses of TestCase can override this to describe
    # the type of test case they define.
    def type
      'Feature'
    end

    #
    #def to_s
    #  "#{type}: " + @label.to_s
    #end

    #
    def to_s #description
      (["Feature: #{label}"] + story).join("\n  ")
    end

    #
    def omit?
      @omit
    end

    #
    def omit=(boolean)
      @omit = boolean
    end

    #
    class DSL < Module

      #
      def initialize(feature, &code)
        @_feature = feature

        module_eval(&code)
      end

      #
      def To(description)
        @_feature.story << "To " + description
      end
      alias_method :to, :To

      #
      def As(description)
        @_feature.story << "As " + description
      end
      alias_method :as, :As

      #
      def We(description)
        @_feature.story << "We " + description
      end
      alias_method :we, :We

      #
      def Scenario(label, &procedure)
        scenario = Scenario.new(@_feature, :label=>label, &procedure)
        @_feature.scenarios << scenario
        scenario
      end
      alias_method :scenario, :Scenario

      # Omit a scenario from test runs.
      #
      #  omit unit :foo do
      #    # ...
      #  end
      #
      def Omit(scenario)
        scenario.omit = true
      end
      alias_method :omit, :Omit

      # Given ...
      #
      # @param [String] description
      #   A brief description of the _given_ criteria.
      #
      def Given(description, &procedure)
        @_feature.advice[:given][description] = procedure
      end
      alias_method :given, :Given

      # When ...
      #
      # @param [String] description
      #   A brief description of the _when_ criteria.
      #
      def When(description, &procedure)
        @_feature.advice[:when][description] = procedure
      end
      alias_method :wence, :When

      # Then ...
      #
      # @param [String] description
      #   A brief description of the _then_ criteria.
      #
      def Then(description, &procedure)
        @_feature.advice[:then][description] = procedure
      end
      alias_method :hence, :Then

    end

  end

end
