// Test generated by RoostGPT for test SpockTest using AI Type Open AI and AI Model gpt-4

package com.manning.spock.chapter2;

import org.junit.Before;
import org.junit.Test;
import org.spockframework.runtime.extension.builtin.PreconditionContext;
import static org.junit.Assert.assertEquals;

public class Address_getStreet_1f4cbccdcf_Test {

    private Address address;

    @Before
    public void setUp() {
        address = new Address();
    }

    @Test
    public void testGetStreet() {
        address.setStreet("123 Main St");
        String result = address.getStreet();
        assertEquals("123 Main St", result);
    }

    @Test
    public void testGetStreet_Null() {
        address.setStreet(null);
        String result = address.getStreet();
        assertEquals(null, result);
    }
}
