Feature: Testing API for RoostGPT Jira Ticket Upload as PDF

  Scenario: Validate upload of a supported file type (PDF)
    Given the API endpoint "POST /upload-pdf"
    And a valid PDF file named "jira_ticket.pdf" with typical Jira ticket details
    When I send a POST request with the file attached
    Then the response status should be 200
    And the response should contain "File uploaded successfully"
    And the response body should include the file type as "PDF"

  Scenario: Reject upload of unsupported file types
    Given the API endpoint "POST /upload-pdf"
    And an unsupported file type ".docx" named "sample.docx"
    When I send a POST request with the file attached
    Then the response status should be 400
    And the response should contain "Unsupported file type. Only PDF files are currently allowed."

  Scenario: Reject upload of a file exceeding the size limit
    Given the API endpoint "POST /upload-pdf"
    And a PDF file named "large_file.pdf" with a size of 15MB
    When I send a POST request with the file attached
    Then the response status should be 400
    And the response should contain "File size exceeds the maximum limit of 10MB."

  Scenario: Reject upload of empty files
    Given the API endpoint "POST /upload-pdf"
    And an empty PDF file named "empty_file.pdf" with 0 bytes
    When I send a POST request with the file attached
    Then the response status should be 400
    And the response should contain "Uploaded file cannot be empty."

  Scenario: Store file details in "roost-reg"
    Given the API endpoint "POST /upload-pdf"
    And a valid PDF file named "jira_ticket.pdf"
    When I send a POST request with the file attached
    Then the response status should be 200
    And the file path, file name, and prompt type should be saved in "roost-reg"

  Scenario: Transmit file data to AI Server
    Given the AI Server API endpoint "POST /process-file"
    And a valid PDF file named "jira_ticket.pdf"
    When I submit a request with the file's data (content, name, prompt type)
    Then the response status should be 200
    And the AI server should process the file successfully without errors

  Scenario: Parse Jira ticket details from the PDF
    Given the API endpoint "POST /parse-pdf"
    And a valid PDF file named "jira_ticket.pdf"
    When I send a request with the file data
    Then the response status should be 200
    And the response body should include the parsed details:
      | Title       | Description                                      | Comments                                             |
      | ZBIO-6159   | Jira ticket upload as PDF for functional testing | Flow involves approostio -> roost-reg -> ai server |

  Scenario: Handle concurrent uploads of multiple files
    Given the API endpoint "POST /upload-pdf"
    And 50 valid PDF files uploaded concurrently by different users
    When I monitor the system performance during the uploads
    Then all files should be processed successfully without crashing
    And the response status for each upload should be 200
    And data integrity of uploaded files should be maintained

  Scenario: Handle complex PDF structure for parsing
    Given the API endpoint "POST /parse-pdf"
    And a complex PDF file with multiple nested comments and irregular formatting
    When I send the file for parsing
    Then the response status should be 200
    And the API should parse the title, description, and comments with at least 95% accuracy

  Scenario: Prevent unauthorized access to "roost-reg"
    Given the "roost-reg" API endpoint is protected
    When an unauthorized user attempts to access stored file paths
    Then the response status should be 403
    And the response should contain "Access denied"
    And the unauthorized activity should be logged

  Scenario: Validate performance for bulk file uploads
    Given the API endpoint "POST /upload-pdf"
    And 100 valid PDF files
    When the files are uploaded sequentially
    Then the system should process all files within acceptable time limits (<1 second per file)
    And the response status for each upload should be 200

  Scenario: Validate new functional test upload option for usability
    Given the UI allows users to upload a PDF file
    And the UI provides an option to upload PDF instead of linking Jira or Azure DevOps
    When I test the upload functionality
    Then the option should be visible
    And users should be able to upload successfully
    And the new option should not interfere with existing workflows
