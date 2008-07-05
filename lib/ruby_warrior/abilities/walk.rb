module RubyWarrior
  module Abilities
    class Walk < Base
      def perform(direction = :forward)
        if @unit.position
          @unit.say "walks #{direction}"
          @unit.position.move(*offset(direction))
        end
      end
    end
  end
end
