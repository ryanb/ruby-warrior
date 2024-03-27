module RubyWarrior
  module Abilities
    class Listen < Base
      def description
        "Returns an array of all spaces which have units in them."
      end

      def perform
        @unit.position.floor.units.map { |unit| unit.position.space unless unit == @unit }.compact
      end
    end
  end
end
