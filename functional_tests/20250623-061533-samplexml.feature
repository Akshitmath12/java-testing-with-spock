Feature: Roostgpt Change for Upload Jira Ticket as PDF for Functional Test

Scenario: Upload a valid PDF file
  Given the API base URL 'http://localhost:3000/upload'
  And a valid PDF file "jira.pdf" with title, description, and comments is available
  When I send a POST request to '/upload' with the file as payload
  Then the response status should be 200
  And the response body should confirm "PDF successfully uploaded and processed"
  And the extracted title, description, and comments should match the content of the PDF

Scenario: Upload a large, valid PDF file
  Given the API base URL 'http://localhost:3000/upload'
  And a large PDF file "large_jira.pdf" with valid structure is available
  When I send a POST request to '/upload' with the file as payload
  Then the response status should be 200
  And the response body should confirm "PDF successfully uploaded and processed"
  And all comments, including lengthy ones, should be extracted accurately

Scenario: Handle special characters in PDF content
  Given the API base URL 'http://localhost:3000/upload'
  And a PDF file "special_characters_jira.pdf" with special characters in the title and description is available
  When I send a POST request to '/upload' with the file as payload
  Then the response status should be 200
  And the response body should confirm "PDF successfully uploaded and processed"
  And the extracted title and description should include the special characters without errors

Scenario: Provide an option to upload PDF instead of linking from Jira/Azure
  Given the API base URL 'http://localhost:3000/upload'
  When I check for available upload options
  Then the "Upload PDF" option should be visible
  And I choose the "Upload PDF" option
  And I upload a valid Jira ticket PDF
  Then the response status should be 200
  And linking options to Jira/Azure DevOps should remain unaffected

Scenario: Attempt to upload without selecting a file
  Given the API base URL 'http://localhost:3000/upload'
  When I choose the "Upload PDF" option but do not provide a file
  And I send a POST request to '/upload'
  Then the response status should be 400
  And the response body should contain an error message "No file uploaded. Please select a PDF."

Scenario: Validate unsupported file types
  Given the API base URL 'http://localhost:3000/upload'
  And an unsupported file "jira.docx" is available
  When I send a POST request to '/upload' with the file as payload
  Then the response status should be 415
  And the response body should contain an error message "Only PDF files are accepted for upload"

Scenario: Handle invalid PDF with correct extension
  Given the API base URL 'http://localhost:3000/upload'
  And a file "invalid.pdf" with incorrect content is available
  When I send a POST request to '/upload' with the file as payload
  Then the response status should be 422
  And the response body should contain an error message "Uploaded file is not a valid PDF"

Scenario: Store file metadata in Roost-reg module
  Given the API base URL 'http://localhost:3000/upload'
  And a valid Jira ticket PDF "jira.pdf" is uploaded
  When I verify the database for stored file metadata
  Then the file path, file name, and prompt type should be saved successfully
  And a confirmation should be returned with status 200

Scenario: AI server fetching content from Roost-reg
  Given the API base URL 'http://localhost:3000/fetch'
  And file metadata such as file path, name, and prompt type exists in the database
  When the AI server sends a GET request to '/fetch/metadata'
  Then the response status should be 200
  And the metadata should be sent as an array of objects
  And the AI server processes the objects without errors

Scenario: Regex-based data extraction for valid PDFs
  Given the API base URL 'http://localhost:3000/upload'
  And a PDF file "jira.pdf" with standard Jira structure is uploaded
  When I fetch the extracted content
  Then the response status should be 200
  And the title, description, and comments should match the PDF content

Scenario: Handle PDFs with empty fields
  Given the API base URL 'http://localhost:3000/upload'
  And a PDF file "empty_description.pdf" with empty description or comments field is available
  When I upload the file
  Then the response status should be 200
  And the extracted description or comments should return an empty value
  And the system should not crash

Scenario: Parse non-standard PDF structures
  Given the API base URL 'http://localhost:3000/upload'
  And a PDF file "non_standard_structure.pdf" with unexpected format is available
  When I upload the file
  Then the response status should be 422
  And the response body should provide an error message "Unable to parse PDF structure"

Scenario: Performance of uploading large files
  Given the API base URL 'http://localhost:3000/upload'
  And a large PDF file "bigfile.pdf" (50 MB) is available
  When I send a POST request to '/upload' with the file as payload
  Then the system should process the file within 5 seconds
  And the response status should be 200

Scenario: Server concurrency for multiple files
  Given the API base URL 'http://localhost:3000/upload'
  And 50 valid Jira ticket PDF files are available for upload
  When I send POST requests concurrently to upload all files
  Then the server should successfully process all files without degradation
  And no crashes should occur

Scenario: Security validation for malicious files
  Given the API base URL 'http://localhost:3000/upload'
  And a malicious PDF file "malware.pdf" is available
  When I send a POST request to '/upload' with the file as payload
  Then the response status should be 403
  And the response body should contain an error message "Uploaded file contains security risks. Upload denied."
