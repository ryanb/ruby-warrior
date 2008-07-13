#  +----------+
#  |@        ^|
#  +----------+

level 1, :width => 8, :height => 1
description "You see before yourself a long hallway with stairs at the end. There is nothing in the way."
tip "Call warrior.walk! to walk forward in the Player 'play_turn' method."

stairs :x => 7, :y => 0

warrior :x => 0, :y => 0, :facing => :east do |u|
  u.add_abilities :walk!
end
