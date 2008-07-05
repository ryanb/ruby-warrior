module RubyWarrior
  module Units
    class Sludge < Base
      def initialize
        @health = 8
        add_actions :attack
        add_senses :feel
      end
      
      def turn
        [:forward, :left, :right, :back].each do |direction|
          if feel(direction)
            attack!(direction)
            return
          end
        end
      end
      
      def attack_power
        2
      end
    end
  end
end
