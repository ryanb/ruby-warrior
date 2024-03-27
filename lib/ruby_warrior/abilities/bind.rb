module RubyWarrior
  module Abilities
    class Bind < Base
      def description
        "Binds a unit in given direction to keep him from moving (forward by default)."
      end

      def perform(direction = :forward)
        verify_direction(direction)
        receiver = unit(direction)
        if receiver
          @unit.say "binds #{direction} and restricts #{receiver}"
          receiver.bind
        else
          @unit.say "binds #{direction} and restricts nothing"
        end
      end
    end
  end
end
