module RubyWarrior
  module Abilities
    class Health < Base
      def possible_arguments
        [[]]
      end
      
      def perform
        @unit.health
      end
    end
  end
end
