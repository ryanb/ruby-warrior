#  -------
# |@  Cww>|
#  -------

description "You hear the mumbling of wizards. Beware of their deadly wands! Good thing you found a bow."
tip "Use warrior.look to determine your surroundings, and warrior.shoot! to fire an arrow."
clue "Wizards are deadly but low in health. Kill them before they have time to attack."

time_bonus 20
size 6, 1
stairs 5, 0

warrior 0, 0, :east do |u|
  u.add_abilities :look
  u.add_abilities :shoot!
end

unit :captive, 2, 0, :west
unit :wizard, 3, 0, :west
unit :wizard, 4, 0, :west
