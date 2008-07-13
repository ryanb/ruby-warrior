module RubyWarrior
  class Turn
    attr_reader :action
    
    def initialize(abilities)
      @action = nil
      @senses = {}
      
      abilities.each do |name, sense|
        if name.to_s =~ /\!$/
          add_action(name)
        else
          add_sense(name, sense)
        end
      end
    end
    
    private
    
    def add_action(action)
      instance_eval <<-EOS
        def #{action}(*args)
          raise "Only one action can be performed per turn." if @action
          @action = [:#{action}, *args]
        end
      EOS
    end
    
    def add_sense(name, sense)
      instance_eval <<-EOS
        def #{name}(*args)
          @senses.fetch([:#{name}, args])
        end
      EOS
      sense.possible_arguments.each do |args|
        args = [args].flatten # in case args aren't in array
        @senses[[name, args]] = sense.perform(*args)
      end
    end
  end
end
