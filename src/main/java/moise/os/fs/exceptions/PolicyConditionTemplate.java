package moise.os.fs.exceptions;
import java.util.Arrays;

public class PolicyConditionTemplate {

    private String type;
    private String[] argumentNames;
    private String conditionFormula;
    
    public PolicyConditionTemplate(String type, String[] argumentNames, String conditionFormula) {
        super();
        this.type = type;
        this.argumentNames = argumentNames;
        this.conditionFormula = conditionFormula;
    }

    public String getType() {
        return type;
    }

    public String[] getArgumentNames() {
        return argumentNames;
    }

    public String getConditionFormula() {
        return conditionFormula;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setArgumentNames(String[] arguments) {
        this.argumentNames = arguments;
    }

    public void setConditionFormula(String conditionFormula) {
        this.conditionFormula = conditionFormula;
    }

    @Override
    public String toString() {
        return "PolicyType [type=" + type + ", arguments=" + Arrays.toString(argumentNames) + ", conditionFormula="
                + conditionFormula + "]";
    }
    
}
