#  --------
# |@   s  >|
#  --------

description "It is too dark to see anything, but you smell sludge nearby."
tip "Use warrior.feel.empty? to see if there's anything in front of you, and warrior.attack! to fight it. Remember, you can only do one action (ending in !) per turn."

time_bonus 20
size 8, 1
stairs 7, 0

warrior 0, 0, :east do |u|
  u.add_abilities :feel, :attack!
end

unit :sludge, 4, 0, :west
