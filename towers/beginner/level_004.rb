#  -------
# |W Sa S>|
#  -------

description "You can hear bow strings being stretched."
tip "No new abilities this time, but you must be careful not to rest while taking damage. Save a @health instance variable and compare it on each turn to see if you're taking damage."

time_bonus 45
size 7, 1
stairs 6, 0

warrior 0, 0, :east

unit :thick_sludge, 2, 0, :west
unit :archer, 3, 0, :west
unit :thick_sludge, 5, 0, :west
