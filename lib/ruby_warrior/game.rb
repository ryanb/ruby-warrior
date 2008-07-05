module RubyWarrior
  class Game
    def start
      puts "Welcome to Ruby Warrior"
      
      if player_levels.empty?
        # TODO ask before making directory
        Dir.mkdir('ruby-warrior')
        Dir.mkdir("ruby-warrior/#{tower.name}")
        generate_level(1)
      else
        puts "Player files found, it looks like you're on level #{current_level_number}"
        puts tower.build_level(current_level_number).inspect
      end
    end
    
    def current_level_number
      player_levels.last
    end
    
    def player_levels
      Dir["ruby-warrior/#{tower}/level-*"].map do |level|
        level[/[0-9]+^/].to_i
      end
    end
    
    def generate_level(number)
      Dir.mkdir("ruby-warrior/#{tower.name}/level-00#{number}")
    end
    
    def tower_name
      'easy' # TODO make a way to choose tower
    end
    
    def tower
      @tower ||= Tower.new(tower_name)
    end
  end
end
