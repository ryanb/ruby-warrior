module RubyWarrior
  class Level
    attr_reader :profile, :number
    attr_accessor :description, :tip, :warrior, :floor, :time_bonus
    
    def initialize(profile, number)
      @profile = profile
      @number = number
      @time_bonus = 0
    end
    
    def player_path
      @profile.player_path + "/level-" + @number.to_s.rjust(3, '0')
    end
    
    def load_path
      @profile.tower_path + "/level_" + @number.to_s.rjust(3, '0') + ".rb"
    end
    
    def load_level
      LevelLoader.new(self).instance_eval(File.read(load_path))
    end
    
    def load_player
      $: << player_path
      load 'player.rb'
    end
    
    def generate_player_files
      load_level
      PlayerGenerator.new(self).generate
    end
    
    def play(turns = 1000)
      load_level
      turns.times do |n|
        return if passed? || failed?
        UI.puts "- turn #{n+1} -"
        @floor.units.each { |unit| unit.prepare_turn }
        @floor.units.each { |unit| unit.perform_turn }
        yield if block_given?
        @time_bonus -= 1 if @time_bonus > 0
      end
    end
    
    def tally_points
      @profile.abilities = warrior.abilities.keys
      
      UI.puts "Score during level: #{warrior.score}"
      @profile.score += warrior.score
      
      UI.puts "Time Bonus: #{time_bonus}"
      @profile.score += @time_bonus
      
      if floor.other_units.empty?
        UI.puts "Clear Bonus: #{clear_bonus}"
        @profile.score += clear_bonus
      end
      
      UI.puts "Total Score: #{@profile.score}"
    end
    
    def clear_bonus
      ((warrior.score + time_bonus)*0.2).round
    end
    
    def passed?
      @floor.stairs_space.warrior?
    end
    
    def failed?
      !@floor.units.include?(warrior)
    end
    
    def exists?
      File.exist? load_path
    end
    
    def setup_warrior(warrior)
      @warrior = warrior
      @warrior.add_abilities(*profile.abilities)
      @warrior.name = profile.warrior_name
    end
  end
end
