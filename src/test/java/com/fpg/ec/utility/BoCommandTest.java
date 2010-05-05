package com.fpg.ec.utility;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import junit.framework.TestCase;

public class BoCommandTest extends TestCase {

	ApplicationContext context = null;
	protected void setUp() throws Exception {
		super.setUp();
		System.out.println("context start.....main/resources/codeContext.xml");
		context = new ClassPathXmlApplicationContext(
				"codeContext.xml");
	}

	public void testMakeStringByFreeMaker() {
		BoCommand boCommand = (BoCommand) context.getBean("boCommand");
		String sample ="${boo_method.one2many(\"ISOCertificate\",\"ISOCertificatePicture\")}";
		String result = boCommand.makeStringByFreeMaker(sample);
		System.out.println("result: "+result);
		assertNotNull(result);
	}
	
	public void testOne() {
		BoCommand boCommand = (BoCommand) context.getBean("boCommand");
		String result = boCommand.one("Menu");
		System.out.println("result: "+result);
		assertNotNull(result);
	}
	
	public void testOne2Many() {
		BoCommand boCommand = (BoCommand) context.getBean("boCommand");
		String result = boCommand.one2many("Menu", "Item");
		System.out.println("result: "+result);
		assertNotNull(result);
	}

}
