module RubyWarrior
  module Abilities
    class Health < Base
      def description
        "Returns an integer representing your health."
      end
      
      def possible_arguments
        [[]]
      end
      
      def perform
        @unit.health
      end
    end
  end
end
