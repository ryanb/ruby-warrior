module RubyWarrior
  module Abilities
    class Attack < Base
      def perform(direction = :forward)
        get(direction).health -= 1 if get(direction).respond_to? :health=
      end
      
      def get(direction)
        @unit.position.get_relative(*offset(direction))
      end
    end
  end
end
