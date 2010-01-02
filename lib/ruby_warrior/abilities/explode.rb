module RubyWarrior
  module Abilities
    class Explode < Base
      def description
        "Kills you and all surrounding units. You probably don't want to do this intentionally."
      end
      
      def perform
        if @unit.position
          @unit.say "explodes, collapsing the cealing and damanging every unit."
          @unit.position.floor.units.map do |unit|
            unit.take_damage(100)
          end
        end
      end
    end
  end
end
