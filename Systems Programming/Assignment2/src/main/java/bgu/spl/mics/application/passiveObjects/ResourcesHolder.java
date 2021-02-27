package bgu.spl.mics.application.passiveObjects;

import bgu.spl.mics.Future;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.LinkedBlockingQueue;
/**
 * Passive object representing the resource manager.
 * You must not alter any of the given public methods of this class.
 * <p>
 * This class must be implemented safely as a thread-safe singleton.
 * You must not alter any of the given public methods of this class.
 * <p>
 * You can add ONLY private methods and fields to this class.
 */
public class ResourcesHolder {
	private static class SingeltonHolder {
		private static ResourcesHolder instance = new ResourcesHolder();
	}

	private ConcurrentHashMap<DeliveryVehicle, Boolean> vehiclesList;

	private Object lockList;
	private LinkedBlockingQueue<Future<DeliveryVehicle>> futuresQueue;     // queue of vehicle requests
	private int takenVehiclesNum;
	private int vehiclesNum;

	private ResourcesHolder() {
		this.vehiclesList = new ConcurrentHashMap<DeliveryVehicle, Boolean>();
		this.lockList = new Object();
		this.futuresQueue = new LinkedBlockingQueue<Future<DeliveryVehicle>>();
		this.takenVehiclesNum = 0;
	}

	/**
	 * Retrieves the single instance of this class.
	 */
	public static ResourcesHolder getInstance() {
		return SingeltonHolder.instance;
	}

	/**
	 * Tries to acquire a vehicle and gives a future object which will
	 * resolve to a vehicle.
	 * <p>
	 * @return 	{@link Future<DeliveryVehicle>} object which will resolve to a 
	 * 			{@link DeliveryVehicle} when completed.   
	 */
	public Future<DeliveryVehicle> acquireVehicle() {
		Future<DeliveryVehicle> output = new Future<DeliveryVehicle>();
		DeliveryVehicle acquiredVehicle = null;

		synchronized (lockList) {
			if (takenVehiclesNum<vehiclesNum) {      // there's available vehicle
				for (Map.Entry<DeliveryVehicle, Boolean> currEntry: vehiclesList.entrySet()) {
					if(!currEntry.getValue()) {
						acquiredVehicle = currEntry.getKey();
						currEntry.setValue(true);
						output.resolve(acquiredVehicle);
						takenVehiclesNum++;
					}
				}
			}

			else {
				futuresQueue.add(output);  // there's no available vehicle, add to queue of requests
			}

			return output;
		}
	}

	/**
	 * Releases a specified vehicle, opening it again for the possibility of
	 * acquisition.
	 * <p>
	 * @param vehicle	{@link DeliveryVehicle} to be released.
	 */
	public void releaseVehicle(DeliveryVehicle vehicle) {
		
		if (!futuresQueue.isEmpty()) {     // there's open vehicle request, resolve it with the vehicle to release
			Future<DeliveryVehicle> future = futuresQueue.poll();
			if (future!=null) {
				future.resolve(vehicle);
			}
		}

		else {
			synchronized (lockList) {       // there's no open requests
				this.vehiclesList.replace(vehicle, false);
				takenVehiclesNum--;
			}
		}
	}

	/**
	 * Receives a collection of vehicles and stores them.
	 * <p>
	 * @param vehicles	Array of {@link DeliveryVehicle} instances to store.
	 */
	public void load(DeliveryVehicle[] vehicles) {
		this.vehiclesList = new ConcurrentHashMap<DeliveryVehicle, Boolean>();
		for (DeliveryVehicle vehicle: vehicles) {
		this.vehiclesList.put(vehicle, false);
		}
		this.vehiclesNum = vehiclesList.size();
	}

}
