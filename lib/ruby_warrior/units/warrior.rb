module RubyWarrior
  module Units
    class Warrior < Base
      attr_reader :score
      
      def initialize
        @health = 20
        @score = 100 # TODO make score dynamic
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
