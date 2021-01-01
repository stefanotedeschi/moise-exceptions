package moise.os.fs.exceptions;
import java.util.Arrays;

public class PolicyConditionTemplate {

    private String type;
    private String[] argumentNames;
    private String faultState;
    
    public PolicyConditionTemplate(String type, String[] argumentNames, String faultState) {
        super();
        this.type = type;
        this.argumentNames = argumentNames;
        this.faultState = faultState;
    }

    public String getType() {
        return type;
    }

    public String[] getArgumentNames() {
        return argumentNames;
    }

    public String getFaultState() {
        return faultState;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setArgumentNames(String[] arguments) {
        this.argumentNames = arguments;
    }

    public void setFaultState(String faultState) {
        this.faultState = faultState;
    }

    @Override
    public String toString() {
        return "PolicyType [type=" + type + ", arguments=" + Arrays.toString(argumentNames) + ", faultState="
                + faultState + "]";
    }
    
}
