require 'rubygems'
require 'fileutils'
require 'erb'

module RubyWarrior
  class PlayerGenerator
    def initialize(path, level)
      @player_path = path
      @level = level
    end
    
    def level_name
      "level-" + @level.number.to_s.rjust(3, '0')
    end
    
    def level_path(other_path = nil)
      if other_path
        File.join(level_path, File.basename(other_path, '.*'))
      else
        File.join(@player_path, level_name)
      end
    end
    
    def generate
      FileUtils.mkdir_p(level_path)
      Dir[templates_path + '/*.erb'].each do |path|
        copy_template(path) unless File.exist?(level_path(path))
      end
    end
    
    private
    
    def templates_path
      File.expand_path(File.dirname(__FILE__) + "/../../templates")
    end
    
    def copy_template(path)
      File.open level_path(path), 'w' do |f|
        f.write read_template(path)
      end
    end
    
    def read_template(path)
      ERB.new(File.read(path), nil, '-').result(binding)
    end
  end
end
