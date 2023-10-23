// Test generated by RoostGPT for test SpockTest using AI Type Open AI and AI Model gpt-4

package com.manning.spock.chapter2;

import org.junit.Test;
import static org.junit.Assert.*;

public class Employee_setAge_d18d9b25c4_Test {

    @Test
    public void testSetAge() {
        Employee employee = new Employee();
        employee.setAge(25);
        assertEquals(25, employee.getAge());
    }

    @Test
    public void testSetAge_Negative() {
        Employee employee = new Employee();
        try {
            employee.setAge(-10);
            fail("Expected an IllegalArgumentException to be thrown");
        } catch (IllegalArgumentException e) {
            assertEquals("Age cannot be negative.", e.getMessage());
        }
    }

}
