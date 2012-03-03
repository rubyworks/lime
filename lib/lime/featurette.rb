module Lime

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
        @_advice = Hash.new{ |h,k| h[k] = {} }
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
