module RubyWarrior
  module Abilities
    class Distance < Base
      def description
        "Returns the number of spaces the stairs are away."
      end
      
      def possible_arguments
        [[]]
      end
      
      def perform
        @unit.position.distance_from_stairs
      end
    end
  end
end
