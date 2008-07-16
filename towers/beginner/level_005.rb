#  +--------+
#  |@ CSAC ^|
#  +--------+

description "You hear cries for help. Captives must need rescuing."
tip "Use warrior.feel.captive? to see if there's a captive, and warrior.rescue! to rescue him. Don't attack captives."

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
