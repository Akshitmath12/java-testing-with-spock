// Test generated by RoostGPT for test SpockTest using AI Type Open AI and AI Model gpt-4

package com.manning.spock.chapter2;

import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;

public class MilitaryPerson_setFirstName_8acaec2cfc_Test {

    private MilitaryPerson militaryPerson;

    @Before
    public void setUp() {
        militaryPerson = new MilitaryPerson();
    }

    @Test
    public void testSetFirstName() {
        String firstName = "John";
        militaryPerson.setFirstName(firstName);
        assertEquals(firstName, militaryPerson.getFirstName());
    }

    @Test
    public void testSetFirstNameNull() {
        String firstName = null;
        militaryPerson.setFirstName(firstName);
        assertNull(militaryPerson.getFirstName());
    }
}