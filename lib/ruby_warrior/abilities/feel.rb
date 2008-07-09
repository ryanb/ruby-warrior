module RubyWarrior
  module Abilities
    class Feel < Base
      def perform(direction = :forward)
        space(direction)
      end
    end
  end
end
