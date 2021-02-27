package bgu.spl.mics.application.services;

import java.util.concurrent.CountDownLatch;

import bgu.spl.mics.Event;
import bgu.spl.mics.Future;
import bgu.spl.mics.MicroService;
import bgu.spl.mics.application.passiveObjects.*;
import bgu.spl.mics.application.messages.AvailabilityAndPriceEvent;
import bgu.spl.mics.application.messages.BookOrderEvent;
import bgu.spl.mics.application.messages.DeliveryEvent;
import bgu.spl.mics.application.messages.TakeEvent;
import bgu.spl.mics.application.messages.TerminateBroadcast;
import bgu.spl.mics.application.messages.TickBroadcast;
import bgu.spl.mics.application.passiveObjects.Customer;
import bgu.spl.mics.application.passiveObjects.MoneyRegister;

/**
 * Selling service in charge of taking orders from customers.
 * Holds a reference to the {@link MoneyRegister} singleton of the store.
 * Handles {@link BookOrderEvent}.
 * This class may not hold references for objects which it is not responsible for:
 * {@link ResourcesHolder}, {@link Inventory}.
 * 
 * You can add private fields and public methods to this class.
 * You MAY change constructor signatures and even add new public constructors.
 */
public class SellingService extends MicroService{

	private MoneyRegister moneyRegister;
	private int currentTick;
	private CountDownLatch tickCount;
	private CountDownLatch terminateCount;
	private CountDownLatch terminateBroadcastCount;

	public SellingService(int i,  CountDownLatch tickCount, CountDownLatch terminateCount, CountDownLatch terminateBroadcastCount) {
		super("selling service " + i);
		this.moneyRegister = MoneyRegister.getInstance();
		this.tickCount = tickCount;
		this.terminateCount = terminateCount;
		this.terminateBroadcastCount = terminateBroadcastCount;
	}

	public SellingService() {
		super("selling service");
		this.moneyRegister = MoneyRegister.getInstance();
	}

	@Override
	protected void initialize() {
		subscribeBroadcast(TerminateBroadcast.class, broadcast->{
			terminate();
			terminateCount.countDown();
		});	
		terminateBroadcastCount.countDown();

		subscribeBroadcast(TickBroadcast.class, tickBroadcast -> {
			this.currentTick = tickBroadcast.getCurrentTick();
		});
		tickCount.countDown();

		subscribeEvent(BookOrderEvent.class, bookOrderEvent -> {
			int processTick = this.currentTick;
			boolean succeed = false;
			String bookTitle = bookOrderEvent.getBookTitle();
			Customer customer = bookOrderEvent.getCustomer();

			// returns price if book is available, if not, returns -1
			Event<Integer> availbilityAndPrice = new AvailabilityAndPriceEvent(bookTitle);
			Future<Integer> priceFuture = sendEvent(availbilityAndPrice);

			if (priceFuture!=null) {			
				Integer price = priceFuture.get();

				if (price!=null && price!=-1) {
					synchronized (customer) {

						if (customer.getAvailableCreditAmount()>=price) {    	// checks whether customer has enough money, if so - take book & charges his credit
							Event<OrderResult> take = new TakeEvent(bookTitle);
							Future<OrderResult> isTaken = sendEvent(take);

							if (isTaken!=null && isTaken.get()==OrderResult.SUCCESSFULLY_TAKEN) {
								moneyRegister.chargeCreditCard(bookOrderEvent.getCustomer(), price);   // charge customer 
								succeed = true;
							}
						}
					}
				}

				if(succeed) {
					issueReceiptAndDeliver(bookOrderEvent, processTick, bookTitle, customer, price);
				}

				else {
					complete(bookOrderEvent,null);
				}
			}
		
		});
	}

	private void issueReceiptAndDeliver(BookOrderEvent bookOrderEvent, int processTick, String bookTitle, Customer customer, int price) {
		OrderReceipt receipt = new OrderReceipt(0, getName(), customer.getId(), bookTitle, price,this.currentTick,bookOrderEvent.getOrderTick(),processTick);
		customer.addOrderReceipt(receipt);           // add receipt to customer
		moneyRegister.file(receipt);			 	// add receipt to MoneyRegister
		complete(bookOrderEvent,receipt);           

		// send event to deliver the book
		Event<Class<Void>> delivery = new DeliveryEvent(customer.getAddress(), customer.getDistance());
		sendEvent(delivery);
	}

}
