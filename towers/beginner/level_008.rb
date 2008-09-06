#  ------
# |      |
# |@     |
# |      |
# |  >   |
#  ------

description "Silence. The room feels large, but empty. Where are the stairs?"
tip "Use warrior.detect to determine your current distance from the stairs. Pass :forward, :backward, :right, or :left to warrior.walk to move around."

time_bonus 30
size 6, 4
stairs 2, 3

warrior 0, 1, :east do |u|
  u.add_abilities :distance
end
