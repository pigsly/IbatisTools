package com.fpg.ec.utility;

import junit.framework.TestCase;

public class JarManagerTest extends TestCase {

	protected void setUp() throws Exception {
		super.setUp();
	}

	protected void tearDown() throws Exception {
		super.tearDown();
	}

	public void testGetSimpleClassNameWithExt(){
		String name = JarManager.getSimpleClassNameWithExt(IbatisDSLCommand.class);
		System.out.println(name);
	}
	
	public void testGetJarPath(){
		String name = JarManager.getJarPath(IbatisDSLCommand.class);
		System.out.println(name);
	}

}
