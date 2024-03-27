require "base64"

module RubyWarrior
  class Profile
    attr_accessor :score,
                  :epic_score,
                  :current_epic_score,
                  :average_grade,
                  :current_epic_grades,
                  :abilities,
                  :level_number,
                  :last_level_number,
                  :tower_path,
                  :warrior_name,
                  :player_path

    def initialize
      @tower_path = nil
      @warrior_name = nil
      @score = 0
      @current_epic_score = 0
      @current_epic_grades = {}
      @epic_score = 0
      @average_grade = nil
      @abilities = []
      @level_number = 0
      @last_level_number = nil
    end

    def encode
      Base64.encode64(Marshal.dump(self))
    end

    def save
      update_epic_score
      @level_number = 0 if epic?
      File.open(player_path + "/.profile", "w") { |f| f.write(encode) }
    end

    def self.decode(str)
      Marshal.load(Base64.decode64(str))
    end

    def self.load(path)
      player = decode(File.read(path))
      player.player_path = File.dirname(path)
      player
    end

    def player_path
      @player_path || Config.path_prefix + "/rubywarrior/#{directory_name}"
    end

    def directory_name
      [warrior_name.downcase.gsub(/[^a-z0-9]+/, "-"), tower.name].join("-")
    end

    def to_s
      if epic?
        [
          warrior_name,
          tower.name,
          "first score #{score}",
          "epic score #{epic_score_with_grade}",
        ].join(" - ")
      else
        [warrior_name, tower.name, "level #{level_number}", "score #{score}"].join(" - ")
      end
    end

    def epic_score_with_grade
      average_grade ? "#{epic_score} (#{Level.grade_letter(average_grade)})" : epic_score
    end

    def tower
      Tower.new(File.basename @tower_path)
    end

    def current_level
      Level.new(self, level_number)
    end

    def next_level
      Level.new(self, level_number + 1)
    end

    def add_abilities(*abilities)
      @abilities += abilities
      @abilities.uniq!
    end

    def enable_epic_mode
      @epic = true
      @epic_score ||= 0
      @current_epic_score ||= 0
      @last_level_number ||= @level_number
    end

    def enable_normal_mode
      @epic = false
      @epic_score = 0
      @current_epic_score = 0
      @current_epic_grades = {}
      @average_grade = nil
      @level_number = @last_level_number
      @last_level_number = nil
    end

    def epic?
      @epic
    end

    def level_after_epic?
      Level.new(self, last_level_number + 1).exists? if last_level_number
    end

    def update_epic_score
      if @current_epic_score > @epic_score
        @epic_score = @current_epic_score
        @average_grade = calculate_average_grade
      end
    end

    def calculate_average_grade
      if @current_epic_grades.size > 0
        sum = @current_epic_grades.values.inject(0) { |sum, value| sum + value }
        sum / @current_epic_grades.size
      end
    end
  end
end
