module RubyWarrior
  module Abilities
    class Throw < Base
      def description
        "Throw a bomb in a given direction (forward by default) which damages second space and lightly damages surrounding 4 spaces."
      end
      
      def perform(direction = :forward)
        if @unit.position
          @unit.say "throws a bomb #{direction}"
          bomb(direction, 2, 0, 4)
          [[2, 1], [2, -1], [3, 0], [1, 0]].each do |x, y|
            bomb(direction, x, y, 2)
          end
        end
      end
      
      def bomb(direction, x, y, damage_amount)
        if @unit.position
          receiver = space(direction, x, y).unit
          if receiver
            if receiver.abilities[:explode!]
              receiver.say "caught in bomb's flames which detonates ticking explosive"
              receiver.abilities[:explode!].perform
            else
              damage(receiver, damage_amount)
            end
          end
        end
      end
    end
  end
end
