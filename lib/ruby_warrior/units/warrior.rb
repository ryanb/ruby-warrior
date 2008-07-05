module RubyWarrior
  module Units
    class Warrior < Base
      def initialize
        @health = 20
      end
      
      def play_turn
        player.turn(self)
      end
      
      def player
        @player ||= Player.new
      end
    end
  end
end
