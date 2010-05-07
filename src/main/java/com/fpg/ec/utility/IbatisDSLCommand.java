package com.fpg.ec.utility;

import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.GnuParser;
import org.apache.commons.cli.HelpFormatter;
import org.apache.commons.cli.Option;
import org.apache.commons.cli.OptionBuilder;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.ParseException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.util.FileCopyUtils;

public class IbatisDSLCommand {
	
	IbatisDSLCommand(){
		
	}

	public static void main(String[] args) throws IOException {
		Option help = new Option("help", "print the spec...");
		Option statement = OptionBuilder.withArgName("statement").hasArg(true)
				.withLongOpt("statement").withDescription(
						"human-being can read....").create("m");
		statement.setRequired(false);

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
				String content = useApp(line);
				System.out.println(content);
				java.util.Date now = new java.util.Date(System.currentTimeMillis());
				DateFormat myformat = new SimpleDateFormat("yyyyMMddhhmmss");
				String stamp = myformat.format(now);
				String filename = line.getOptionValue("statement")+"_"+stamp+".txt";
				String jarPath = JarManager.getJarPath(IbatisDSLCommand.class);
				File out = new File(jarPath+ File.separator + filename);//	
				FileCopyUtils.copy(content.getBytes(), out);
			}
		} catch (ParseException exp) {
			System.err.println("Parsing failed.  Reason: " + exp.getMessage());
		}
	}

	private static String useApp(CommandLine line) {
		// TODO Auto-generated method stub
		String statement = line.getOptionValue("statement");
		ApplicationContext context = new ClassPathXmlApplicationContext(
				"classpath:/codeContext.xml");
		BoCommand boCommand = (BoCommand) context.getBean("boCommand");
		return boCommand.selectCli(statement);
	}
	
	
	
	
}
