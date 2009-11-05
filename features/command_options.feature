Feature: Command Options
  In order to play the game the way I want
  As a player
  I want to customize ruby-warrior with options
  
  Background:
    Given no profile at "tmp"
  
  Scenario: Run ruby warrior in specified directory with -d option
    Given a profile named "Joe" on "beginner"
    When I copy fixture "walking_player.rb" to "tmp/ruby-warrior/joe-beginner/player.rb"
    And I run rubywarrior with options "-d tmp/ruby-warrior/joe-beginner -t 0"
    And I answer "y" to "next level"
    Then I should see "the updated README in the ruby-warrior/joe-beginner directory"
  
  Scenario: Skip user input with -s option
    Given a profile named "Joe" on "beginner"
    When I copy fixture "walking_player.rb" to "tmp/ruby-warrior/joe-beginner/player.rb"
    And I run rubywarrior with options "-d tmp/ruby-warrior/joe-beginner -t 0 -s"
    Then I should see "current level"
    When I run rubywarrior with options "-d tmp/ruby-warrior/joe-beginner -t 0"
    And I answer "y" to "next level"
    Then I should see "the updated README in the ruby-warrior/joe-beginner directory"
    When I run rubywarrior with options "-d tmp/ruby-warrior/joe-beginner -t 0 -s"
    Then I should see "failed level 2"
  
  Scenario: Unable to practice level if not epic
    Given a profile named "Joe" on "beginner"
    When I copy fixture "walking_player.rb" to "tmp/ruby-warrior/joe-beginner/player.rb"
    And I run rubywarrior with options "-d tmp/ruby-warrior/joe-beginner -l 2"
    Then I should see "Unable"
  
  Scenario: Practice specific level when epic
    When I copy fixture "short-tower" to "towers/short"
    Given a profile named "Bill" on "short"
    When I copy fixture "walking_player.rb" to "tmp/ruby-warrior/bill-short/player.rb"
    And I run rubywarrior
    And I choose "Bill - short - level 1" for "profile"
    Then I answer "y" to "next level"
    And I should see "the updated README in the ruby-warrior/bill-short directory"
    When I run rubywarrior
    And I choose "Bill - short - level 2" for "profile"
    Then I answer "y" to "epic"
    And I should see "epic mode"
    When I run rubywarrior with options "-d tmp/ruby-warrior/bill-short -l 2"
    Then I should not see "Level 1" before "Total Score: 17"
