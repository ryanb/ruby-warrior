module RubyWarrior
  module Units
    class Sludge < Base
      def initialize
        add_actions :attack
        add_senses :feel
      end
      
      def turn
        [:front, :left, :right, :back].each do |direction|
          if sense(direction)
            attack(direction)
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
