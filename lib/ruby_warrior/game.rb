module RubyWarrior
  class Game
    def start
      UI.puts "Welcome to Ruby Warrior"
      
      if player_levels.empty?
        # TODO ask before making level
        generate_player_files(current_level)
        UI.puts "First level has been generated. See the ruby-warrior directory for instructions."
      else
        UI.puts "Loading your player.rb file."
        load player_level_paths.last + '/player.rb'
        UI.puts "Starting Level #{current_level.number}"
        current_level.play do
          sleep 0.8
        end
        if current_level.passed?
          if next_level
            generate_player_files(next_level)
            UI.puts "Success! You have found the stairs. See the ruby-warrior directory for the next level."
          else
            UI.puts "CONGRATULATIONS! You have climbed to the top of the tower."
          end
        else
          UI.puts "Sorry, you failed the level. Change your script and try again."
        end
      end
    end
    
    def current_level
      @level ||= tower.build_level(player_levels.last || 1)
    end
    
    def next_level
      tower.build_level(current_level.number+1)
    end
    
    def player_level_paths
      Dir["#{player_path}/level-*"]
    end
    
    def player_levels
      player_level_paths.map do |level|
        level[/[0-9]+$/].to_i
      end
    end
    
    def generate_player_files(level)
      PlayerGenerator.new(player_path, level).generate
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
    
    
    
    # ensure the ruby-warrior directory exists and ask to create it if not
    def make_game_directory
      if UI.request_boolean("No ruby-warrior directory found, would you like to create one?")
        Dir.mkdir('ruby-warrior')
      else
        UI.puts "Unable to continue without directory."
        exit
      end
    end
    
    
    # profiles
    
    def profiles
      profile_paths.map { |profile| Profile.load(profile) }
    end
    
    def profile_paths
      Dir['ruby-warrior/**/.profile']
    end
    
    def profile
      if profiles.empty?
        new_profile
      else
        profile = UI.choose(profiles + [[:new, 'New Profile']])
        if profile == :new
          new_profile
        else
          profile
        end
      end
    end
    
    def new_profile
      Profile.new(UI.choose(towers).path, UI.request('Enter a name for your warrior: '))
    end
    
    
    # towers
    
    def towers
      tower_paths.map { |tower| Tower.load(tower) }
    end
    
    def tower_paths
      Dir[File.expand_path(File.dirname(__FILE__) + '/../../towers/*')]
    end

  end
end
