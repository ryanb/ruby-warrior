module RubyWarrior
  module Abilities
    class Feel < Base
      def perform(direction = :forward)
        get(direction)
      end
    end
  end
end
