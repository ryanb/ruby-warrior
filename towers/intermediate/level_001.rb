#  ------
# |      |
# |@     |
# |      |
# |  >   |
#  ------

description "Silence. The room feels large, but empty. Luckily you have a map of this tower to help find the stairs."
tip "Use warrior.direction_of_stairs to determine which direction stairs are located. Pass this to warrior.walk! to walk in that direction."

time_bonus 20
size 6, 4
stairs 2, 3

warrior 0, 1, :east do |u|
  u.add_abilities :walk!, :feel, :direction_of_stairs
end
