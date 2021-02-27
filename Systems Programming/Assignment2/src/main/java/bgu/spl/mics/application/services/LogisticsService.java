package bgu.spl.mics.application.services;

import java.util.concurrent.CountDownLatch;

import bgu.spl.mics.Event;
import bgu.spl.mics.Future;
import bgu.spl.mics.MicroService;
import bgu.spl.mics.application.messages.DeliveryEvent;
import bgu.spl.mics.application.messages.GetVehicle;
import bgu.spl.mics.application.messages.ReleaseVehicleEvent;
import bgu.spl.mics.application.messages.TerminateBroadcast;
import bgu.spl.mics.application.passiveObjects.DeliveryVehicle;
import bgu.spl.mics.application.passiveObjects.ResourcesHolder;

/**
 * Logistic service in charge of delivering books that have been purchased to customers.
 * Handles {@link DeliveryEvent}.
 * This class may not hold references for objects which it is not responsible for:
 * {@link ResourcesHolder}, {@link MoneyRegister}, {@link Inventory}.
 * 
 * You can add private fields and public methods to this class.
 * You MAY change constructor signatures and even add new public constructors.
 */
public class LogisticsService extends MicroService {


	private CountDownLatch terminateCount;
	private CountDownLatch terminateBroadcastCount;

	public LogisticsService(int i, CountDownLatch terminateCount, CountDownLatch terminateBroadcastCount) {
		super("logistics " + i);
		this.terminateCount = terminateCount;
		this.terminateBroadcastCount = terminateBroadcastCount;
	}

	@Override
	protected void initialize() {
		subscribeBroadcast(TerminateBroadcast.class, broadcast->{
			terminate();
			terminateCount.countDown();
		});	
		terminateBroadcastCount.countDown();


		subscribeEvent(DeliveryEvent.class, deliveryEvent -> {
			Event<Future<DeliveryVehicle>> getVehicle = new GetVehicle();
			Future<Future<DeliveryVehicle>> acquiredVehicle = sendEvent(getVehicle);


			if(acquiredVehicle!=null)  {
				if (acquiredVehicle.get()!= null) {   
					DeliveryVehicle vehicle = acquiredVehicle.get().get();  // if needed - wait for a vehicle to be available

					if (vehicle!=null) {
						vehicle.deliver(deliveryEvent.getAddress(), deliveryEvent.getDistance());   // thread sleeps until delivery is over			
						Event<Class<Void>> releaseVehicle = new ReleaseVehicleEvent(vehicle);
						sendEvent(releaseVehicle);
					}
				}
			}

			Class<Void> voidType = void.class;
			complete(deliveryEvent, voidType);    // completed delivery event
		});


	}

}
