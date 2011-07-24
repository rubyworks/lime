module Lime

  # Test step.
  #
  class Step

    # New unit test procedure.
    #
    def initialize(scenario, label, settings={})
      @scenario = scenario
      @label    = label

      @type     = settings[:type]

      @omit     = false
      #@tested   = false
    end

    # The type of step (:given, :when or :then).
    attr :type

    # The scenario to which this step belongs.
    attr :scenario

    # Label of test.
    attr :label

    #
    def omit?
      @omit
    end

    #
    def omit=(boolean)
      @omit = boolean
    end

    #
    def to_s
      "#{type.to_s.capitalize} #{label}"
    end

    # FIXME
    def subject
    end

    #
    def to_proc
      lambda{ call }
    end

    #
    #def match?(match)
    #  match == target || match === label
    #end

    #
    def call
      scenario.run(self)
    end

  end

end