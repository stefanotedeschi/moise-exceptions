package tools;

import java.util.Calendar;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import cartago.Artifact;
import cartago.OPERATION;

public class LoggingArtifact extends Artifact {
    
    int nObligations = 0;

    private Logger logger = LogManager.getLogger(LoggingArtifact.class);
    
    @OPERATION
    public void logInc() {
        nObligations++;
    }

    @OPERATION
    public void logFinish() {
        logger.info(nObligations);
    }

}
