package com.fpg.ec.utility;

import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.GnuParser;
import org.apache.commons.cli.HelpFormatter;
import org.apache.commons.cli.Option;
import org.apache.commons.cli.OptionBuilder;
import org.apache.commons.cli.OptionGroup;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.ParseException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class SimpleCommand {

	public static void main(String[] args) {
		Option help = new Option("help", "print the spec...");

		// Option gcBo = OptionBuilder.withArgName("gcBo").hasArg(true)
		// .withDescription("generate code of Bo").create("gcBo");
		// gcBo.setRequired(true);

		Option master = OptionBuilder.withArgName("name").hasArg(true)
				.withLongOpt("master").withDescription(
						"the model name of master").create("m");
		master.setRequired(false);

		Option detail = OptionBuilder.withArgName("name").hasArg(true)
				.withLongOpt("detail").withDescription(
						"the model name of detail").create("d");
		detail.setRequired(false);

		Option one = OptionBuilder.withArgName("one").hasArg(false)
				.withDescription("the business object of primary key format")
				.create("one");

		Option one2many = OptionBuilder
				.withArgName("one2many")
				.hasArg(false)
				.withDescription(
						"the business object from mapping, one to many relation with primary key format.")
				.create("one2many");

		OptionGroup tpyeGroup = new OptionGroup();

		tpyeGroup.addOption(one);
		tpyeGroup.addOption(one2many);
		tpyeGroup.setRequired(false);

		Options options = new Options();
		options.addOptionGroup(tpyeGroup);
		options.addOption(master);
		options.addOption(detail);
		options.addOption(help);

		CommandLineParser parser = new GnuParser();
		try {
			// parse the command line arguments
			CommandLine line = parser.parse(options, args);
			if (line.hasOption("help")) {
				HelpFormatter formatter = new HelpFormatter();
				formatter.printHelp(
						"[ [-one | -one2many] -m <name> -d <name> ]",
						options);
			} else {
				useApp(line);
			}
		} catch (ParseException exp) {
			System.err.println("Parsing failed.  Reason: " + exp.getMessage());
		}

	}

	private static void useApp(CommandLine line) {
		// TODO Auto-generated method stub
		String gcode = "generate code: business object--> ";
		String master = line.getOptionValue("master");
		ApplicationContext context = new ClassPathXmlApplicationContext(
				"codeContext.xml");
		BoCommand boCommand = (BoCommand) context.getBean("boCommand");
		if (line.hasOption("one")) {
			System.out.println(gcode + master);
			System.out.println(boCommand.one(master));
		}
		if (line.hasOption("one2many")) {
			String detail = line.getOptionValue("detail");
			System.out.println(gcode + master);
			System.out.println(gcode + detail);
			System.out.println(boCommand.one2many(master,detail));
		}
	}
}
