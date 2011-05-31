@copywritings
Feature: Copywritings
  In order to have copywritings on my website
  As an administrator
  I want to manage copywritings

  Background:
    Given I am a logged in refinery user
    And I have no copywritings

  @copywritings-list @list
  Scenario: Copywritings List
   Given I have copywritings titled slogan, subtitle
   When I go to the list of copywritings
   Then I should see "slogan"
   And I should see "subtitle"

  @copywritings-edit @edit
  Scenario: Edit Existing Copywriting
    Given I have copywritings titled "slogan"
    When I go to the list of copywritings
    And I follow "Edit this copywriting" within ".actions"
    Then I fill in "value" with "A different slogan"
    And I press "Save"
    Then I should see "'slogan' was successfully updated."
    And I should be on the list of copywritings
    And I should see "A different slogan"

  @copywritings-delete @delete
  Scenario: Delete Copywriting
    Given I only have copywritings titled slogan
    When I go to the list of copywritings
    And I follow "Remove this phrase"
    Then I should see "'slogan' was successfully removed."
    And I should have 0 copywritings
 