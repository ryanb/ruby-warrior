module RubyWarrior
  module Abilities
    class Walk < Base
      def perform(direction = :forward)
        if @unit.position
          if space(direction).empty?
            @unit.say "walks #{direction}"
            @unit.position.move(*offset(direction))
          else
            @unit.say "bumps into #{unit(direction)}"
          end
        end
      end
    end
  end
end
