module RubyWarrior
  module Abilities
    class Walk < Base
      def perform(direction = :forward)
        @unit.position.move(*offset(direction)) if @unit.position
      end
    end
  end
end
