Feature: API Testing and Integration for "claude-3-7-sonnet" in Google Vertex AI

Scenario: Verify the addition of "claude-3-7-sonnet" model in the dropdown
  Given the API base URL 'https://vertex-ai.googleapis.com'
  When I send a GET request to '/models/list'
  Then the response status should be 200
  And the response body should contain the model name "claude-3-7-sonnet"
  And the response formatting and spelling should be correct in all supported locales

Scenario: Verify model selection functionality
  Given the API base URL 'https://vertex-ai.googleapis.com'
  When I send a POST request to '/models/select' with payload:
    """
    {
        "model": "claude-3-7-sonnet"
    }
    """
  Then the response status should be 200
  And the system should register "claude-3-7-sonnet" as the active model

Scenario: Validate that an unsupported model cannot be selected
  Given the API base URL 'https://vertex-ai.googleapis.com'
  When I send a POST request to '/models/select' with payload:
    """
    {
        "model": "unsupported-model-name"
    }
    """
  Then the response status should be 400
  And the response should contain:
    """
    {
        "error": {
            "code": 400,
            "message": "Model not found or unsupported."
        }
    }
    """

Scenario: Ensure successful response for a valid API request
  Given the API base URL 'https://vertex-ai.googleapis.com'
  When I send a GET request to '/models/status?model=claude-3-7-sonnet'
  Then the response status should be 200
  And the response should contain:
    """
    {
        "model": "claude-3-7-sonnet",
        "status": "available"
    }
    """

Scenario: Validate handling of "429 Too Many Requests" error
  Given the API base URL 'https://vertex-ai.googleapis.com'
  When I send multiple requests to '/models/status?model=claude-3-7-sonnet'
  And the system reaches the API rate limit
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
  And the system should display a user-friendly message: "Too many requests. Please retry later."

Scenario: Validate retry mechanism on receiving a 429 error
  Given the API base URL 'https://vertex-ai.googleapis.com'
  When a 429 error is received
  And I retry the request after a cooldown period
  Then the subsequent requests should successfully process with a 200 status

Scenario: Validate dropdown behavior when no models are available
  Given that the API returns an empty list for models
  When I send a GET request to '/models/list'
  Then the response status should be 200
  And the response body should contain:
    """
    {
        "models": []
    }
    """
  And the system should display a message: "No models available."

Scenario: Test response with corrupted model data
  Given the API base URL 'https://vertex-ai.googleapis.com'
  When I send a GET request to '/models/status?model=corrupted-model-name'
  Then the response status should be 500
  And the response should contain:
    """
    {
        "error": {
            "code": 500,
            "message": "Data inconsistency detected for model corrupted-model-name."
        }
    }
    """

Scenario: Measure system response time for model dropdown rendering
  Given the API returns a large list of models including "claude-3-7-sonnet"
  When I load the dropdown menu in the interface
  Then the dropdown should render in less than 2 seconds

Scenario: Test system behavior under high API traffic
  Given the API base URL 'https://vertex-ai.googleapis.com'
  When I simulate 1000+ concurrent POST requests to '/models/select'
  Then the system should handle the requests efficiently without crashing
  And the API response time should remain under 2 seconds for each request

Scenario: User interface clarity for selecting "claude-3-7-sonnet"
  Given the dropdown UI is loaded
  When I inspect its accessibility features
  Then the dropdown text should be readable
  And the dropdown should support keyboard navigation and screen readers

Scenario: Ensure stability of "claude-3-7-sonnet" selection under continuous usage
  Given the API base URL 'https://vertex-ai.googleapis.com'
  When I select and deselect "claude-3-7-sonnet" continuously for 5 minutes
  Then the system should reliably register each action without glitches

Scenario: Validate stability at peak resource usage
  Given the API is under maximum resource load
  When I select "claude-3-7-sonnet" from the dropdown
  Then the dropdown functionality should work seamlessly without errors
