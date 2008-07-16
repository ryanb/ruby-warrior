module RubyWarrior
  module Abilities
    class Attack < Base
      def perform(direction = :forward)
        receiver = unit(direction)
        if receiver
          @unit.say "attacks #{receiver}"
          damage(receiver, @unit.attack_power)
        else
          @unit.say "attacks and misses"
        end
      end
    end
  end
end
