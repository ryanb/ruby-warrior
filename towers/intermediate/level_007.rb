#  -----
# | sC >|
# |@ s C|
# | s   |
#  -----

description "Another ticking sound, but some sludge is blocking the way."
tip "Quickly kill the sludge and rescue the captive before the bomb goes off. You can't simply go around them."
clue "Determine the direction of the ticking captive and kill any enemies blocking that path. You may need to bind surrounding enemies first."

time_bonus 70
ace_score 134
size 5, 3
stairs 4, 0

warrior 0, 1, :east

unit :sludge, 1, 0, :south
unit :sludge, 1, 2, :north
unit :sludge, 2, 1, :west
unit :captive, 4, 1, :west do |u|
  u.add_abilities :explode!
  u.abilities[:explode!].time = 10
end
unit :captive, 2, 0, :west
