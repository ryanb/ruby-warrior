#  ------
# | SC  >|
# |@  SC |
#  ------

description "What's that ticking? Some captives have a timed bomb at their feet!"
tip "It's best to rescue captives first that have space.ticking?, they'll soon go!"
clue "Avoid fighting enemies at first. Go around them until you've rescued all of the ticking captives."

time_bonus 50
ace_score 130
size 6, 2
stairs 5, 0

warrior 0, 1, :east

unit :thick_sludge, 1, 0, :west
unit :thick_sludge, 3, 1, :west
unit :captive, 2, 0, :west do |u|
  u.bomb_time = 6
end
unit :captive, 4, 1, :west do |u|
  u.bomb_time = 10
end
