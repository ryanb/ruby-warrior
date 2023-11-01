module RubyWarrior
  module Abilities
    class Skip < Base
      def description
        "Skips in the given direction (forward by default)."
      end
      
      def perform(direction = :forward)
        verify_direction(direction)
        if @unit.position
          @unit.say "skips #{direction}"
          if space(direction).empty?
            @unit.position.move(*offset(direction))
          else
            @unit.say "hits #{space(direction)}"
          end
        end
      end
    end
  end
end
