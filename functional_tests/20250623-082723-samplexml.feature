Feature: Testing API interactions for ticket ZBIO-11111  

  Scenario: Successful execution of primary functionality with a GET request  
    Given the API base URL 'http://api.example.com'  
    When I send a GET request to '/primary-functionality?input=value'  
    Then the response status should be 200  
    And the response body should contain the field 'executionStatus' with value 'success'  
    And the response should include 'outputData' matching the input requirements  

  Scenario: Testing invalid input with a GET request  
    Given the API base URL 'http://api.example.com'  
    When I send a GET request to '/primary-functionality?input=invalidValue'  
    Then the response status should be 400  
    And the response body should contain the field 'errorMessage' with value 'Invalid input'  

  Scenario: Validating edge cases for boundary inputs using a GET request  
    Given the API base URL 'http://api.example.com'  
    When I send a GET request to '/primary-functionality?input=minBoundary'  
    Then the response status should be 200  
    And the response body should contain 'outputData' with value 'minimumOutput'  
    When I send a GET request to '/primary-functionality?input=maxBoundary'  
    Then the response status should be 200  
    And the response body should contain 'outputData' with value 'maximumOutput'  

  Scenario: Successful execution of a POST request with valid payload  
    Given the API base URL 'http://api.example.com'  
    And the JSON payload is '{ "name": "test", "value": 123 }'  
    When I send a POST request to '/create-functionality' with the payload  
    Then the response status should be 201  
    And the response body should include 'creationStatus' with value 'created'  
    And the response should include a field 'resourceId' with a non-empty value  

  Scenario: Testing failure for a POST request with invalid payload  
    Given the API base URL 'http://api.example.com'  
    And the JSON payload is '{ "name": "", "value": -1 }'  
    When I send a POST request to '/create-functionality' with the payload  
    Then the response status should be 400  
    And the response body should include 'errorMessage' with value 'Invalid data provided'  

  Scenario: Updating resource successfully using a PUT request  
    Given the API base URL 'http://api.example.com'  
    And the JSON payload is '{ "name": "updatedName", "value": 456 }'  
    When I send a PUT request to '/update-functionality/123' with the payload  
    Then the response status should be 200  
    And the response body should include 'updateStatus' with value 'successful'  

  Scenario: Testing resource update failure due to invalid resource ID for PUT  
    Given the API base URL 'http://api.example.com'  
    And the JSON payload is '{ "name": "updatedName", "value": 456 }'  
    When I send a PUT request to '/update-functionality/invalidId' with the payload  
    Then the response status should be 404  
    And the response body should include 'errorMessage' with value 'Resource not found'  

  Scenario: Deleting a resource successfully using DELETE request  
    Given the API base URL 'http://api.example.com'  
    When I send a DELETE request to '/delete-functionality/123'  
    Then the response status should be 204  
    And the response body should be empty  

  Scenario: Deleting non-existing resource using DELETE request  
    Given the API base URL 'http://api.example.com'  
    When I send a DELETE request to '/delete-functionality/nonexistentId'  
    Then the response status should be 404  
    And the response body should include 'errorMessage' with value 'Resource not found'  

  Scenario: Validating API response time for GET requests  
    Given the API base URL 'http://api.example.com'  
    When I send a GET request to '/primary-functionality?input=value'  
    Then the response status should be 200  
    And the response time should be less than 500 milliseconds  

  Scenario: Verifying API handles unauthorized access gracefully  
    Given the API base URL 'http://api.example.com'  
    When I send a GET request to '/secure-functionality' without authorization headers  
    Then the response status should be 401  
    And the response body should include 'errorMessage' with value 'Authorization failed'  

  Scenario: Testing server error scenario  
    Given the API base URL 'http://api.example.com'  
    When I send a GET request to '/primary-functionality?input=triggerServerError'  
    Then the response status should be 500  
    And the response body should include 'errorMessage' with value 'Internal Server Error'  
