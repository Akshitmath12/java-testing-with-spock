// Test generated by RoostGPT for test SpockTest using AI Type Open AI and AI Model gpt-4

package com.manning.spock.chapter2;

import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;

public class Address_getCountry_60edba3cae_Test {

    private Address address;

    @Before
    public void setUp() {
        address = new Address();
    }

    @Test
    public void testGetCountryWhenCountryIsSet() {
        String expectedCountry = "USA";
        address.setCountry(expectedCountry);
        String actualCountry = address.getCountry();
        assertEquals(expectedCountry, actualCountry);
    }

    @Test
    public void testGetCountryWhenCountryIsNotSet() {
        String actualCountry = address.getCountry();
        assertNull(actualCountry);
    }
}
