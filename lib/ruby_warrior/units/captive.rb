module RubyWarrior
  module Units
    class Captive < Base
      def initialize
        bind
      end
      
      def max_health
        1
      end
      
      def to_map
        "C"
      end
    end
  end
end
