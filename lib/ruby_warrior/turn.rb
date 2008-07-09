module RubyWarrior
  class Turn
    attr_reader :action
    
    def initialize(actions, senses)
      actions.each do |action|
        instance_eval <<-EOS
          def #{action}!(*args, &block)
            raise "Only one action can be performed per turn." if @action
            @action = [:#{action}, *args]
          end
        EOS
      end
    end
  end
end
