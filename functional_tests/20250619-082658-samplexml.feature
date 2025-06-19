Feature: Testing API for ZBIO-6159 RoostGPT Upload of Jira Ticket as PDF

Scenario: Upload a valid PDF file through approostio
  Given the API base URL 'http://approostio.example.com/api/v1'
  And a valid request payload as an array of objects with "fileName", "content", and "promptType"
  When I send a POST request to '/upload-pdf'
  Then the response status should be 200
  And the response body should confirm the successful upload of the file
  And the system should store "fileName" and "promptType" in roost-reg

Scenario: Reject non-PDF file upload
  Given the API base URL 'http://approostio.example.com/api/v1'
  And an invalid request payload containing a '.docx' or '.xls' file
  When I send a POST request to '/upload-pdf'
  Then the response status should be 400
  And the response body should contain an error message: "Invalid file type. Only PDF files are allowed."

Scenario: Store file details in roost-reg database
  Given the roost-reg API is available at 'http://roost-reg.example.com/api/v1'
  And a valid "jira.pdf" file with "fileName" and "promptType"
  When I send a POST request to '/store-details'
  Then the response status should be 200
  And the response body should confirm the storage of file path, "fileName", and "promptType"

Scenario: Handle duplicate file names in roost-reg
  Given the roost-reg API is available at 'http://roost-reg.example.com/api/v1'
  And a file with duplicate "fileName"
  When I send a POST request to '/store-details'
  Then the response status should be 409
  And the response body should contain an error message: "Duplicate file name detected. File rename or rejection requires user action."

Scenario: Forward file to AI server
  Given the AI server API is available at 'http://ai-server.example.com/api/v1'
  And retrieved "fileContent" and "fileName" from roost-reg
  When I send a POST request to '/process-file'
  Then the response status should be 200
  And the AI server should receive the file content as a string of file paths

Scenario: Reject incomplete or corrupt PDF file
  Given the AI server API is available at 'http://ai-server.example.com/api/v1'
  And the file being uploaded is incomplete or corrupt
  When I send a POST request to '/process-file'
  Then the response status should be 422
  And the response body should contain an error message: "File processing failed due to corrupt or incomplete data."

Scenario: Parse PDF using regex in AI server
  Given the AI server API is available at 'http://ai-server.example.com/api/v1'
  And a valid request payload contains structured data in the PDF
  When I send a POST request to '/parse-pdf'
  Then the response status should be 200
  And the response body should include extracted "Description", "Title", and "Comments"

Scenario: Fail parsing due to blank PDF file
  Given the AI server API is available at 'http://ai-server.example.com/api/v1'
  And the input is a blank PDF file
  When I send a POST request to '/parse-pdf'
  Then the response status should be 400
  And the response body should contain an error message: "Parsing failed. No content found in the file."

Scenario: Handle non-standard text patterns during parsing
  Given the AI server API is available at 'http://ai-server.example.com/api/v1'
  And the input contains non-standard patterns in text
  When I send a POST request to '/parse-pdf'
  Then the response status should be 422
  And the response body should contain an error message: "Parsing failed due to unsupported text structure."

Scenario: AI processing of parsed content
  Given the AI server API is available at 'http://ai-server.example.com/api/v1'
  And the parsed data includes "Description", "Title", and "Comments"
  When I send a POST request to '/process-parsed-data'
  Then the response status should be 200
  And the parsed content should be correctly processed

Scenario: Handle edge case descriptions during AI processing
  Given the AI server API is available at 'http://ai-server.example.com/api/v1'
  And the input contains edge case descriptions like empty titles or malformed data
  When I send a POST request to '/process-parsed-data'
  Then the response status should be 422
  And the response body should contain meaningful error messages for invalid data

Scenario: Validate end-to-end flow from approostio to Roost-reg to AI server
  Given the API base URL for approostio is 'http://approostio.example.com/api/v1'
  And a valid "jira.pdf" file as input
  When I upload the file to approostio
  And the file details are stored in roost-reg
  And the file content is forwarded to the AI server
  Then the response status for all steps should be 200
  And the file should flow through the system without interruptions
  And the system should log meaningful errors in case of failures

Scenario: Handle failure scenarios gracefully during end-to-end flow
  Given an API flow from approostio to AI server
  And a simulated system downtime or missing roost-reg file paths
  When an error occurs at any step
  Then the system should log the error with a descriptive message
  And retry or prompt the user for corrective action
