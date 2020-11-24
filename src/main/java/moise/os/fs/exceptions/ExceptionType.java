package moise.os.fs.exceptions;
import java.util.Arrays;

public class ExceptionType {

    private String type;
    private String[] arguments;
    private String faultState;
    
    public ExceptionType(String type, String[] arguments, String faultState) {
        super();
        this.type = type;
        this.arguments = arguments;
        this.faultState = faultState;
    }

    public String getType() {
        return type;
    }

    public String[] getArguments() {
        return arguments;
    }

    public String getFaultState() {
        return faultState;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setArguments(String[] arguments) {
        this.arguments = arguments;
    }

    public void setFaultState(String faultState) {
        this.faultState = faultState;
    }

    @Override
    public String toString() {
        return "ExceptionType [type=" + type + ", arguments=" + Arrays.toString(arguments) + ", faultState="
                + faultState + "]";
    }
    
}
