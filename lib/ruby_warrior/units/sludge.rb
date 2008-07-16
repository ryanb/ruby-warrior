module RubyWarrior
  module Units
    class Sludge < Base
      def initialize
        add_abilities :attack!, :feel
      end
      
      def play_turn(turn)
        [:forward, :left, :right, :back].each do |direction|
          if turn.feel(direction).warrior?
            turn.attack!(direction)
            return
          end
        end
      end
      
      def attack_power
        2
      end
      
      def max_health
        8
      end
    end
  end
end
