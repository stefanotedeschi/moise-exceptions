package tools;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import cartago.Artifact;
import cartago.OPERATION;

public class LoggingArtifact extends Artifact {
	
	private Logger logger = LogManager.getLogger(LoggingArtifact.class);
	
	@OPERATION
	public void log(String message) {
		
		logger.error(getCurrentOpAgentId().getAgentName() + " - " + message);

    }

}
