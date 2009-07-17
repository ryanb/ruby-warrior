#  --
# |@>|
#  --

description "You see before yourself a long hallway with stairs at the end. There is nothing in the way."
tip "Call warrior.walk! to walk forward in the Player 'play_turn' method."

time_bonus 15
size 2, 1
stairs 1, 0

warrior 0, 0, :east do |u|
  u.add_abilities :walk!
end
