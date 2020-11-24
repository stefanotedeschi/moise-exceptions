package moise.os.fs.exceptions;

import moise.os.fs.Goal;

public class ThrowingGoal extends Goal {

	private NotificationPolicy inNotificationPolicy;
	
	public ThrowingGoal(String goal) {
		super(goal);
		// TODO Auto-generated constructor stub
	}

	public NotificationPolicy getInNotificationPolicy() {
		return inNotificationPolicy;
	}

	public void setInNotificationPolicy(NotificationPolicy inNotificationPolicy) {
		this.inNotificationPolicy = inNotificationPolicy;
	}

}
