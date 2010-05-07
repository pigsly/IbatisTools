package com.fpg.ec.utility;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

public class JarManager {
	public static String getJarPath(Class target){
		String s = "";
		try {
			s = URLDecoder.decode(target.getResource(getSimpleClassNameWithExt(target)).toString(), "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
         s = s.replaceFirst("file:/", "");
         s = s.replaceFirst("jar:", "");
         s = s.substring(0, s.lastIndexOf("!") + 1);//jar required 
         s = s.substring(0, s.lastIndexOf("/") + 1);
         System.out.println("Jar Path: " + s);
		return s;
	}
	
	public static String getSimpleClassNameWithExt(Class target){
		return target.getSimpleName()+".class";
	}
}
