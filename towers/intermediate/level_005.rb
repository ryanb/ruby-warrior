#  -----
# |    S|
# |@> SC|
#  -----

description "You can feel the stairs right next to you, but are you sure you want to go up them right away?"
tip "You'll get more points for clearing the level first. Use warrior.feel.stairs? and warrior.feel.empty? to determine where to go."

time_bonus 45
size 5, 2
stairs 1, 1

warrior 0, 1, :east

unit :thick_sludge, 4, 0, :west
unit :thick_sludge, 3, 1, :north
unit :captive, 4, 1, :west
