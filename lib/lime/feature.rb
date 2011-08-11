module Lime

  #require 'lime/pending'
  require 'lime/world'
  require 'lime/advice'
  require 'lime/scenario'

  # Features contain scenarios.
  #
  # The `advice` are _given_, _when_ and _then_ rules.
  #
  class Feature

    # Brief description of the feature.
    attr :label

    # The descriptive details of the feature, defined using
    # the `To`, `As` and `We` methods.
    attr :story

    # List of scenarios.
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

      @story     = []
      @scenarios = []

      @scope = Scope.new(self)
      @scope.module_eval(&block)
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
    def update(mixin)
      @advice[:given].concat mixin[:given] || []
      @advice[:when].concat  mixin[:when]  || []
      @advice[:then].concat  mixin[:then]  || []
      @scope.extend mixin if Module === mixin
    end

    #
    class Scope < World

      #
      def initialize(feature) #, &code)
        @_feature = feature
        @_skip    = false
        #module_eval(&code)
      end

      #
      def To(description)
        @_feature.story << "To " + description
      end
      
      alias :to :To

      #
      def As(description)
        @_feature.story << "As " + description
      end

      alias :as :As

      #
      def We(description)
        @_feature.story << "We " + description
      end

      alias :we :We

      #
      def Scenario(label, &procedure)
        scenario = Scenario.new(
          @_feature,
          :skip  => @_skip,
          :label => label,
          &procedure
        )
        @_feature.scenarios << scenario
        @_skip = false
        scenario
      end

      alias :scenario :Scenario

      # Given ...
      #
      # @param [String] description
      #   A brief description of the _given_ criteria.
      #
      def Given(description, &procedure)
        @_feature[:given][description] = procedure
      end

      alias :given :Given

      # When ...
      #
      # @param [String] description
      #   A brief description of the _when_ criteria.
      #
      def When(description, &procedure)
        @_feature[:when][description] = procedure
      end

      alias :wence :When

      # Then ...
      #
      # @param [String] description
      #   A brief description of the _then_ criteria.
      #
      def Then(description, &procedure)
        @_feature[:then][description] = procedure
      end

      alias :hence :Then

      # Skip the next scenario when running feature.
      #
      #  skip "for some reason"
      #  Scenario "blah blah blah" do
      #    # ...
      #  end
      #
      # @todo Use block form of this instead?
      def skip(reason=true)
        @_skip = reason
      end

      # Is this necessary?
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
    #   module MyStepDefinitions
    #     include Lime::Featurette
    #
    #     Given "customer's name is '(((\s+)))'" do |name|
    #       @name = name
    #     end
    #   end
    #
    #   Feature do
    #     include MyStepDefinitions
    #   end
    #
    module Featurette

      def self.append_features(base)
        base.extend(self)
        base.module_eval %{
          @_advice = Hash.new{ |h,k| h[k]={} }
        }
      end

      # Given ...
      #
      # @param [String] description
      #   A brief description of the _given_ criteria.
      #
      def Given(description, &procedure)
        @_advice[:given][description] = procedure
      end

      alias :given :Given

      # When ...
      #
      # @param [String] description
      #   A brief description of the _when_ criteria.
      #
      def When(description, &procedure)
        @_advice[:when][description] = procedure
      end

      alias :wence :When

      # Then ...
      #
      # @param [String] description
      #   A brief description of the _then_ criteria.
      #
      def Then(description, &procedure)
        @_advice[:then][description] = procedure
      end

      alias :hence :Then

      # Access to advice.
      def [](key)
        @_advice[key]
      end

    end

  end

end
