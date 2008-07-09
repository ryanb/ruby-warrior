module RubyWarrior
  module Abilities
    class Feel < Base
      def possible_arguments
        [[], *DIRECTIONS.keys]
      end
      
      def perform(direction = :forward)
        space(direction)
      end
    end
  end
end
