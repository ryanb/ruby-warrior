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
    Then I should see "directory for the next level"
  
  Scenario: Skip user input with -s option
    Given a profile named "Joe" on "beginner"
    When I copy fixture "walking_player.rb" to "tmp/ruby-warrior/joe-beginner/player.rb"
    And I run rubywarrior with options "-d tmp/ruby-warrior/joe-beginner -t 0 -s"
    Then I should see "current level"
    When I run rubywarrior with options "-d tmp/ruby-warrior/joe-beginner -t 0"
    And I answer "y" to "next level"
    Then I should see "directory for the next level"
    When I run rubywarrior with options "-d tmp/ruby-warrior/joe-beginner -t 0 -s"
    Then I should see "failed the level"
