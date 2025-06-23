Feature: Add "claude-3-7-sonnet" Anthropic Model in Google Vertex AI

  Background:
    Given the API base URL 'https://vertex.googleapis.com'

  # Functional Test Scenarios

  Scenario: Verify dropdown contains the new "claude-3-7-sonnet" model
    Given I navigate to the Google Vertex AI interface to access the model dropdown
    When the dropdown is displayed
    Then the dropdown should contain "claude-3-7-sonnet" as an available option
    And the option should be selectable
    And the option should remain visible even when there are more than 50 items

  Scenario: Validate selection of "claude-3-7-sonnet" in the dropdown
    Given the dropdown is loaded
    When I select "claude-3-7-sonnet"
    Then the selection should be processed correctly
    And the system should display a confirmation of the selection without errors

  Scenario: Ensure proper model validation for "claude-3-7-sonnet"
    Given "claude-3-7-sonnet" is selected as the model
    When I initiate a request to the API with the selected model
    Then the request should pass all internal validations
    And the response should confirm model validation success

  Scenario: API response with 200 OK for valid requests
    Given "claude-3-7-sonnet" is selected and a valid API request is prepared
    When I send a POST request to '/v1/models/claude-3-7-sonnet:predict' with valid payload
    Then the response status should be 200
    And the response body should contain a valid JSON confirming model execution details

  Scenario: API response with 429 Too Many Requests error
    Given I simulate more than 20 API requests per minute to the endpoint '/v1/models/claude-3-7-sonnet:predict'
    When I send additional requests
    Then the response status should be 429
    And the response body should contain:
      """
      {
          "error": {
              "code": 429,
              "message": "Resource exhausted. Please try again later. Please refer to https://cloud.google.com/vertex-ai/generative-ai/docs/error-code-429 for more details.",
              "status": "RESOURCE_EXHAUSTED"
          }
      }
      """

  Scenario: Validate retry mechanism after 429 error
    Given I receive a 429 error due to rate-limiting
    When I retry the API request after the cooldown period
    Then the response status should be 200
    And the API should return a valid response

  Scenario: Handle invalid input for the model API
    Given I send a payload with "invalid-model-name" instead of "claude-3-7-sonnet"
    When I make a POST request to '/v1/models/invalid-model-name:predict'
    Then the response status should be 400
    And the response body should contain a descriptive error message indicating an invalid model name

  # Non-Functional Test Scenarios

  Scenario: Performance testing of the dropdown rendering
    Given the dropdown has more than 100 items, including "claude-3-7-sonnet"
    When I load the page
    Then the dropdown should render within 2 seconds
    And the performance should not degrade

  Scenario: API rate-limiting behavior under load
    Given the API endpoint '/v1/models/claude-3-7-sonnet:predict'
    When I simulate 50+ API requests per second
    Then the system should correctly enforce rate-limiting
    And the response for excess requests should contain a 429 status

  Scenario: Availability and reliability of the service
    Given I am making API requests during peak usage times
    When I send requests to '/v1/models/claude-3-7-sonnet:predict'
    Then the service should maintain >99% availability
    And the error rate should remain <1%

  Scenario: Scalability testing for "claude-3-7-sonnet"
    Given I gradually increase the API load up to 10,000 requests/hour
    When I monitor the system's response
    Then the service should scale seamlessly
    And the response time and accuracy should not degrade

  Scenario: Ensuring error message clarity
    Given I simulate various errors like 429 and 400 for the API
    When I receive error responses
    Then the error messages should provide clear, user-friendly descriptions
    And they should include actionable steps or documentation references

  Scenario: Browser compatibility for dropdown and selection
    Given I use various browsers including Chrome, Firefox, Edge, and Safari
    When I interact with the dropdown and select "claude-3-7-sonnet"
    Then the selection and any subsequent API request should work seamlessly across all supported browsers

  Scenario: Stress test retry mechanism
    Given multiple clients receive 429 errors due to rate-limiting
    When they retry API requests simultaneously after the cooldown period
    Then the retry mechanism should handle the load without crashing
    And the responses should be processed correctly
