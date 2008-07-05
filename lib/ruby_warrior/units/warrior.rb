module RubyWarrior
  module Units
    class Warrior
      attr_accessor :position
      
      def initialize
        @abilities_mod = Module.new
        self.extend @abilities_mod
      end
      
      def turn
        @action_called = false
        player.turn(self)
      end
      
      def player
        @player ||= Player.new
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
    end
  end
end
