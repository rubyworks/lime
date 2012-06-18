module Strawberry

  #
  class Feature

    #
    def initialize(description, &block)
      @description = description

      @clauses = {:given=>[], :when=>[], :then=>[] }

      instance_eval(&block)
    end

    #
    def Scenario(description, &block)
      @scenarios << Scenario.new(description, &block)
    end

    #
    def Given(match, &block)
      @clauses[:given] << Clause.new(:given, match, &block)
    end

    #
    def When(match, &block)
      @clauses[:when] << Clause.new(:when, match, &block)
    end

    #
    def Then(match, &block)
      @clauses[:then] << Clause.new(:then, match, &block)
    end

  end

end
