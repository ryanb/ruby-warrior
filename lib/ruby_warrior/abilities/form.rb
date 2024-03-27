module RubyWarrior
  module Abilities
    class Form < Base
      def description
        "Forms a golem in given direction taking half of invoker's health. The passed block is executed for each golem turn."
      end

      def perform(direction = :forward, &block)
        verify_direction(direction)
        if space(direction).empty?
          x, y = @unit.position.translate_offset(*offset(direction))
          health = (@unit.health / 2.0).floor
          golem = @unit.base_golem
          golem.max_health = health
          golem.turn = block
          @unit.health -= health
          @unit.position.floor.add(golem, x, y, @unit.position.direction)
          @unit.say "forms a golem #{direction} and gives half of his health (#{health})"
        else
          @unit.say "fails to form golem because something is blocking the way."
        end
      end
    end
  end
end
