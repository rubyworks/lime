require 'lime/step'

module Lime

  #
  class Scenario

    #
    def initialize(feature, settings={}, &block)
      @feature = feature

      @label   = settings[:label]
      @skip    = settings[:skip]

      @steps   = []

      @scope = Scope.new(self)
      @scope.module_eval(&block)
    end

    # Parent feature.
    attr :feature

    # Description of scenario.
    attr :label

    # List scenario steps.
    attr :steps

    # Evaluation scope.
    attr :scope

    # Skip this scenario from runs.
    #
    # @return [Boolean,String] reason for skipping
    def skip?
      @skip
    end

    # Scenario steps must be run in order.
    def ordered?
      true
    end

    # Iterate over steps.
    def each(&block)
      @steps.each(&block)
    end

    # Number of steps.
    def size(&block)
      @steps.size
    end

    # The type is "Scenario". This is used by Ruby Test in test output.
    def type
      "Scenario"
    end

    # Provided the scenario label.
    def to_s
      @label.to_s
    end

    # FIXME
    def topic
    end

    # Run a step in the context of this scenario.
    def run(step)
      type = step.type
      desc = step.label
      feature.advice[type].each do |mask, proc|
        if md = match_regexp(mask).match(desc)
          scope.instance_exec(*md[1..-1], &proc)
        end
      end
    end

    #
    #def find
    #  features.clauses[@type].find{ |c| c =~ @description }
    #end

    # Convert matching string into a regular expression. If the string
    # contains parentheticals, e.g. `(.*?)`, the text within them is
    # treated as a case-insensitve back-referenceing regular expression
    # and kept verbatium.
    #
    # To use a regular expression, but leave the resulting match out of
    # the backreferences use `?:`, e.g. `(?:\d+)`.
    def match_regexp(str)
      ## the old way required double and triple parens
      #str = str.split(/(\(\(.*?\)\))(?!\))/).map{ |x|
      #  x =~ /\A\(\((.*)\)\)\Z/ ? $1 : Regexp.escape(x)
      #}.join
      str = str.split(/(\(.*?\))(?!\))/).map{ |x|
        x =~ /\A\((.*)\)\Z/ ? "(#{$1})" : Regexp.escape(x)
      }.join
      str = str.gsub(/\\\s+/, '\s+')
      Regexp.new(str, Regexp::IGNORECASE)
    end

    # TODO: Need to ensure the correct order of Given, When, Then.
    class Scope < Module

      #
      def initialize(scenario) #, &code)
        @scenario = scenario

        extend(scenario.feature.scope)

        #module_eval(&code)
      end

      # Given ...
      #
      # @param [String] description
      #   A matching description of the _given_ procedure.
      #
      def Given(label)
        @scenario.steps << Step.new(@scenario, label, :type=>:given)
      end

      alias :given :Given

      # When ...
      #
      # @param [String] label
      #   A matching description of the _when_ procedure.
      #
      def When(label)
        @scenario.steps << Step.new(@scenario, label, :type=>:when)
      end

      alias :wence :When

      # Then ...
      #
      # @param [String] label
      #   A matching description of the _then_ procedure.
      #
      def Then(label)
        @scenario.steps << Step.new(@scenario, label, :type=>:then)
      end

      alias :hence :Then

    end

  end

end
