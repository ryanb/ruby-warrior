module RubyWarrior
  module Abilities
    class Listen < Base
      def description
        "Returns an array of all spaces which have units in them."
      end
      
      def possible_arguments
        [[]]
      end
      
      def perform
        @unit.position.floor.units.map do |unit|
          unit.position.space unless unit == @unit
        end.compact
      end
    end
  end
end
