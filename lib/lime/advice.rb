module Lime

  # Test Advice
  class Advice

    #
    attr :table

    # New case instance.
    def initialize
      @table = Hash.new{ |h,k| h[k] = {} }
    end

    #
    def initialize_copy(original)
      @table = original.table.clone
    end

    #
    def [](type)
      @table[type.to_sym]
    end

    ## Returns the description with newlines removed.
    #def to_s
    #  description.gsub(/\n/, ' ')
    #end

  end

end
