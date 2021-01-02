package moise.os.fs.exceptions;

public interface Policy {
    
    public PolicyCondition getCondition();
    
    public String getId();

}
