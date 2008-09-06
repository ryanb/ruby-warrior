#  ------
# |> aS @|
#  ------

description "You feel a wall right in front of you and an opening behind you."
tip "Use warrior.feel.wall? and warrior.pivot! to turn around."

time_bonus 30
size 6, 1
stairs 0, 0

warrior 5, 0, :east do |u|
  u.add_abilities :pivot!
end

unit :archer, 2, 0, :east
unit :sludge, 3, 0, :east
