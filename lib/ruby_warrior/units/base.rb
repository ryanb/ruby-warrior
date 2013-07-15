module RubyWarrior
  module Units
    class Base
      attr_writer :health
      attr_accessor :position
      
      def attack_power
        0
      end
      
      def max_health
        0
      end
      
      def earn_points(points)
      end
      
      def health
        @health ||= max_health
      end
      
      def take_damage(amount)
        unbind if bound?
        if health
          self.health -= amount
          say "takes #{amount} damage, #{health} " + "health power".red \
          + " left"

          if health <= 0
            @position = nil
            say "dies".bold.red
          end
        end
      end
      
      def alive?
        !position.nil?
      end
      
      def bound?
        @bound
      end
      
      def unbind
        say "released from bonds"
        @bound = false
      end
      
      def bind
        @bound = true
      end
      
      def say(msg)
        # Might want to just switch the color based on whether it's a Warrior
        # or a Golem or not, rather than print the entire string in both
        # code bodies. (i.e., Have the print below the if / else block,
        # and just change the color in the conditional switch.)
        if self.class == Warrior or self.class == Golem
          UI.puts_with_delay "#{name}".green.bold + " #{msg}"
        else
          UI.puts_with_delay "#{name}".brown.bold + " #{msg}"
        end
      end
      
      def name
        self.class.name.split('::').last.titleize
      end
      alias_method :to_s, :name
      
      def add_abilities(*new_abilities)
        new_abilities.each do |ability|
          abilities[ability] = eval("Abilities::#{ability.to_s.sub('!', '').camelize}").new(self) # TODO use something similar to constantize here
        end
      end
      
      def next_turn
        Turn.new(abilities)
      end
      
      def prepare_turn
        @current_turn = next_turn
        play_turn(@current_turn)
      end
      
      def perform_turn
        if @position
          abilities.values.each do |ability|
            ability.pass_turn
          end
          if @current_turn.action && !bound?
            name, *args = @current_turn.action
            abilities[name].perform(*args)
          end
        end
      end
      
      def play_turn(turn)
        # to be overriden by subclass
      end
      
      def abilities
        @abilities ||= {}
      end
      
      def character
        "?"
      end
    end
  end
end
