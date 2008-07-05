module RubyWarrior
  module Units
    class Warrior
      attr_accessor :position
      
      def initialize
        @abilities_mod = Module.new
        self.extend @abilities_mod
      end
      
      def turn
        player.turn(self)
      end
      
      def player
        @player ||= Player.new
      end
      
      # TODO there may be a better way to do this
      def add_action(action)
        instance_eval <<-EOS
          def #{action}!(*args, &block)
            Abilities::#{action.to_s.capitalize}.new(self).perform(*args, &block)
          end
        EOS
      end
    end
  end
end
