module RubyWarrior
  module Abilities
    class Rescue < Base
      def perform(direction = :forward)
        if space(direction).captive?
          @unit.say "rescues captive"
          unit(direction).position = nil
          @unit.earn_points(20)
        end
      end
    end
  end
end
