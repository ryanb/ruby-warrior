module RubyWarrior
  module Abilities
    class DistanceOf < Base
      def description
        "Pass a Space as an argument, and it will return an integer representing the distance to that space."
      end

      def perform(space)
        @unit.position.distance_of(space)
      end
    end
  end
end
