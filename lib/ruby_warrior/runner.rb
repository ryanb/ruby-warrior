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
      RubyWarrior::UI.in_stream = @stdin
      RubyWarrior::UI.out_stream = @stdout
      RubyWarrior::UI.delay = 0.8 # TODO allow customization
      parse_options
      @game.start
    end
    
    private
    
    def parse_options
      options = OptionParser.new 
      options.banner = "Usage: rubywarrior [options]"
      options.on('-d', '--directory DIR', 'Run under given directory') { |dir| RubyWarrior::Config.path_prefix = dir }
      options.on('-t', '--time SECONDS', 'Delay each turn by seconds') { |seconds| RubyWarrior::UI.delay = seconds.to_f }
      options.on('-h', '--help', 'Show this message') { puts(options); exit }
      options.parse!(@arguments)
    end
  end
end
