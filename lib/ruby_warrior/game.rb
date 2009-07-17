module RubyWarrior
  class Game
    
    # TODO refactor and test this method
    def start
      UI.puts "Welcome to Ruby Warrior"
      
      make_game_directory unless File.exists?(Config.path_prefix + '/ruby-warrior')
      
      if profile.epic?
        UI.delay /= 4 if UI.delay # speed up UI since we're going to be doing a lot here
        playing = true
        while playing
          @current_level = @next_level = nil
          profile.level_number += 1
          current_level.load_player
          UI.puts "Starting Level #{current_level.number}"
          current_level.play
          if current_level.passed?
            if next_level.exists?
              UI.puts "Success! You have found the stairs."
            else
              UI.puts "CONGRATULATIONS! You have climbed to the top of the tower and rescue the fair maiden Ruby."
              playing = false
            end
            current_level.tally_points
          else
            playing = false
            UI.puts "Sorry, you failed the level. Change your script and try again."
            if current_level.clue && UI.ask("Would you like to read the additional clues for this level?")
              UI.puts current_level.clue
            end
          end
        end
        profile.save # saves the score for epic mode
      else
        if current_level.number.zero?
          prepare_next_level
          UI.puts "First level has been generated. See the ruby-warrior directory for instructions."
        else
          current_level.load_player
          UI.puts "Starting Level #{current_level.number}"
          current_level.play
          if current_level.passed?
            if next_level.exists?
              UI.puts "Success! You have found the stairs."
            else
              UI.puts "CONGRATULATIONS! You have climbed to the top of the tower and rescue the fair maiden Ruby."
            end
            current_level.tally_points
            if (next_level.exists? ? UI.ask("Would you like to continue on to the next level?") : UI.ask("Would you like to continue on to epic mode?"))
              if next_level.exists?
                prepare_next_level
                UI.puts "See the ruby-warrior directory for the next level."
              else
                prepare_epic_mode
                UI.puts "Run rubywarrior again to play epic mode."
              end
            else
              UI.puts "Staying on current level. Try to earn more points next time."
            end
          else
            UI.puts "Sorry, you failed the level. Change your script and try again."
            if current_level.clue && UI.ask("Would you like to read the additional clues for this level?")
              UI.puts current_level.clue
            end
          end
        end
      end
    end
    
    def make_game_directory
      if UI.ask("No ruby-warrior directory found, would you like to create one?")
        Dir.mkdir(Config.path_prefix + '/ruby-warrior')
      else
        UI.puts "Unable to continue without directory."
        exit
      end
    end
    
    def prepare_next_level
      next_level.generate_player_files
      profile.level_number += 1
      profile.save # this saves score and new abilities too
    end
    
    def prepare_epic_mode
      profile.enable_epic_mode
      profile.level_number = 0
      profile.save # this saves score too
    end
    
    
    # profiles
    
    def profiles
      profile_paths.map { |profile| Profile.load(profile) }
    end
    
    def profile_paths
      Dir[Config.path_prefix + '/ruby-warrior/**/.profile']
    end
    
    def profile
      @profile ||= choose_profile
    end
    
    def new_profile
      profile = Profile.new
      profile.tower_path = UI.choose('tower', towers).path
      profile.warrior_name = UI.request('Enter a name for your warrior: ')
      profile
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
      @next_level ||= profile.next_level
    end
    
    
    private
    
    def choose_profile # REFACTORME
      profile = UI.choose('profile', profiles + [[:new, 'New Profile']])
      if profile == :new
        profile = new_profile
        if profiles.any? { |p| p.tower_path == profile.tower_path }
          if UI.ask("Are you sure you want to replace your existing profile for this tower?")
            UI.puts("Replacing existing profile.")
            profile
          else
            UI.puts("Not replacing profile.")
            exit
          end
        else
          profile
        end
      else
        profile
      end
    end
    
  end
end
