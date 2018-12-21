Feature: Test User API

  Background: 
    * url 'http://localhost:8080'

  Scenario: Get all predefined users
    Given path '/users'
    When method GET
    Then status 200
    And assert response.length != 0
    And match response contains { id: #notnull, nickName: #notnull }
    And match response[0].nickName == 'ankamma'

  Scenario: Manage new user
    Given path '/users'
    And request { nickName: 'ankamma' }
    When method post
    Then status 201
    And match response == {id:'#number', nickName: 'ankamma'}
    
     * def id = response.id
    Given path '/users', id
    When method get
    Then status 200
    And match response == {id: '#(id)', nickName: 'ankamma'}
    
    Given path '/users'
    When method GET
    Then status 200
    And assert response.length != 0
    And match $ contains {id: '#(id)', nickName: 'ankamma'}
    
    Given path '/users'
    When method GET
    Then status 200
    And match $ contains {id: '#(id)', nickName: 'ankamma'}
    
   Given path '/users', id
    When method delete
    Then status 204
    
    
