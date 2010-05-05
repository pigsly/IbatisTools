package com.fpg.ec.utility;

import java.util.Arrays;

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

public class IbatisDSLCommand {

	public static void main(String[] args) {
		Option help = new Option("help", "print the spec...");
		Option statement = OptionBuilder.withArgName("statement").hasArg(true)
				.withLongOpt("statement").withDescription(
						"human-being can read....").create("m");
		statement.setRequired(true);

		Options options = new Options();
//		options.addOptionGroup(tpyeGroup);
//		options.addOption(master);
		options.addOption(statement);
		options.addOption(help);

		CommandLineParser parser = new GnuParser();
		try {
			// parse the command line arguments
			CommandLine line = parser.parse(options, args);
			if (line.hasOption("help")) {
				HelpFormatter formatter = new HelpFormatter();
				formatter.printHelp(
						"[ -m <statement> ]",
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
		String gcode = "generate code: --> ";
		String statement = line.getOptionValue("statement");
		ApplicationContext context = new ClassPathXmlApplicationContext(
				"codeContext.xml");
		BoCommand boCommand = (BoCommand) context.getBean("boCommand");
		System.out.println(boCommand.selectCli(statement));
		
	}
}
