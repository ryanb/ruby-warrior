Feature: Play levels
  In order to play ruby warrior
  As a player
  I want to advance through levels or retry them
  
  Background:
    Given no profile at "tmp"
    And a profile named "Joe" on "beginner"
  
  Scenario: Pass first level, fail second level
    When I copy fixture "walking_player.rb" to "tmp/ruby-warrior/beginner-tower/level-001/player.rb"
    And I run rubywarrior
    And I choose "Joe - beginner - level 1" for "profile"
    Then I answer "y" to "next level"
    And I should see "directory for the next level"
    When I copy fixture "walking_player.rb" to "tmp/ruby-warrior/beginner-tower/level-002/player.rb"
    And I run rubywarrior
    And I choose "Joe - beginner - level 2" for "profile"
    And I answer "y" to "clues"
    Then I should see "warrior.feel.empty?"
  
  Scenario: Retry first level
    When I copy fixture "walking_player.rb" to "tmp/ruby-warrior/beginner-tower/level-001/player.rb"
    And I run rubywarrior
    And I choose "Joe - beginner - level 1" for "profile"
    Then I answer "n" to "next level"
    And I should see "current level"
    When I run rubywarrior
    Then I should see "Joe - beginner - level 1"
