Feature: Testing RoostGPT - Upload Jira Ticket as PDF for Functional and Non-Functional Testing

### Functional Test Cases

Scenario: Verify Uploading a PDF File
  Given the API base URL "http://localhost:3000/approostio"
  And the valid PDF file "jira_ticket.pdf" is ready for upload
  When I send a POST request to "/upload" with the file in the request payload
  Then the response status should be 200
  And the response should contain a confirmation of successful upload
  And the file metadata including file name, content, and prompt type should be sent as an array of objects to "roost-reg"
  And the file path should be stored in "roost-reg"
  And the file name and content should be sent to the AI server for processing

Scenario: Validate Supported Document Types
  Given the API base URL "http://localhost:3000/approostio"
  And I have files with formats ".pdf", ".docx", ".jpg"
  When I send a POST request to "/upload" with each file in the request payload
  Then the response status should be 400 for unsupported formats
  And the response should say "Only PDF files are supported"
  And the response should be 200 for valid ".pdf" files
  But for empty or invalid file uploads, the response should say "File is required" or "Invalid file"

Scenario: Verify Handling of Large PDF Files
  Given the API base URL "http://localhost:3000/approostio"
  And I have a large PDF file of size 20 MB
  When I send a POST request to "/upload" with the file in the request payload
  Then the response status should be 200 if within the supported size limit
  And If the file size exceeds the limit, the response should be 400 with the message "File size exceeds the maximum limit"

Scenario: Verify Regex-Based Information Extraction from PDF
  Given the API base URL "http://localhost:3000/roost-reg"
  And I upload a Jira ticket PDF with title, description, and comments
  When the file is sent for processing
  Then Regex should correctly extract the title, description, and comments
  And extracted information should be sent to the AI server in the required format
  And for non-standard content, the extraction should gracefully fail with appropriate logging

Scenario: Verify Integration Between Modules
  Given the API base URL "http://localhost:3000/approostio"
  And the valid PDF file "jira_ticket.pdf" is uploaded
  When the file metadata is sent to "roost-reg"
  Then ownership of data should transition from "approostio" -> "roost-reg" -> "aiServer" -> "NodeJS"
  And the AI server must receive correct file content, file name, and extracted metadata
  And the string of file paths at the AI server should match the uploaded files

Scenario: Validate Error Handling on Malformed PDF
  Given the API base URL "http://localhost:3000/approostio"
  And I upload a corrupt PDF file
  When the file fails processing
  Then the system should display "Error reading the PDF file" and log the error
  And the AI server should not receive incomplete or corrupt data

Scenario: Verify Duplicate File Upload
  Given the API base URL "http://localhost:3000/approostio"
  And I upload the same PDF file multiple times
  When the system detects duplicates
  Then file names must be appended with unique identifiers (e.g., "jira_ticket_1.pdf", "jira_ticket_2.pdf")
  And If duplication is not allowed, it should display a warning like "File already uploaded"

### Non-Functional Test Cases

Scenario: Validate Performance of File Upload
  Given the API base URL "http://localhost:3000/approostio"
  And I upload PDF files of different sizes (e.g., 1 MB, 5 MB, 10 MB)
  When I measure file upload times
  Then files should upload within 5 seconds for sizes up to 10 MB
  And larger files should not impact system stability

Scenario: Verify System Response During High Load
  Given the API base URL "http://localhost:3000/approostio"
  And I simultaneously upload 50 PDF files across multiple user sessions
  When the server processes the uploads
  Then the system should handle concurrent uploads without crashing or degrading performance

Scenario: Verify Security of Uploaded Files
  Given the API base URL "http://localhost:3000/approostio"
  And I upload a PDF containing sensitive information
  When the file is transmitted and stored
  Then all files must be securely transmitted via HTTPS
  And file paths and contents must be securely stored at each stage

Scenario: Validate Failure Recovery
  Given the API base URL "http://localhost:3000/approostio"
  And I simulate server-side failure during file upload
  When the upload process fails
  Then the system retries or displays "Upload failed. Please try again"
  And partial uploads should be cleaned up

Scenario: Measure AI Server Processing Time
  Given the API base URL "http://localhost:3000/aiServer"
  And I upload a parsed PDF file for processing
  When the AI server processes the file
  Then the processing time should not exceed 3 seconds

Scenario: Validate Regex Efficiency
  Given the API base URL "http://localhost:3000/aiServer"
  And I upload a PDF with 500+ lines of text for regex extraction
  When the system performs information extraction
  Then the extraction should complete within 2 seconds without CPU-intensive operations

Scenario: Verify Cross-Browser Compatibility
  Given the "approostio" application URL "http://localhost:3000"
  And popular browsers (Chrome, Firefox, Safari, Edge) are tested
  When I use the PDF upload feature
  Then the functionality must work consistently across all browsers without UI/UX discrepancies

Scenario: Validate File Deletion Policy
  Given the API base URL "http://localhost:3000/roost-reg"
  And I upload files for processing
  When the processing is complete
  Then temporary files stored in "roost-reg" must be deleted
  And there should be no leftover files after processing
