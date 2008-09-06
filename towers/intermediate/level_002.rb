#  -----
# | @ s |
# |s  S>|
#  -----

description "Another large room, but with several enemies blocking your way to the stairs."
tip "Just like walking, you can attack! and feel in multiple directions (:forward, :left, :right, :backward)."

time_bonus 40
size 5, 3
stairs 4, 1

warrior 1, 0, :east do |u|
  u.add_abilities :attack!, :health, :rest!
end
unit :sludge, 3, 0, :west
unit :thick_sludge, 3, 1, :west
unit :sludge, 0, 1, :north
