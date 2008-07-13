require 'base64'

module RubyWarrior
  class Profile
    attr_accessor :score, :abilities, :level_number
    attr_reader :warrior_name
    
    def initialize(tower_path, warrior_name)
      @tower_path = tower_path
      @warrior_name = warrior_name
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
    
    def warrior
      warrior = Units::Warrior.new(self)
      warrior.add_abilities(*abilities) # TODO abilities should probably be added in Warrior#initialize
      warrior
    end
  end
end
