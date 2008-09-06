#  ---------
# |@ s ss s>|
#  ---------

description "The air feels thicker than before. There must be a horde of sludge."
tip "Be careful not to die! Use warrior.health to keep an eye on your health, and warrior.rest! to earn 10% of max health back."

time_bonus 35
size 9, 1
stairs 8, 0

warrior 0, 0, :east do |u|
  u.add_abilities :health, :rest!
end

unit :sludge, 2, 0, :west
unit :sludge, 4, 0, :west
unit :sludge, 5, 0, :west
unit :sludge, 7, 0, :west
