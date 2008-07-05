module RubyWarrior
  class Warrior
    attr_accessor :position
    
    def turn
      player.turn(self)
    end
    
    def player
      @player ||= Player.new
    end
    
    def walk
      position.move(1)
      UI.puts "Warrior walks forward."
    end
  end
end
