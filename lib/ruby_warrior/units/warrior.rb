module RubyWarrior
  module Units
    class Warrior < Base
      def initialize(profile)
        @profile = profile
        @health = 20
      end
      
      def play_turn(turn)
        player.play_turn(turn)
      end
      
      def player
        @player ||= Player.new
      end
      
      def attack_power
        5
      end
    end
  end
end
