package moise.os.fs.exceptions;

import moise.os.fs.Goal;

public class ThrowingGoal extends Goal {

	private NotificationPolicy inNotificationPolicy;
	
	public ThrowingGoal(String goal, NotificationPolicy inNotificationPolicy) {
		super(goal);
		this.inNotificationPolicy = inNotificationPolicy;
	}

	public NotificationPolicy getInNotificationPolicy() {
		return inNotificationPolicy;
	}

}
