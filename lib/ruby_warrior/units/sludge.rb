module RubyWarrior
  module Units
    class Sludge < Base
      def initialize
        add_actions :attack
      end
      
      def attack_power
        2
      end
    end
  end
end
