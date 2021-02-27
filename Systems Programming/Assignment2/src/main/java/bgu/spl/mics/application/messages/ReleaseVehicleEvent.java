package bgu.spl.mics.application.messages;

import bgu.spl.mics.Event;
import bgu.spl.mics.application.passiveObjects.DeliveryVehicle;

public class ReleaseVehicleEvent implements Event<Class<Void>> {
	private DeliveryVehicle vehicle;
	
	public ReleaseVehicleEvent(DeliveryVehicle vehicle) {
		this.vehicle = vehicle;
	}
	
	public DeliveryVehicle getVehicleToRelease() {
		return this.vehicle;
	}

}
