require 'optparse'

module RubyWarrior
  class Runner
    def initialize(arguments, stdin, stdout)
      @arguments = arguments
      @stdin = stdin
      @stdout = stdout
      @game = RubyWarrior::Game.new
    end
    
    def run
      Config.in_stream = @stdin
      Config.out_stream = @stdout
      Config.delay = 0.6
      parse_options
      @game.start
    end
    
    private
    
    def parse_options
      options = OptionParser.new 
      options.banner = "Usage: rubywarrior [options]"
      options.on('-d', '--directory DIR', "Run under given directory")  { |dir| Config.path_prefix = dir }
      options.on('-l', '--level LEVEL',   "Practice level on epic")     { |level| Config.practice_level = level.to_i }
      options.on('-s', '--skip',          "Skip user input")            { Config.skip_input = true }
      options.on('-t', '--time SECONDS',  "Delay each turn by seconds") { |seconds| Config.delay = seconds.to_f }
      options.on('-h', '--help',          "Show this message")          { puts(options); exit }
      options.parse!(@arguments)
    end
  end
end
