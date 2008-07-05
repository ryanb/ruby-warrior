module RubyWarrior
  module Abilities
    class Base
      DIRECTIONS = {
        :forward => [1, 0],
        :right   => [0, 1],
        :back    => [-1, 0],
        :left    => [0, -1]
      }
      
      def initialize(unit)
        @unit = unit
      end
      
      def offset(direction)
        DIRECTIONS[direction]
      end
    end
  end
end
