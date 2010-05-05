package com.fpg.ec.utility;
import java.io.File;
import java.io.IOException;
import java.io.StringReader;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

public class BoCommand {

	private Configuration configuration;
	private String templateLoaderPath;

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println("context start.....main/resources/codeContext.xml");
		ApplicationContext context = new ClassPathXmlApplicationContext(
				"codeContext.xml");
		BoCommand boCommand = (BoCommand) context.getBean("boCommand");
//		System.out.println(boCommand.one("Menu"));
		System.out.println(boCommand.one2many("Menu","Item"));
	}
	
	public String one(String master){
		ApplicationContext context = new ClassPathXmlApplicationContext(
				"codeContext.xml");
		BoCommand boCommand = (BoCommand) context.getBean("boCommand");
//		String sample ="${boo_method.one2many(\"ISOCertificate\",\"ISOCertificatePicture\")}";
		String sample ="${boo_method.one(\""+master+"\")}";
		return boCommand.makeStringByFreeMaker(sample);
	}
	
	public String one2many(String master, String detail){
		ApplicationContext context = new ClassPathXmlApplicationContext(
				"codeContext.xml");
		BoCommand boCommand = (BoCommand) context.getBean("boCommand");
//		String sample ="${boo_method.one2many(\"ISOCertificate\",\"ISOCertificatePicture\")}";
		String sample ="${boo_method.one2many(\""+master+"\",\""+detail+"\")}";
		return boCommand.makeStringByFreeMaker(sample);
	}
	
	public String oneStatement(String statement){
		ApplicationContext context = new ClassPathXmlApplicationContext(
				"codeContext.xml");
		BoCommand boCommand = (BoCommand) context.getBean("boCommand");
		String sample ="${boo_method.oneStatement(\""+statement+"\")}";
		return boCommand.makeStringByFreeMaker(sample);
	}
	
	public String one2manyStatement(String statement){
		ApplicationContext context = new ClassPathXmlApplicationContext(
				"codeContext.xml");
		BoCommand boCommand = (BoCommand) context.getBean("boCommand");
		String sample ="${boo_method.one2manyStatement(\""+statement+"\")}";
		return boCommand.makeStringByFreeMaker(sample);
	}
	
	public String validate(String statement){
		ApplicationContext context = new ClassPathXmlApplicationContext(
				"codeContext.xml");
		BoCommand boCommand = (BoCommand) context.getBean("boCommand");
		String sample ="${cli.IValidateStatement(\""+statement+"\")}";
		return boCommand.makeStringByFreeMaker(sample);
	}
	
	public String selectDAO(String statement){
		ApplicationContext context = new ClassPathXmlApplicationContext(
				"codeContext.xml");
		BoCommand boCommand = (BoCommand) context.getBean("boCommand");
		String sample ="${daoo_method.ISelectStatement(\""+statement+"\")}";
		return boCommand.makeStringByFreeMaker(sample);
	}
	
	public String selectCli(String statement){
		ApplicationContext context = new ClassPathXmlApplicationContext(
				"codeContext.xml");
		BoCommand boCommand = (BoCommand) context.getBean("boCommand");
		String sample ="${cli.IParseStatement(\""+statement+"\")}";
		return boCommand.makeStringByFreeMaker(sample);
	}

	public String makeStringByFreeMaker(String command) {
		String result = null;
		// String content = "";
		String encode = "UTF-8";
		try {
			configuration.setDefaultEncoding(encode);
//			configuration.addAutoImport("boo_method", "boo_method.ftl");
//			configuration.addAutoImport("spring_context", "spring_context.ftl");
//			URL location = this.getClass().getProtectionDomain().getCodeSource().getLocation();
//			System.out.println("freemarker templateLoaderPath: "+location.getPath());
//			this.setTemplateLoaderPath(location.getPath()+File.separator+"freemarker");
			File td = new File(templateLoaderPath);
//			System.out.println("templateLoaderPath: " + templateLoaderPath);
			configuration.setDirectoryForTemplateLoading(td);
			Template t = new Template("name", new StringReader(command),
					configuration);
			Map map = new HashMap();
			result = FreeMarkerTemplateUtils.processTemplateIntoString(t, map);
			return result.toString();
		} catch (IOException e) {
			e.printStackTrace();
			System.out
					.println("Unable to read or process freemarker configuration or template");
		} catch (TemplateException e) {
			e.printStackTrace();
			System.out
					.println("Problem initializing freemarker or rendering command '"
							+ command + "'");
		}
		return result;
	}

	public Configuration getConfiguration() {
		return configuration;
	}

	public void setConfiguration(Configuration configuration) {
		this.configuration = configuration;
	}

	public String getTemplateLoaderPath() {
		return templateLoaderPath;
	}

	public void setTemplateLoaderPath(String templateLoaderPath) {
		this.templateLoaderPath = templateLoaderPath;
	}

}
