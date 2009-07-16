Feature: Manage Profiles
  In order play ruby warrior
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
    And I should find file at "tmp/ruby-warrior"
    When I run rubywarrior
    Then I should see "Joe - beginner - level 1 - score 0"

  Scenario: Another new profile
    Given a profile named "Joe" on "beginner"
    When I run rubywarrior
    And I choose "New" for "profile"
    And I choose "intermediate" for "tower"
    And I answer "Bob" to "name"
    Then I should see "generated"
    When I run rubywarrior
    Then I should see "Bob - intermediate - level 1 - score 0"

  Scenario: Replace profile in same tower (someday support multiple profiles)
    Given a profile named "Joe" on "beginner"
    When I run rubywarrior
    And I choose "New" for "profile"
    And I choose "beginner" for "tower"
    And I answer "Bill" to "name"
    And I answer "y" to "replace"
    Then I should see "generated"
    When I run rubywarrior
    Then I should see "Bill - beginner - level 1 - score 0"
