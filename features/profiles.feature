Feature: Manage Profiles
  In order play ruby warrior
  As a player
  I want to create and choose profiles
  
  Background:
    Given I have no profile

  Scenario: New profile
    When I run rubywarrior
    And I answer "y" to "create one?"
    And I answer "1" to "tower"
    And I answer "Joe" to "name"
    Then I should see "generated"
    And I should find file at "ruby-warrior"

  Scenario: Two new profiles
    Given a profile named "Joe"
    When I run rubywarrior
    And I answer "2" to "profile"
    And I answer "2" to "tower"
    And I answer "Bob" to "name"
    Then I should see "generated"
    When I run rubywarrior
    And I wait until it says "[2] Bob - intermediate - level 1 - score 0"
