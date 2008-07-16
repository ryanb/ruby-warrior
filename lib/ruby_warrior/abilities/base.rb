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
      
      def offset(direction, amount = 1)
        DIRECTIONS[direction].map { |i| i*amount }
      end
      
      def space(direction, amount = 1)
        @unit.position.relative_space(*offset(direction, amount))
      end
      
      def unit(direction)
        space(direction).unit
      end
    end
  end
end
