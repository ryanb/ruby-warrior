module RubyWarrior
  module Abilities
    class Base
      DIRECTIONS = {
        :forward => [1, 0],
        :right   => [0, 1],
        :backward    => [-1, 0],
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
      
      def unit(direction, amount = 1)
        space(direction, amount).unit
      end
      
      def damage(receiver, amount)
        receiver.take_damage(amount)
        @unit.earn_points(receiver.max_health) unless receiver.alive?
      end
    end
  end
end
