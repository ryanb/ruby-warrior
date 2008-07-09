module RubyWarrior
  module Units
    class Base
      attr_accessor :position, :health
      
      def attack_power
        0
      end
      
      def take_damage(amount)
        if @health
          @health -= amount
          say "takes #{amount} damage, #{@health} health power left"
          if @health <= 0
            @position = nil
            say "dies"
          end
        end
      end
      
      def say(msg)
        UI.puts "#{name} #{msg}"
      end
      
      def name
        self.class.name.split('::').last
      end
      alias_method :to_s, :name
      
      def add_actions(*new_actions)
        new_actions.each do |action|
          actions[action] = eval("Abilities::#{action.to_s.capitalize}").new(self) # TODO use something similar to constantize here
        end
      end
      
      def add_senses(*new_senses)
        new_senses.each do |sense|
          senses[sense] = eval("Abilities::#{sense.to_s.capitalize}").new(self) # TODO use something similar to constantize here
        end
      end
      
      def next_turn
        Turn.new(actions.keys, senses)
      end
      
      def prepare_turn
        @current_turn = next_turn
        play_turn(@current_turn)
      end
      
      def perform_turn
        if @current_turn.action && @position
          name, *args = @current_turn.action
          actions[name].perform(*args)
        end
      end
      
      def play_turn(turn)
        # to be overriden by subclass
      end
      
      def actions
        @actions ||= {}
      end
      
      def senses
        @senses ||= {}
      end
    end
  end
end
