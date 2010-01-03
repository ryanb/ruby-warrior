module RubyWarrior
  module Units
    class Captive < Base
      def initialize
        bind
      end
      
      def max_health
        1
      end
      
      def character
        "C"
      end
    end
  end
end
