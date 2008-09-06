module RubyWarrior
  module Units
    class Warrior < Base
      attr_writer :name
      attr_reader :score
      
      def initialize
        @score = 0 # TODO make score dynamic
      end
      
      def play_turn(turn)
        player.play_turn(turn)
      end
      
      def player
        @player ||= Player.new
      end
      
      def earn_points(points)
        @score += points
        say "earns #{points} points"
      end
      
      def attack_power
        5
      end
      
      def max_health
        20
      end
      
      def name
        if @name && !@name.empty?
          @name
        else
          "Warrior"
        end
      end
      
      def to_s
        name
      end
      
      def to_map
        "@"
      end
    end
  end
end
