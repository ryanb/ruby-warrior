module RubyWarrior
  class Game
    def start
      UI.puts "Welcome to Ruby Warrior"
      
      make_game_directory unless File.exists?('ruby-warrior')
      
      if current_level.nil?
        generate_next_level
        UI.puts "First level has been generated. See the ruby-warrior directory for instructions."
      else
        load_player
        UI.puts "Starting Level #{current_level.number}"
        current_level.play { sleep 0.8 }
        if current_level.passed?
          if next_level
            profile.generate_next_level
            UI.puts "Success! You have found the stairs. See the ruby-warrior directory for the next level."
          else
            UI.puts "CONGRATULATIONS! You have climbed to the top of the tower."
          end
        else
          UI.puts "Sorry, you failed the level. Change your script and try again."
        end
      end
    end
    
    # def generate_next_level
    #   PlayerGenerator.new(profile.player_path, next_level).generate
    #   profile.level_number += 1
    #   profile.save
    # end
    # 
    def make_game_directory
      if UI.ask("No ruby-warrior directory found, would you like to create one?")
        Dir.mkdir('ruby-warrior')
      else
        UI.puts "Unable to continue without directory."
        exit
      end
    end
    
    
    # player
    
    def load_player
      $: << profile.current_level_path
      load 'player.rb'
    end
    
    
    # profiles
    
    def profiles
      profile_paths.map { |profile| Profile.load(profile) }
    end
    
    def profile_paths
      Dir['ruby-warrior/**/.profile']
    end
    
    def profile
      @profile ||= choose_profile
    end
    
    def new_profile
      Profile.new(UI.choose('tower', towers).path, UI.request('Enter a name for your warrior: '))
    end
    
    
    # towers
    
    def towers
      tower_paths.map { |path| Tower.new(path) }
    end
    
    def tower_paths
      Dir[File.expand_path(File.dirname(__FILE__) + '/../../towers/*')]
    end
    
    
    # levels
    
    def current_level
      @current_level ||= profile.current_level
    end
    
    def next_level
      profile.next_level
    end
    
    
    private
    
    def choose_profile
      profile = UI.choose('profile', profiles + [[:new, 'New Profile']])
      if profile == :new
        new_profile
      else
        profile
      end
    end
    
  end
end
