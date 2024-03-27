require "optparse"

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
      options.on("-d", "--directory DIR", "Run under given directory") do |dir|
        Config.path_prefix = dir
      end
      options.on("-l", "--level LEVEL", "Practice level on epic") do |level|
        Config.practice_level = level.to_i
      end
      options.on("-s", "--skip", "Skip user input") { Config.skip_input = true }
      options.on("-t", "--time SECONDS", "Delay each turn by seconds") do |seconds|
        Config.delay = seconds.to_f
      end
      options.on("-h", "--help", "Show this message") do
        puts(options)
        exit
      end
      options.parse!(@arguments)
    end
  end
end
