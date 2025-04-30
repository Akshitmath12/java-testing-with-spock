Feature: Testing Environment Variables Handling API

  Scenario: Verify Default State
  Given the API base URL 'http://localhost:3000'
  When I send a GET request to '/envVar/VERIFY_TEST'
  Then the response status should be 200
  And the response body should contain 'VERIFY_TEST' as false

  Scenario: Verify Manual Change
  Given the API base URL 'http://localhost:3000'
  When I send a PUT request to '/envVar/VERIFY_TEST' with body content '{"value":"true"}'
  Then the response status should be 200
  And the response body should contain 'VERIFY_TEST' updated value as true

  Scenario: Verify No Variable Duplication
  Given the API base URL 'http://localhost:3000'
  When I send a POST request to '/envVar' with body content '{"name":"VERIFY_TEST"}'
  Then the response status should be 400
  And the response body should contain 'Error: Duplicate variable'

  Scenario: Verify Variable Append
  Given the API base URL 'http://localhost:3000'
  When I send a PUT request to '/envVar/VERIFY_TEST' with body content '{"value":"true"}'
  Then the response status should be 200
  And the response body should contain 'VERIFY_TEST' updated value as true

  Scenario: Verify Removal
  Given the API base URL 'http://localhost:3000'
  When I send a DELETE request to '/envVar/VERIFY_TEST'
  Then the response status should be 200
  And the response should contain 'VERIFY_TEST successfully removed'

  Scenario: Error Handling
  Given the API base URL 'http://localhost:3000
  When I send a PUT request to '/envVar/VERIFY_TEST' with invalid body content '{"value":"notaboolean"}'
  Then the response should have a status of 400
  And the response body should contain 'Error: Invalid value'

  Scenario: Performance Test
  Given the API base URL 'http://localhost:3000
  When I send a PUT request rapidly to '/envVar/VERIFY_TEST' with random boolean values
  Then the response status each time should be 200
  And the changes should be reflected with respective values each time in response.

  Scenario: Security Test
  Given the API base URL 'http://localhost:3000
  When an unauthorized attempt to PUT request is made to '/envVar/VERIFY_TEST'
  Then the response status should be 401
  And the response should contain 'Unauthorized'

  Scenario: Usability Test
  Given the API base URL 'http://localhost:3000
  When I send a GET request to '/envVar'
  Then the response status should be 200
  And the response body should be easy to understand and navigate

  Scenario: Compatibility Test
  Given the application on different browsers or devices
  When I send GET, PUT, POST and DELETE requests to '/envVar/VERIFY_TEST'
  Then the response and action should be consistent regardless of the device or browser used.

  Scenario: Case with Empty Input
  Given the API base URL 'http://localhost:3000
  When I send a PUT request to '/envVar/VERIFY_TEST' with invalid body content '{"value":""}' or '{"value":" "}'
  Then the response should have a status of 400
  And the response body should contain 'Error: Empty or whitespace-only value not allowed'
