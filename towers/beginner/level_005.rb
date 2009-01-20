#  -------
# |@ CaaSC|
#  -------

description "You hear cries for help. Captives must need rescuing."
tip "Use warrior.feel.captive? to see if there's a captive, and warrior.rescue! to rescue him. Don't attack captives."
clue "Don't forget to constantly check if you're taking damage and rest until your health is full if you aren't taking damage."

time_bonus 45
size 7, 1
stairs 6, 0

warrior 0, 0, :east do |u|
  u.add_abilities :rescue!
end

unit :captive, 2, 0, :west
unit :archer, 3, 0, :west
unit :archer, 4, 0, :west
unit :thick_sludge, 5, 0, :west
unit :captive, 6, 0, :west
