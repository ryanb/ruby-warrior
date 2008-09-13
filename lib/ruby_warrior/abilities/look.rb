module RubyWarrior
  module Abilities
    class Look < Base
      def description
        "Returns an array of Spaces in given direction (forward by default)."
      end
      
      def perform(direction = :forward)
        [1, 2, 3].map do |amount|
          space(direction, amount)
        end
      end
    end
  end
end
