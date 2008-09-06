#  --------
# |C @ S aa|
#  --------

description "The wall behind you feels a bit further away in this room. And you hear more cries for help."
tip "You can walk backward by passing ':backward' as an argument to walk!. Same goes for feel, rescue! and attack!."

time_bonus 55
size 8, 1
stairs 7, 0

warrior 2, 0, :east

unit :captive, 0, 0, :east
unit :thick_sludge, 4, 0, :west
unit :archer, 6, 0, :west
unit :archer, 7, 0, :west
