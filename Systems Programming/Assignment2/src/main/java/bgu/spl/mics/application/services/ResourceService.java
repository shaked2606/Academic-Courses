package bgu.spl.mics.application.services;

import java.util.concurrent.CountDownLatch;
import java.util.concurrent.LinkedBlockingQueue;

import bgu.spl.mics.Future;
import bgu.spl.mics.MicroService;
import bgu.spl.mics.application.messages.GetVehicle;
import bgu.spl.mics.application.messages.ReleaseVehicleEvent;
import bgu.spl.mics.application.messages.TerminateBroadcast;
import bgu.spl.mics.application.passiveObjects.DeliveryVehicle;
import bgu.spl.mics.application.passiveObjects.ResourcesHolder;

/**
 * ResourceService is in charge of the store resources - the delivery vehicles.
 * Holds a reference to the {@link ResourceHolder} singleton of the store.
 * This class may not hold references for objects which it is not responsible for:
 * {@link MoneyRegister}, {@link Inventory}.
 * 
 * You can add private fields and public methods to this class.
 * You MAY change constructor signatures and even add new public constructors.
 */
public class ResourceService extends MicroService{

	private ResourcesHolder resources;
	private CountDownLatch terminateCount;
	private CountDownLatch terminateBroadcastCount;
	private LinkedBlockingQueue<Future<DeliveryVehicle>> futuresQueue;
	private boolean gotTerminateBroadcast;
	
	public ResourceService(int i, CountDownLatch terminateCount,CountDownLatch terminateBroadcastCount, boolean isReleaseService) {
		super("Resource Service " + i);
		this.resources = ResourcesHolder.getInstance();
		this.terminateCount = terminateCount;
		this.terminateBroadcastCount = terminateBroadcastCount;
		this.futuresQueue = new LinkedBlockingQueue<Future<DeliveryVehicle>>();
		this.gotTerminateBroadcast = false;
	}

	@Override
	protected void initialize() {
    	subscribeBroadcast(TerminateBroadcast.class, broadcast -> {
    		gotTerminateBroadcast = true;
    		
    		for (Future<DeliveryVehicle> curr: futuresQueue) {  // resolve to null all pending vehicle requests 
    			curr.resolve(null);
    		}
    	terminate();
    	terminateCount.countDown();
	});	
    	terminateBroadcastCount.countDown();
    	

		//Acquire Vehicle 
		subscribeEvent(GetVehicle.class, event -> {
			Future<DeliveryVehicle> acquiredVehicle = resources.acquireVehicle();
			
			if (!acquiredVehicle.isDone() & !gotTerminateBroadcast) {   // add to pending requests
				futuresQueue.add(acquiredVehicle);
			}
			
			if (gotTerminateBroadcast) {
				acquiredVehicle.resolve(null);
			}
			
			complete(event, acquiredVehicle);
		});
		
    	
    	//Release Vehicle
    	subscribeEvent(ReleaseVehicleEvent.class, event -> {
    		resources.releaseVehicle(event.getVehicleToRelease());
    		Class<Void> voidType = void.class;
    		complete(event, voidType);
    	});
    	
	}

}
