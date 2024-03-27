module RubyWarrior
  module Abilities
    class Walk < Base
      def description
        "Move in the given direction (forward by default)."
      end

      def perform(direction = :forward)
        verify_direction(direction)
        if @unit.position
          @unit.say "walks #{direction}"
          if space(direction).empty?
            @unit.position.move(*offset(direction))
          else
            @unit.say "bumps into #{space(direction)}"
          end
        end
      end
    end
  end
end
