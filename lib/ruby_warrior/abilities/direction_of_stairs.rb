module RubyWarrior
  module Abilities
    class DirectionOfStairs < Base
      def description
        "Returns the direction (:left, :right, :forward, :backward) the stairs are from your location."
      end
      
      def possible_arguments
        [[]]
      end
      
      def perform
        @unit.position.relative_direction_of_stairs
      end
    end
  end
end
