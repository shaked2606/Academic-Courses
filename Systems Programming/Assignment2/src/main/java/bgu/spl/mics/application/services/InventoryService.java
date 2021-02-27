package bgu.spl.mics.application.services;

import java.util.concurrent.CountDownLatch;

import bgu.spl.mics.MicroService;
import bgu.spl.mics.application.messages.AvailabilityAndPriceEvent;
import bgu.spl.mics.application.messages.TakeEvent;
import bgu.spl.mics.application.messages.TerminateBroadcast;
import bgu.spl.mics.application.passiveObjects.Inventory;
import bgu.spl.mics.application.passiveObjects.OrderResult;


/**
 * InventoryService is in charge of the book inventory and stock.
 * Holds a reference to the {@link Inventory} singleton of the store.
 * This class may not hold references for objects which it is not responsible for:
 * {@link ResourcesHolder}, {@link MoneyRegister}.
 * 
 * You can add private fields and public methods to this class.
 * You MAY change constructor signatures and even add new public constructors.
 */

public class InventoryService extends MicroService{
	
	private Inventory inventory;
	private CountDownLatch terminateCount;
	private CountDownLatch terminateBroadcastCount;
	
	public InventoryService(int i, CountDownLatch terminateCount, CountDownLatch terminateBroadcastCount) {
		super("inventory " + i);
		this.inventory = Inventory.getInstance();
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
		
		subscribeEvent(AvailabilityAndPriceEvent.class, event -> {
			int price = inventory.checkAvailabiltyAndGetPrice(event.getBookTitle());
			complete(event,price);
		});
		
		subscribeEvent(TakeEvent.class, event -> {
			OrderResult result = inventory.take(event.getBookTitle());
			complete(event,result);
		});
	}
}
