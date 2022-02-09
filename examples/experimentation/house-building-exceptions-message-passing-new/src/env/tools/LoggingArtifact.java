package tools;

import java.util.Calendar;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import cartago.Artifact;
import cartago.OPERATION;

public class LoggingArtifact extends Artifact {
    
    long startTimeMillis;
    long endTimeMillis;

    private Logger logger = LogManager.getLogger(LoggingArtifact.class);
    
    @OPERATION
    public void logStart() {

        startTimeMillis = Calendar.getInstance().getTimeInMillis();

    }

    @OPERATION
    public void logFinish() {

        endTimeMillis = Calendar.getInstance().getTimeInMillis();

        logger.info(endTimeMillis - startTimeMillis + ";");

    }

}
