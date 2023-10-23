// Test generated by RoostGPT for test SpockTest using AI Type Open AI and AI Model gpt-4

package com.manning.spock.chapter2;

import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.spockframework.runtime.extension.IGlobalExtension;
import org.spockframework.runtime.model.SpecInfo;
import org.spockframework.runtime.extension.AbstractGlobalExtension;
import org.spockframework.runtime.model.MethodInfo;
import org.spockframework.runtime.model.FeatureInfo;
import spock.lang.Specification;

import static org.junit.jupiter.api.Assertions.*;

@RunWith(SpockRunner.class)
public class MilitaryPerson_setLastName_4141db5e7c_Test extends Specification implements IGlobalExtension {

    public void visitSpec(SpecInfo spec) {
        for (FeatureInfo feature : spec.getFeatures()) {
            for (MethodInfo method : feature.getFeatureMethods()) {
                method.addInterceptor(new Interceptor());
            }
        }
    }

    private static class Interceptor implements IMethodInterceptor {
        void intercept(IMethodInvocation invocation) throws Throwable {
            invocation.proceed();
        }
    }

    @Test
    public void testSetLastName() {
        MilitaryPerson militaryPerson = new MilitaryPerson();
        militaryPerson.setLastName("Smith");
        assertEquals("Smith", militaryPerson.getLastName());
    }

    @Test
    public void testSetLastName_Null() {
        MilitaryPerson militaryPerson = new MilitaryPerson();
        assertThrows(NullPointerException.class, () -> militaryPerson.setLastName(null));
    }

    @Test
    public void testSetLastName_Empty() {
        MilitaryPerson militaryPerson = new MilitaryPerson();
        militaryPerson.setLastName("");
        assertEquals("", militaryPerson.getLastName());
    }
}
