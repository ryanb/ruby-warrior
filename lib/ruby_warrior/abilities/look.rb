module RubyWarrior
  module Abilities
    class Look < Base
      def possible_arguments
        [[], :forward, :left, :right]
      end
      
      def perform(direction = :forward)
        [1, 2, 3].map do |amount|
          space(direction, amount)
        end
      end
    end
  end
end
