#  -------
# |@ Sa S>|
#  -------

description "You can hear bow strings being stretched."
tip "No new abilities this time, but you must be careful not to rest while taking damage. Save a @health instance variable and compare it on each turn to see if you're taking damage."
clue "Set @health to your current health at the end of the turn. If this is greater than your current health next turn then you know you're taking damage and shouldn't rest."

time_bonus 45
ace_score 90
size 7, 1
stairs 6, 0

warrior 0, 0, :east

unit :thick_sludge, 2, 0, :west
unit :archer, 3, 0, :west
unit :thick_sludge, 5, 0, :west
