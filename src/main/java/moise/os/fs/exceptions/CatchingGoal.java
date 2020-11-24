package moise.os.fs.exceptions;

import moise.os.fs.Goal;

public class CatchingGoal extends Goal {

	private HandlingPolicy inHandlingPolicy;
	
	public CatchingGoal(String goal) {
		super(goal);
		// TODO Auto-generated constructor stub
	}

    public HandlingPolicy getInHandlingPolicy() {
        return inHandlingPolicy;
    }

    public void setInHandlingPolicy(HandlingPolicy inHandlingPolicy) {
        this.inHandlingPolicy = inHandlingPolicy;
    }

}
