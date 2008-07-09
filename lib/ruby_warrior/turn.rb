module RubyWarrior
  class Turn
    attr_reader :action
    
    def initialize(actions, senses)
      @action = nil
      @senses = {}
      
      add_actions(actions)
      add_senses(senses)
    end
    
    private
    
    def add_actions(actions)
      actions.each do |action|
        instance_eval <<-EOS
          def #{action}!(*args)
            raise "Only one action can be performed per turn." if @action
            @action = [:#{action}, *args]
          end
        EOS
      end
    end
    
    def add_senses(senses)
      senses.each do |name, sense|
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
end
