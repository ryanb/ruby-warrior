module RubyWarrior
  module Units
    class ThickSludge < Sludge
      def max_health
        24
      end
      
      def to_map
        "S"
      end
    end
  end
end
