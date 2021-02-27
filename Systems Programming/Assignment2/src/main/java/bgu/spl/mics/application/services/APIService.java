package bgu.spl.mics.application.services;

import bgu.spl.mics.MicroService;
import bgu.spl.mics.application.messages.*;
import bgu.spl.mics.application.passiveObjects.*;

import java.util.LinkedList;
import java.util.List;
import java.util.concurrent.*;

/**
 * APIService is in charge of the connection between a client and the store.
 * It informs the store about desired purchases using {@link BookOrderEvent}.
 * This class may not hold references for objects which it is not responsible for:
 * {@link ResourcesHolder}, {@link MoneyRegister}, {@link Inventory}.
 * 
 * You can add private fields and public methods to this class.
 * You MAY change constructor signatures and even add new public constructors.
 */
public class APIService extends MicroService{
	private Customer customer;
	private List<Order> orderSchedule;
	private CountDownLatch tickCount;
	private CountDownLatch terminateBroadcastCount;
	private CountDownLatch terminateCount;
	
	public APIService(Customer customer, List<Order> orderSchedule, CountDownLatch tickCount, CountDownLatch terminateCount, CountDownLatch terminateBroadcastCount) {
		super("API Service");
		this.customer = customer;
		this.orderSchedule = new LinkedList<Order>(orderSchedule);
		this.tickCount = tickCount;
		this.terminateCount = terminateCount;
		this.terminateBroadcastCount = terminateBroadcastCount;
	}

	@Override
	protected void initialize() {
    	subscribeBroadcast(TerminateBroadcast.class, (broadcast)->{
    		terminate();
    		terminateCount.countDown();
    	});	
    	terminateBroadcastCount.countDown();
    	
    	
		subscribeBroadcast(TickBroadcast.class, tickBroadcast -> {
			Integer tick = tickBroadcast.getCurrentTick();
			for (Order order : orderSchedule) {
				if (tick.equals(order.getTick())) {
					BookOrderEvent e = new BookOrderEvent(order.getBookTitle(), customer, tick);
					sendEvent(e);
				}
			}	
		});
		tickCount.countDown();
		
	}
}
