#  ----
# |C aC|
# | S s|
# |C>@ |
#  ----

description "You can feel the stairs right next to you, but are you sure you want to go up them right away?"
tip "You'll get more points for clearing the level first. Use warrior.feel.stairs? and warrior.listen."

time_bonus 55
size 4, 3
stairs 1, 2

warrior 2, 2, :north do |u|
  u.add_abilities :listen
end

unit :sludge, 2, 0, :south
unit :sludge, 3, 1, :east
unit :thick_sludge, 1, 1, :west
unit :captive, 0, 0, :east
unit :captive, 3, 0, :west
unit :captive, 0, 2, :north
