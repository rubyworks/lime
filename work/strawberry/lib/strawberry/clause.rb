module Strawberry

  class Clause

    #
    def initialize(type, match, &block)
      @type  = type
      @match = match
      @block = block

      @regexp = calc_regexp(match)
    end

    #
    attr :match

    #
    def =~(description)
      @regexp =~ description
    end

    #
    def calc_regexp(match)
      case match
      when Regexp
        match
      when String
        Regexp.new(match)
      else
        # ???
      end
    end

    #
    def call(scope)
      scope.instance_eval(&block)
    end

  end

end
