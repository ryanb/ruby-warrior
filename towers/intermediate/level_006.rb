#  ------
# |Cs   >|
# |@  sC |
#  ------

description "What's that ticking? Some captives have a timed bomb at their feet!"
tip "Hurry and rescue captives first that have space.ticking?, they'll soon go!"
clue "Avoid fighting enemies at first. Use warrior.listen and space.ticking? and quickly rescue those captives."

time_bonus 50
ace_score 108
size 6, 2
stairs 5, 0

warrior 0, 1, :east

unit :sludge, 1, 0, :west
unit :sludge, 3, 1, :west
unit :captive, 0, 0, :west
unit :captive, 4, 1, :west do |u|
  u.add_abilities :explode!
  u.abilities[:explode!].time = 7
end
