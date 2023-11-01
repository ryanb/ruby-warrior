module RubyWarrior
  module Units
    class Magikarp < Base
      def initialize
      end

      def play_turn(turn)
        say "splashes, but nothing happens"
      end
      
      def max_health
        1
      end
      
      def character
        "M"
      end
    end
  end
end
