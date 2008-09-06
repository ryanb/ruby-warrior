#  -----
# | @ sC|
# |s  S>|
# |Cs sC|
#  -----

description "Another large room, but with several enemies blocking your way to the stairs."
tip "Just like walking, you can attack and feel in multiple directions (:forward, :left, :right, :backward)."

time_bonus 60
size 5, 3
stairs 4, 1

warrior 1, 0, :east
unit :sludge, 3, 0, :west
unit :thick_sludge, 3, 1, :west
unit :sludge, 3, 2, :west
unit :sludge, 0, 1, :north
unit :sludge, 1, 2, :north
unit :captive, 0, 2, :north
unit :captive, 4, 0, :west
unit :captive, 4, 2, :west
