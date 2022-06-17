package tools;

import java.util.Calendar;
import java.util.List;
import java.util.LinkedList;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import cartago.Artifact;
import cartago.OPERATION;

public class LoggingArtifact extends Artifact {
    
    long startTimeMillis;
    long endTimeMillis;

    int nObligations = 0;
    int nExceptions = 0;
    List<String> exceptions = new LinkedList<String>();
    int nMessages = 0;

    private Logger logger = LogManager.getLogger(LoggingArtifact.class);
    
    @OPERATION
    public void logStart() {

        startTimeMillis = Calendar.getInstance().getTimeInMillis();

    }

    @OPERATION
    public void logFinish() {

        endTimeMillis = Calendar.getInstance().getTimeInMillis();

        String log = endTimeMillis - startTimeMillis + "," + nMessages + "," + nExceptions + ",";

        log += '"' + "[";


        for(String ex : exceptions) {
            log += ex + ",";
        }

        if(log.length() > 2) {
            log = log.substring(0, log.length() - 1);
        }

        log += "]" + '"' + ";";

        logger.info(log);

    }

    @OPERATION
    public void logException(String exception) {
        nExceptions++;
        exceptions.add(exception);
    }

    @OPERATION
    public void logObligation() {
        nObligations++;
    }

    @OPERATION
    public void logMessage() {
        nMessages++;
    }

}
