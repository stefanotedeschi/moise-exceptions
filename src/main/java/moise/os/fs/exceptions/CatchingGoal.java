package moise.os.fs.exceptions;

import moise.os.fs.Goal;

public class CatchingGoal extends Goal {

	private HandlingPolicy inHandlingPolicy;
	
	public CatchingGoal(String goal, HandlingPolicy inHandlingPolicy) {
		super(goal);
		this.inHandlingPolicy = inHandlingPolicy;
	}

    public HandlingPolicy getInHandlingPolicy() {
        return inHandlingPolicy;
    }

}
