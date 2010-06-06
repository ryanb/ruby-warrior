#  ----
# |ssC>|
# |@sss|
# |ssC |
#  ----

description "Never before have you seen a room so full of sludge. Start the fireworks!"
tip "Be careful not to let the ticking captive get caught in the flames. Use warrior.distance_of to avoid the captives."
clue "Be sure to bind the surrounding enemies before fighting. Check your health before detonating explosives."

time_bonus 70
size 4, 3
stairs 3, 0

warrior 0, 1, :east do |u|
  u.add_abilities :distance_of
end

unit :captive, 2, 0, :south do |u|
  u.add_abilities :explode!
  u.abilities[:explode!].time = 20
end
unit :captive, 2, 2, :north

unit :sludge, 0, 0, :south
unit :sludge, 1, 0, :south
unit :sludge, 1, 1, :east
unit :sludge, 2, 1, :east
unit :sludge, 3, 1, :east
unit :sludge, 0, 2, :north
unit :sludge, 1, 2, :north
