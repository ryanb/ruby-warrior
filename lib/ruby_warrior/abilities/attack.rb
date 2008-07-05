module RubyWarrior
  module Abilities
    class Attack < Base
      def perform(direction = :forward)
        @unit.say "attacks #{get(direction)}"
        if get(direction).respond_to? :take_damage
          get(direction).take_damage(@unit.attack_power)
        end
      end
    end
  end
end
