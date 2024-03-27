module RubyWarrior
  module Units
    class Golem < Base
      attr_writer :turn
      attr_accessor :max_health

      def play_turn(turn)
        @turn.call(turn) if @turn
      end

      def attack_power
        3
      end

      def character
        "G"
      end
    end
  end
end
