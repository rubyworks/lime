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

      @scope.extend DSL.new(self, &block)
    end

    # Convenience method for accessing advice, aka step definitions.
    def [](key)
      @advice[key]
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
    def to_s
      (["#{label}"] + story).join("\n")
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
    def update(mixin)
      @advice[:given].concat mixin[:given] || []
      @advice[:when].concat  mixin[:when]  || []
      @advice[:then].concat  mixin[:then]  || []
      @scope.extend mixin if Module === mixin
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
        @_feature[:given][description] = procedure
      end
      alias_method :given, :Given

      # When ...
      #
      # @param [String] description
      #   A brief description of the _when_ criteria.
      #
      def When(description, &procedure)
        @_feature[:when][description] = procedure
      end
      alias_method :wence, :When

      # Then ...
      #
      # @param [String] description
      #   A brief description of the _then_ criteria.
      #
      def Then(description, &procedure)
        @_feature[:then][description] = procedure
      end
      alias_method :hence, :Then

      #
      def _feature
        @_feature
      end

      #
      def include(mixin)
        if Featurable === mixin
          @_feature.update(mixin)
          super(mixin)
        else
          super(mixin)
        end
      end

    end

    # Convenience method for creating a feature mixin.
    #
    # @example
    #
    #   module MySteps
    #     include Lime::Featurable
    #     Given "customer's name is '(((\s+)))'" do |name|
    #       @name = name
    #     end
    #   end
    #
    #   Feature do
    #     include MySteps
    #   end
    #
    module Featurable

      def self.append_features(base)
        base.extend(self)
        base.module_eval %{
          @_advice = Hash.new { |h,k| h[k]={} }
        }
      end

      #
      #def initialize(&code)
      #  @_advice = Hash.new { |h,k| h[k]={} }
      # 
      #  module_eval(&code)
      #end

      # Given ...
      #
      # @param [String] description
      #   A brief description of the _given_ criteria.
      #
      def Given(description, &procedure)
        @_advice[:given][description] = procedure
      end
      alias_method :given, :Given

      # When ...
      #
      # @param [String] description
      #   A brief description of the _when_ criteria.
      #
      def When(description, &procedure)
        @_advice[:when][description] = procedure
      end
      alias_method :wence, :When

      # Then ...
      #
      # @param [String] description
      #   A brief description of the _then_ criteria.
      #
      def Then(description, &procedure)
        @_advice[:then][description] = procedure
      end
      alias_method :hence, :Then

      # Access to internal feature instance.
      def [](key)
        @_advice[key]
      end

    end

  end

end
