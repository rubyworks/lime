module Strawberry

  #
  class Step

    #
    def intialize(type, description)
      @type        = type
      @description = description
    end

    #
    def find(feature)
      features.clauses[@type].find{ |c| c =~ @description }
    end

  end

end
