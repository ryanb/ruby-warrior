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
    And I wait 1 second
    And I answer "Joe" to "name"
    Then I should see "generated"
    And I should find file at "ruby-warrior"
