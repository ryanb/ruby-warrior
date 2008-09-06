module RubyWarrior
  module Abilities
    class Bind < Base
      def description
        "Bind unit in given direction to keep him from moving (forward by default)."
      end
      
      def perform(direction = :forward)
        receiver = unit(direction)
        if receiver
          @unit.say "binds #{receiver}"
          receiver.bind
        else
          @unit.say "binds nothing"
        end
      end
    end
  end
end
