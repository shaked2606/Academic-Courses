package bgu.spl.mics;

import java.util.concurrent.*;

/**
 * The {@link MessageBusImpl class is the implementation of the MessageBus interface.
 * Write your implementation here!
 * Only private fields and methods can be added to this class.
 */
public class MessageBusImpl implements MessageBus {
	private static class SingeltonHolder {
		private static MessageBusImpl messageBus = new MessageBusImpl();
	}
	
	private ConcurrentHashMap<MicroService, LinkedBlockingQueue<Message>> services;                         // <specific micro service, it's message queue>
	private ConcurrentHashMap<Class<? extends Event<?>>, LinkedBlockingQueue<MicroService>> events;        // <event type, round robin queue of micro services that handles it>
	private ConcurrentHashMap<Class<? extends Broadcast>, LinkedBlockingQueue<MicroService>> broadcasts;   // <broadcast type, queue of services that are subscribed to>
	private ConcurrentHashMap<Event<?>, Future> futures;                                                   // <specific event, it's matching future>
	
	private MessageBusImpl() {
		services = new ConcurrentHashMap<MicroService, LinkedBlockingQueue<Message>>();
		events = new ConcurrentHashMap<Class<? extends Event<?>>, LinkedBlockingQueue<MicroService>>();
		broadcasts = new ConcurrentHashMap<Class<? extends Broadcast>, LinkedBlockingQueue<MicroService>>();
		futures = new ConcurrentHashMap<Event<?>, Future>();
	}
	
	public static MessageBusImpl getInstance() {
		return SingeltonHolder.messageBus;
	}
 
	
	@Override
	public <T> void subscribeEvent(Class<? extends Event<T>> type, MicroService m) {
		synchronized (type) {  
			LinkedBlockingQueue<MicroService> queue = events.get(type);
			
			if (queue==null) {    // initialize queue
				queue = new LinkedBlockingQueue<MicroService>();  
				events.put(type, queue);
			}
			queue.add(m);
		}
	}
	@Override
	public void subscribeBroadcast(Class<? extends Broadcast> type, MicroService m) {
		synchronized (type) {
			LinkedBlockingQueue<MicroService> queue = broadcasts.get(type);
			
			if (queue==null) {     // initialize queue
				queue = new LinkedBlockingQueue<MicroService>();
				broadcasts.put(type, queue);
			}
			queue.add(m);
		}
	}

	@Override
	public <T> void complete(Event<T> e, T result) {
		@SuppressWarnings("unchecked")
		Future<T> future = (Future<T>)futures.get(e);
		future.resolve(result);    // one-to-one match between MS to Future, so there's no clashing problems
		futures.remove(e);        // delete after finishing computing
	}

	@Override
	public void sendBroadcast(Broadcast b) {
		LinkedBlockingQueue<MicroService> queue = broadcasts.get(b.getClass()); 
		if (queue!=null) {
			for(MicroService currMicroService: queue) {     // going through the micro services that are subscribed
				LinkedBlockingQueue<Message> currQueue = services.get(currMicroService);
				if (currQueue!=null) {
					try {
						currQueue.put(b);
					} catch (InterruptedException e) {
					}
				}
			}
		}
	}


	@Override
	public <T> Future<T> sendEvent(Event<T> e)  {
		LinkedBlockingQueue<MicroService> queue = events.get(e.getClass()) ;
		Future<T> future = null;
		MicroService curr=null;

		if (queue!=null) {
			synchronized (queue) {
				curr = queue.poll();
				try {
					if (curr!=null) {
						queue.put(curr);
					}
				} catch (InterruptedException e1) {
				}
			}

			if (curr!=null) {
				future = new Future<T>();
				futures.put(e, future);
				LinkedBlockingQueue<Message> currQueue = services.get(curr);
				if(currQueue != null) {
					try {
						currQueue.put(e);
					} catch (InterruptedException e1) {
					}
				}
			}
		}

		if (curr!=null && services.get(curr)==null) {   // if micro service unregistered before putting the event in it's queue
			future=null;
		}

		return future;
	}

	@Override
	public void register(MicroService m) {
		if (m!=null) {
			LinkedBlockingQueue<Message> tmp = new LinkedBlockingQueue<Message>();
			services.putIfAbsent(m, tmp);
		}
	}

	@Override
	public void unregister(MicroService m) {
		if(m!=null) {
			// delete micro service from all events and broadcasts that its subscribed to
			for(LinkedBlockingQueue<MicroService> currQueue:events.values()) {
				currQueue.remove(m);
			}
			for(LinkedBlockingQueue<MicroService> currQueue:broadcasts.values()) {
				currQueue.remove(m);
			}
			
			// clean the micro service's queue - resolve all futures to null
			LinkedBlockingQueue<Message> mesgQueue = services.remove(m);
			while (!mesgQueue.isEmpty()) {
				Message mesg = mesgQueue.remove();
				if (mesg instanceof Event<?>) {
					complete((Event<?>)mesg, null);
				}
			}
		}
	}


	@Override
	public Message awaitMessage(MicroService m) throws InterruptedException {
		LinkedBlockingQueue<Message> queue = services.get(m);
		Message message = queue.take();   
		return message;
	}

	

}
