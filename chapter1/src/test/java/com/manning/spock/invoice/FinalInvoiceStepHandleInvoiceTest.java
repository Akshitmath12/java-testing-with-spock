// ********RoostGPT********
/*
Test generated by RoostGPT for test h-11 using AI Type DBRX and AI Model meta-llama-3-70b-instruct-041824
ROOST_METHOD_HASH=handleInvoice_c7285f79ec
ROOST_METHOD_SIG_HASH=handleInvoice_1e6ff8ac50
Here are the generated test scenarios for the `handleInvoice` method:
**Scenario 1: Invoice sent via email when customer email is not empty**
Details:
TestName: invoiceSentViaEmailWhenCustomerEmailIsNotEmpty
Description: Verify that the `emailService` sends the invoice when the customer's email is not empty.
Execution:
Arrange: Set up a valid `Invoice` object and a `Customer` object with a non-empty email.
Act: Invoke the `handleInvoice` method with the `Invoice` and `Customer` objects.
Assert: Verify that the `emailService.sendInvoice` method is called with the correct parameters.
Validation:
The assertion verifies that the invoice is sent via email when the customer's email is not empty. This test ensures that the method correctly handles the email sending logic.
**Scenario 2: Invoice printed when customer email is empty**
Details:
TestName: invoicePrintedWhenCustomerEmailIsEmpty
Description: Verify that the `printerService` prints the invoice when the customer's email is empty.
Execution:
Arrange: Set up a valid `Invoice` object and a `Customer` object with an empty email.
Act: Invoke the `handleInvoice` method with the `Invoice` and `Customer` objects.
Assert: Verify that the `printerService.printInvoice` method is called with the correct parameter.
Validation:
The assertion verifies that the invoice is printed when the customer's email is empty. This test ensures that the method correctly handles the printing logic.
**Scenario 3: NullPointerException thrown when invoice is null**
Details:
TestName: nullPointerExceptionThrownWhenInvoiceIsNull
Description: Verify that a `NullPointerException` is thrown when the `Invoice` object is null.
Execution:
Arrange: Set up a null `Invoice` object and a valid `Customer` object.
Act: Invoke the `handleInvoice` method with the null `Invoice` and valid `Customer` objects.
Assert: Verify that a `NullPointerException` is thrown.
Validation:
The assertion verifies that the method throws a `NullPointerException` when the `Invoice` object is null. This test ensures that the method correctly handles invalid input.
**Scenario 4: NullPointerException thrown when customer is null**
Details:
TestName: nullPointerExceptionThrownWhenCustomerIsNull
Description: Verify that a `NullPointerException` is thrown when the `Customer` object is null.
Execution:
Arrange: Set up a valid `Invoice` object and a null `Customer` object.
Act: Invoke the `handleInvoice` method with the valid `Invoice` and null `Customer` objects.
Assert: Verify that a `NullPointerException` is thrown.
Validation:
The assertion verifies that the method throws a `NullPointerException` when the `Customer` object is null. This test ensures that the method correctly handles invalid input.
**Scenario 5: EmailService exception is thrown when email sending fails**
Details:
TestName: emailServiceExceptionThrownWhenEmailSendingFails
Description: Verify that an `EmailServiceException` is thrown when the email sending process fails.
Execution:
Arrange: Set up a valid `Invoice` object, a `Customer` object with a non-empty email, and a mock `EmailService` object that throws an `EmailServiceException`.
Act: Invoke the `handleInvoice` method with the `Invoice` and `Customer` objects.
Assert: Verify that an `EmailServiceException` is thrown.
Validation:
The assertion verifies that the method correctly handles email sending failures. This test ensures that the method propagates the exception to the caller.
**Scenario 6: PrinterService exception is thrown when printing fails**
Details:
TestName: printerServiceExceptionThrownWhenPrintingFails
Description: Verify that a `PrinterServiceException` is thrown when the printing process fails.
Execution:
Arrange: Set up a valid `Invoice` object, a `Customer` object with an empty email, and a mock `PrinterService` object that throws a `PrinterServiceException`.
Act: Invoke the `handleInvoice` method with the `Invoice` and `Customer` objects.
Assert: Verify that a `PrinterServiceException` is thrown.
Validation:
The assertion verifies that the method correctly handles printing failures. This test ensures that the method propagates the exception to the caller.
*/
// ********RoostGPT********
package com.manning.spock.invoice;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import org.junit.jupiter.api.*;

@Tag("com.manning.spock.invoice")
@Tag("com.manning.spock.invoice.handleInvoice")
@Tag("com.manning.spock.invoice.getEmail")
@Tag("com.manning.spock.invoice.printInvoice")
@Tag("com.manning.spock.invoice.sendInvoice")
@ExtendWith(MockitoExtension.class)
class FinalInvoiceStepTest {

	@Mock
	private PrinterService printerService;

	@Mock
	private EmailService emailService;

	@InjectMocks
	private FinalInvoiceStep finalInvoiceStep;

	@Test
	void invoiceSentViaEmailWhenCustomerEmailIsNotEmpty() {
		// Arrange
		Invoice invoice = new Invoice("Test Invoice");
		Customer customer = new Customer();
		customer.hasEmail("test@example.com");
		String email = customer.getEmail();
		// Act
		finalInvoiceStep.handleInvoice(invoice, customer);
		// Assert
		verify(emailService).sendInvoice(invoice, email);
	}

	@Test
	void invoicePrintedWhenCustomerEmailIsEmpty() {
		// Arrange
		Invoice invoice = new Invoice("Test Invoice");
		Customer customer = new Customer();
		// Act
		finalInvoiceStep.handleInvoice(invoice, customer);
		// Assert
		verify(printerService).printInvoice(invoice);
	}

	@Test
	void nullPointerExceptionThrownWhenInvoiceIsNull() {
		// Arrange
		Customer customer = new Customer();
		// Act and Assert
		NullPointerException exception = assertThrows(NullPointerException.class,
				() -> finalInvoiceStep.handleInvoice(null, customer));
	}

	@Test
	void nullPointerExceptionThrownWhenCustomerIsNull() {
		// Arrange
		Invoice invoice = new Invoice("Test Invoice");
		// Act and Assert
		NullPointerException exception = assertThrows(NullPointerException.class,
				() -> finalInvoiceStep.handleInvoice(invoice, null));
	}

	@Test
	void emailServiceExceptionThrownWhenEmailSendingFails() {
		// Arrange
		Invoice invoice = new Invoice("Test Invoice");
		Customer customer = new Customer();
		customer.hasEmail("test@example.com");
		when(emailService.sendInvoice(invoice, customer.getEmail()))
			.thenThrow(new EmailServiceException("Email sending failed"));
		// Act and Assert
		EmailServiceException exception = assertThrows(EmailServiceException.class,
				() -> finalInvoiceStep.handleInvoice(invoice, customer));
	}

	@Test
	void printerServiceExceptionThrownWhenPrintingFails() {
		// Arrange
		Invoice invoice = new Invoice("Test Invoice");
		Customer customer = new Customer();
		when(printerService.printInvoice(invoice)).thenThrow(new PrinterServiceException("Printing failed"));
		// Act and Assert
		PrinterServiceException exception = assertThrows(PrinterServiceException.class,
				() -> finalInvoiceStep.handleInvoice(invoice, customer));
	}

}