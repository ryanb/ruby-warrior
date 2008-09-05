module RubyWarrior
  module Abilities
    class Pivot < Base
      ROTATION_DIRECTIONS = [:forward, :right, :backward, :left]
      
      def description
        "Rotate :left, :right or :backward (default)"
      end
      
      def perform(direction = :backward)
        @unit.position.rotate(ROTATION_DIRECTIONS.index(direction))
        @unit.say "pivots #{direction}"
      end
    end
  end
end
