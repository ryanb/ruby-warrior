module RubyWarrior
  module Abilities
    class Base
      def initialize(unit)
        @unit = unit
      end
      
      def offset(direction, forward = 1, right = 0)
        case direction
        when :forward then [forward, -right]
        when :backward then [-forward, right]
        when :right then [right, forward]
        when :left then [-right, -forward]
        end
      end
      
      def space(direction, forward = 1, right = 0)
        @unit.position.relative_space(*offset(direction, forward, right))
      end
      
      def unit(direction, forward = 1, right = 0)
        space(direction, forward, right).unit
      end
      
      def damage(receiver, amount)
        receiver.take_damage(amount)
        @unit.earn_points(receiver.max_health) unless receiver.alive?
      end
      
      def description
      end
      
      def pass_turn
        # callback which is triggered every turn
      end
      
      def verify_direction(direction)
        unless Position::RELATIVE_DIRECTIONS.include? direction
          raise "Unknown direction #{direction.inspect}. Should be :forward, :backward, :left or :right."
        end
      end
    end
  end
end
