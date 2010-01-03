module RubyWarrior
  module Abilities
    class Throw < Base
      def description
        "Throw a bomb in a given direction (forward by default) which damages second space and lightly damages surrounding 4 spaces."
      end
      
      def perform(direction = :forward)
        if @unit.position
          @unit.say "throws a bomb"
          receiver = @unit.position.relative_space(2, 0).unit
          damage(receiver, 10) if receiver
          [[2, 1], [2, -1], [3, 0], [1, 0]].each do |x, y|
            receiver = @unit.position.relative_space(x, y).unit
            damage(receiver, 1) if receiver
          end
        end
      end
    end
  end
end
