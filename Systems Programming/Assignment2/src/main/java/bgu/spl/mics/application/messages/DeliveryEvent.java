package bgu.spl.mics.application.messages;

import bgu.spl.mics.*;

public class DeliveryEvent implements Event<Class<Void>>{
	
	private String address;
	private int distance;
	
	public DeliveryEvent(String address, int distance) {
		this.address = address;
		this.distance = distance;
    }
	
	public String getAddress() {
		return address;
	}
	
	public int getDistance() {
		return distance;
	}

    

    
}