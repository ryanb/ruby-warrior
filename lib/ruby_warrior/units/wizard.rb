module RubyWarrior
  module Units
    class Wizard < Base
      def initialize
        add_abilities :shoot!, :look
      end

      def play_turn(turn)
        %i[forward left right].each do |direction|
          turn
            .look(direction)
            .each do |space|
              if space.player?
                turn.shoot!(direction)
                return
              elsif !space.empty?
                break
              end
            end
        end
      end

      def shoot_power
        11
      end

      def max_health
        3
      end

      def character
        "w"
      end
    end
  end
end
