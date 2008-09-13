module RubyWarrior
  module Abilities
    class Explode < Base
      def description
        "Kills you. You probably don't want to do this intentionally."
      end
      
      def perform
        if @unit.position
          @unit.say "explodes"
          @unit.take_damage(@unit.health)
        end
      end
    end
  end
end
