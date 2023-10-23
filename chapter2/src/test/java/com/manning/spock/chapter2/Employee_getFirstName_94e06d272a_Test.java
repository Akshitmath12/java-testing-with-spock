// Test generated by RoostGPT for test SpockTest using AI Type Open AI and AI Model gpt-4

package com.manning.spock.chapter2;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import spock.lang.Specification;

public class Employee_getFirstName_94e06d272a_Test extends Specification {

    private Employee employee;
    
    @Before
    public void setUp() {
        employee = new Employee();
    }

    @Test
    public void testGetFirstName_returnsCorrectFirstName() {
        String expectedFirstName = "John";
        employee.setFirstName(expectedFirstName);
        
        String actualFirstName = employee.getFirstName();
        
        Assert.assertEquals(expectedFirstName, actualFirstName);
    }

    @Test
    public void testGetFirstName_returnsNullWhenFirstNameNotSet() {
        String actualFirstName = employee.getFirstName();
        
        Assert.assertNull(actualFirstName);
    }
}