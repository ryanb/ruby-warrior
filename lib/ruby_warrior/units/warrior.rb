module RubyWarrior
  module Units
    class Warrior < Base
      def initialize(profile)
        @profile = profile
        @health = 20
        
        add_abilities_without_profile(*profile.abilities)
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
      
      def add_abilities_with_profile(*abilities)
        @profile.add_abilities(*abilities)
        add_abilities_without_profile(*abilities)
      end
      alias_method :add_abilities_without_profile, :add_abilities
      alias_method :add_abilities, :add_abilities_with_profile
    end
  end
end
