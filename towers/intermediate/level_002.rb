#  ----
# |@ s |
# | sS>|
#  ----

description "Another large room, but with several enemies blocking your way to the stairs."
tip "Just like walking, you can attack! and feel in multiple directions (:forward, :left, :right, :backward)."
clue "Call warrior.feel(direction).enemy? in each direction to make sure there isn't an enemy beside you (attack if there is). Call warrior.rest! if you're low and health when there's no enemies around."

time_bonus 40
size 4, 2
stairs 3, 1

warrior 1, 0, :east do |u|
  u.add_abilities :attack!, :health, :rest!
end
unit :sludge, 2, 0, :west
unit :thick_sludge, 2, 1, :west
unit :sludge, 1, 1, :north
