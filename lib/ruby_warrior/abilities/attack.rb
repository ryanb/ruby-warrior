module RubyWarrior
  module Abilities
    class Attack < Base
      def perform(direction = :forward)
        if get(direction).respond_to? :health=
          @unit.say "attacks #{direction}"
          get(direction).take_damage(@unit.attack_power)
        end
      end
    end
  end
end
