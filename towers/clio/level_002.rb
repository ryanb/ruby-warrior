description "You see before yourself a long hallway with stairs at the end. There is nothing in the way, but there's a weird fish off to the side."
tip "Call warrior.skip! again. Ignore the fish, it's probably harmless."

time_bonus 15
ace_score 10
size 8, 2
stairs 7, 0

warrior 0, 0, :east do |u|
  u.add_abilities :skip!
end

unit :magikarp, 4, 1, :north
