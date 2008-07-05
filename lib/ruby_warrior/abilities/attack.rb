module RubyWarrior
  module Abilities
    class Attack < Base
      def perform(direction = :forward)
        get(direction).take_damage(@unit.attack_power) if get(direction).respond_to? :health=
      end
    end
  end
end
