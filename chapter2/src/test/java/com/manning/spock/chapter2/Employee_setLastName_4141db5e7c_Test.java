// Test generated by RoostGPT for test SpockTest using AI Type Open AI and AI Model gpt-4

package com.manning.spock.chapter2;

import org.junit.Test;
import static org.junit.Assert.*;

public class Employee_setLastName_4141db5e7c_Test {

    @Test
    public void testSetLastNameSuccess() {
        Employee employee = new Employee();
        employee.setLastName("Smith");
        assertEquals("Smith", employee.getLastName());
    }

    @Test
    public void testSetLastNameNull() {
        Employee employee = new Employee();
        employee.setLastName(null);
        assertNull(employee.getLastName());
    }
}
