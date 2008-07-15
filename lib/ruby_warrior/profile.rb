require 'base64'

module RubyWarrior
  class Profile
    attr_accessor :score, :abilities, :level_number, :tower_path, :warrior_name
    
    def initialize
      @tower_path = nil
      @warrior_name = nil
      @score = 0
      @abilities = []
      @level_number = 0
    end
    
    def encode
      Base64.encode64(Marshal.dump(self))
    end
    
    def save
      File.open(player_path + '/.profile', 'w') { |f| f.write(encode) }
    end
    
    def self.decode(str)
      Marshal.load(Base64.decode64(str))
    end
    
    def self.load(path)
      decode(File.read(path))
    end
    
    def player_path
      "ruby-warrior/#{tower.name}-tower"
    end
    
    def current_level_path
      player_path + "/level-" + level_number.to_s.rjust(3, '0')
    end
    
    def to_s
      [warrior_name, tower.name, "level #{level_number}", "score #{score}"].join(' - ')
    end
    
    def tower
      Tower.new(@tower_path)
    end
    
    def current_level
      tower.build_level(level_number, self) unless level_number.zero?
    end
    
    def next_level
      tower.build_level(level_number+1, self)
    end
    
    def add_abilities(*abilities)
      @abilities += abilities
      @abilities.uniq!
    end
  end
end
