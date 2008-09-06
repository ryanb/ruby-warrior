module RubyWarrior
  module Abilities
    class Walk < Base
      def description
        "Move in given direction (forward by default)."
      end
      
      def perform(direction = :forward)
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
