module RubyWarrior
  module Abilities
    class DirectionOf < Base
      def description
        "Pass a Space as an argument, and the direction (:left, :right, :forward, :backward) to that space will be returned."
      end

      def perform(space)
        @unit.position.relative_direction_of(space)
      end
    end
  end
end
