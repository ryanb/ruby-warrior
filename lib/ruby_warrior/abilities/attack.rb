module RubyWarrior
  module Abilities
    class Attack < Base
      def perform(direction = :forward)
        get(direction).health -= @unit.attack_power if get(direction).respond_to? :health=
      end
    end
  end
end
