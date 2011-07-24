require 'lime/step'

module Lime

  #
  class Scenario

    #
    def initialize(feature, settings={}, &block)
      @feature = feature

      @label   = settings[:label]

      @scope   = Module.new

      @steps   = []

      @scope.extend DSL.new(self, &block)
    end

    #
    attr :feature

    #
    attr :label

    #
    attr :steps

    #
    attr :scope

    #
    def omit?
      @omit
    end

    #
    def omit=(boolean)
      @omit = boolean
    end

    #
    def each(&block)
      @steps.each(&block)
    end

    #
    def size(&block)
      @steps.size
    end

    #
    def to_s
      "Scenario: #{@label}"
    end

    # FIXME
    def subject
    end

    #
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
    #--
    # TODO: Change so that the scope is the DSL
    #       and includes the DSL of the context?
    #++
    #def scope
    #  @scope ||= (
    #    #if feature
    #    #  scope = feature.scope || Object.new
    #    #  scope.extend(dsl)
    #    #else
    #      scope = Object.new
    #      scope.extend(dsl)
    #    #end
    #  )
    #end

    #
    #def find
    #  features.clauses[@type].find{ |c| c =~ @description }
    #end

    # Convert matching string into a regular expression. If the string
    # contains double parenthesis, such as ((.*?)), then the text within
    # them is treated as in regular expression and kept verbatium.
    #
    # TODO: Better way to isolate regexp. Maybe ?:(.*?) or /(.*?)/.
    #
    def match_regexp(str)
      str = str.split(/(\(\(.*?\)\))(?!\))/).map{ |x|
        x =~ /\A\(\((.*)\)\)\Z/ ? $1 : Regexp.escape(x)
      }.join
      str = str.gsub(/\\\s+/, '\s+')
      Regexp.new(str, Regexp::IGNORECASE)
    end

    # TODO: Need to ensure the correct order of Given, When, Then.
    class DSL < Module

      #
      def initialize(scenario, &code)
        @scenario = scenario

        extend(scenario.feature.scope)

        module_eval(&code)
      end

      # Given ...
      #
      # @param [String] description
      #   A matching description of the _given_ procedure.
      #
      def Given(label)
        @scenario.steps << Step.new(@scenario, label, :type=>:given)
      end
      alias_method :given, :Given

      # When ...
      #
      # @param [String] label
      #   A matching description of the _when_ procedure.
      #
      def When(label)
        @scenario.steps << Step.new(@scenario, label, :type=>:when)
      end
      alias_method :wence, :When

      # Then ...
      #
      # @param [String] label
      #   A matching description of the _then_ procedure.
      #
      def Then(label)
        @scenario.steps << Step.new(@scenario, label, :type=>:then)
      end
      alias_method :hence, :Then

    end

  end

end