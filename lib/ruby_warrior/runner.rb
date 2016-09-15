require 'optparse'
require 'fileutils'

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
       
    def reset
      if ! File.directory?('rubywarrior/')
        # If the directory doesn't exist, we can't reset the progress.
        print "No progress to reset.\n" 
      else
        directories = Dir["rubywarrior/*"]
        if directories.length>0
          puts inputProfile = UI.choose('directory', directories)
          if inputProfile != nil
	          if File.directory?('%{IN}'% {IN:inputProfile})
              # Prompt the user to avoid accidental an reset.
              print "Are you sure you want to reset your progress? [yn]\n"
              input = gets.chomp
              if input == 'y'
                FileUtils.rm_rf('%{IN}'% {IN:inputProfile} )
                print "Progress reset.\n"
              elsif input == 'n'
                print "Progress not reset.\n"
              else
                print "Not a valid option (y or n). Please try again.\n"
                reset
              end
            else
              print "No such profile.\n"
	          end
          else
            print "No profile name provided.\n" 
          end
        else 
          print "No profile to reset."
        end
      end
      exit
    end
	 
    private
    
    def parse_options
      options = OptionParser.new 
      options.banner = "Usage: rubywarrior [options]"
      options.on('-d', '--directory DIR', "Run under given directory")  { |dir| Config.path_prefix = dir }
      options.on('-l', '--level LEVEL',   "Practice level on epic")     { |level| Config.practice_level = level.to_i }
      options.on('-r', '--reset',         "Reset all Progress ")        { reset }
      options.on('-s', '--skip',          "Skip user input")            { Config.skip_input = true }
      options.on('-t', '--time SECONDS',  "Delay each turn by seconds") { |seconds| Config.delay = seconds.to_f }
      options.on('-h', '--help',          "Show this message")          { puts(options); exit }
      options.parse!(@arguments)
    end
  end
end
