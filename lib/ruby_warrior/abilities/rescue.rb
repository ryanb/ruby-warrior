module RubyWarrior
  module Abilities
    class Rescue < Base
      def description
        "Rescue a captive from his chains (earning 20 points) in given direction (forward by default)."
      end
      
      def perform(direction = :forward)
        if space(direction).captive?
          recipient = unit(direction)
          @unit.say "unbinds #{recipient}"
          recipient.unbind
          if recipient.kind_of? Units::Captive
            recipient.position = nil
            @unit.earn_points(20)
          end
        else
          @unit.say "rescues nothing"
        end
      end
    end
  end
end
