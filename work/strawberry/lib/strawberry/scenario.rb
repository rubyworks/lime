module Strawberry

  #
  class Scenario

    #
    def initialize(description, &block)
      @description = description

      @steps  = []

      instance_eval(&block)
    end

    attr :steps

    #
    def Given(description)
      @steps << Step.new(:given, descrption)
    end

    #
    def When(description)
      @steps << Step.new(:when, descrption)
    end

    #
    def Then(description)
      @steps << Step.new(:then, descrption)
    end

  end

end
