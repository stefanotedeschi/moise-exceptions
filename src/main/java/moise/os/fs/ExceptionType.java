package moise.os.fs;
import java.util.Arrays;

public class ExceptionType {

    private String type;
    private String[] arguments;
    private String condition;
    
    public ExceptionType(String type, String[] arguments, String condition) {
        super();
        this.type = type;
        this.arguments = arguments;
        this.condition = condition;
    }

    public String getType() {
        return type;
    }

    public String[] getArguments() {
        return arguments;
    }

    public String getCondition() {
        return condition;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setArguments(String[] arguments) {
        this.arguments = arguments;
    }

    public void setCondition(String condition) {
        this.condition = condition;
    }

    @Override
    public String toString() {
        return "ExceptionType [type=" + type + ", arguments=" + Arrays.toString(arguments) + ", condition="
                + condition + "]";
    }
    
}
