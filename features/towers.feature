Feature: Manage towers
  In order extend ruby warrior
  As a developer
  I want to manage towers
  
  Background:
    Given no profile at "tmp"
  
  Scenario: Add a tower
    When I copy fixture "short-tower" to "towers/short"
    And I run rubywarrior
    And I answer "y" to "create one?"
    Then I should see "short"
  
