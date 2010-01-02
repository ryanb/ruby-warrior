Feature: Manage Profiles
  In order to play ruby warrior
  As a player
  I want to create and choose profiles
  
  Background:
    Given no profile at "tmp"

  Scenario: New profile
    When I run rubywarrior
    And I answer "y" to "create one?"
    And I choose "beginner" for "tower"
    And I answer "Joe" to "name"
    Then I should see "generated"
    And I should find file at "tmp/rubywarrior"
    When I run rubywarrior
    Then I should see "Joe - beginner - level 1 - score 0"

  Scenario: Another new profile on same tower
    Given a profile named "Joe" on "beginner"
    When I run rubywarrior
    And I choose "New" for "profile"
    And I choose "beginner" for "tower"
    And I answer "Bob" to "name"
    Then I should see "generated"
    When I run rubywarrior
    Then I should see "Bob - beginner - level 1 - score 0"

  Scenario: Replace profile in same tower with same name
    Given a profile named "Joe" on "beginner"
    When I run rubywarrior
    And I choose "New" for "profile"
    And I choose "beginner" for "tower"
    And I answer "Joe" to "name"
    And I answer "y" to "replace"
    Then I should see "generated"
    When I run rubywarrior
    Then I should see "Joe - beginner - level 1 - score 0"
  
  Scenario: Auto select profile at given path
    Given a profile named "Joe" on "beginner"
    And current directory is "tmp/rubywarrior/joe-beginner"
    When I copy fixture "walking_player.rb" to "tmp/rubywarrior/joe-beginner/player.rb"
    And I run rubywarrior
    And I answer "y" to "next level"
    Then I should see "the updated README in the rubywarrior/joe-beginner directory"

  Scenario: Move legacy ruby-warrior profile
    Given a directory at "tmp/ruby-warrior"
    And no directory at "tmp/rubywarrior"
    When I run rubywarrior
    And I choose "beginner" for "tower"
    And I answer "Joe" to "name"
    Then I should see "generated"
    And I should find file at "tmp/rubywarrior"
    And I should find no file at "tmp/ruby-warrior"
