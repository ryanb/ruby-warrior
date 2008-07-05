module RubyWarrior
  module Units
    class Base
      attr_accessor :position, :health
      
      def attack_power
        0
      end
      
      def perform_turn
        if @position
          @action_called = false
          turn
        end
      end
      
      def turn
        # to be overriden by subclass
      end
      
      def take_damage(amount)
        if @health
          @health -= amount
          @position = nil if @health <= 0
        end
      end
      
      # TODO there may be a better way to do this
      def add_actions(*actions)
        actions.each do |action|
          instance_eval <<-EOS
            def #{action}!(*args, &block)
              raise "already called action this turn" if @action_called
              Abilities::#{action.to_s.capitalize}.new(self).perform(*args, &block)
              @action_called = true
            end
          EOS
        end
      end
      
      def add_senses(*senses)
        senses.each do |sense|
          instance_eval <<-EOS
            def #{sense}(*args, &block)
              Abilities::#{sense.to_s.capitalize}.new(self).perform(*args, &block)
            end
          EOS
        end
      end
      
      def say(msg)
        UI.puts "#{name} #{msg}"
      end
      
      def name
        self.class.name.split('::').last
      end
    end
  end
end
