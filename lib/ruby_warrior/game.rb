module RubyWarrior
  class Game
    def start
      puts "Welcome to Ruby Warrior"
      
      if player_levels.empty?
        # TODO ask before making level
        generate_level(1)
        puts "First level has been generated. See the ruby-warrior directory for instructions."
      else
        puts "Player files found, it looks like you're on level #{current_level_number}"
        puts tower.build_level(current_level_number).inspect
      end
    end
    
    def current_level_number
      player_levels.last
    end
    
    def player_levels
      Dir["#{player_path}/level-*"].map do |level|
        level[/[0-9]+^/].to_i
      end
    end
    
    def generate_level(number)
      PlayerGenerator.new(player_path, tower.build_level(number)).generate
    end
    
    def tower_name
      'easy' # TODO make a way to choose tower
    end
    
    def tower
      @tower ||= Tower.new(tower_name)
    end
    
    def player_path
      "ruby-warrior/#{tower_name}-tower"
    end
  end
end
