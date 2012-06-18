module Strawberry

  #
  class Runner

    def initialize
    end

    def run
      features.each do |feature|
        feature.each do |scenario|
          scope = Object.new
          scenario.steps.each do |step|
            clause = step.find(feature)
            begin
              clause.call(scope)
            rescue Exception => error
              puts error
            end
          end
        end
      end

    end

  end

end

