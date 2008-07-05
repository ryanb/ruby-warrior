#  +----------+
#  |@    S   ^|
#  +----------+

level 2, :width => 8, :height => 1
description "It is too dark to see anything, but you smell sludge nearby."
tip "Use warrior.feel to see if there's anything in front of you, and warrior.attack! to fight it. Remember, you can only do one action (ending in !) per turn."

stairs :x => 7, :y => 0

warrior :x => 0, :y => 0, :facing => :east do |u|
  u.add_actions :walk, :attack
  u.add_senses :feel
end

unit :sludge, :x => 4, :y => 0, :facing => :west
