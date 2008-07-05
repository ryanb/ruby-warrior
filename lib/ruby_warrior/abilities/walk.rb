module RubyWarrior
  module Abilities
    class Walk < Base
      def perform(direction = :forward)
        if @unit.position
          if get(direction).nil?
            @unit.say "walks #{direction}"
            @unit.position.move(*offset(direction))
          else
            @unit.say "bumps into #{get(direction)}"
          end
        end
      end
    end
  end
end
