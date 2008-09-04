module RubyWarrior
  module Abilities
    class Feel < Base
      def description
        "Returns a Space for the given direction (forward by default)."
      end
      
      def possible_arguments
        [[], *DIRECTIONS.keys]
      end
      
      def perform(direction = :forward)
        space(direction)
      end
    end
  end
end
