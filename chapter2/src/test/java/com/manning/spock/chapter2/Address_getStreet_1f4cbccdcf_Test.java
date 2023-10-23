// Test generated by RoostGPT for test SpockTest using AI Type Open AI and AI Model gpt-4

package com.manning.spock.chapter2;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

public class Address_getStreet_1f4cbccdcf_Test {

    private Address address;

    @Before
    public void setUp() {
        address = new Address();
    }

    @Test
    public void testGetStreet_whenStreetIsSet() {
        String expectedStreet = "Baker Street";
        address.setStreet(expectedStreet);
        String actualStreet = address.getStreet();
        Assert.assertEquals(expectedStreet, actualStreet);
    }

    @Test
    public void testGetStreet_whenStreetIsNotSet() {
        String actualStreet = address.getStreet();
        Assert.assertNull(actualStreet);
    }
}
