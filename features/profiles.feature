Feature: Manage Profiles
  In order play ruby warrior
  As a player
  I want to create and choose profiles
  
  Background:
    Given I have no profile

  Scenario: New profile
    When I run rubywarrior
    And I answer "y" to "create one?"
    And I choose "beginner" for "tower"
    And I answer "Joe" to "name"
    Then I should see "generated"
    And I should find file at "ruby-warrior"

  Scenario: Another new profile
    Given a profile named "Joe"
    When I run rubywarrior
    And I choose "New" for "profile"
    And I choose "intermediate" for "tower"
    And I answer "Bob" to "name"
    Then I should see "generated"
    When I run rubywarrior
    Then I should see "Bob - intermediate - level 1 - score 0"
