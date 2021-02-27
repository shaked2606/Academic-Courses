package bgu.spl.mics.application;

import java.io.FileOutputStream;
import  java.lang.Math;
import java.io.FileReader;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.concurrent.CountDownLatch;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import bgu.spl.mics.MicroService;
import bgu.spl.mics.application.passiveObjects.*;
import bgu.spl.mics.application.services.*;

/** This is the Main class of the application. You should parse the input file, 
 * create the different instances of the objects, and run the system.
 * In the end, you should output serialized objects.
 */
public class BookStoreRunner {

	private static CountDownLatch leftToSubscribeTick;
	private static CountDownLatch leftToSubscribeTerminate;
	private static CountDownLatch leftServiceTerminate;
	private static HashMap<Integer, Customer> customersMap;
	
	public static void main(String[] args) {
		customersMap = new HashMap<Integer, Customer>();
		MoneyRegister money = MoneyRegister.getInstance(); 	
		
		parseFileAndRun(args[0]);                                 
		
		
		try {
			leftServiceTerminate.await();
		} catch (InterruptedException e) {}

		serializedObjectToFile(customersMap,args[1]);              //serialized costumers hashmap to file
		Inventory.getInstance().printInventoryToFile(args[2]);     //serialized inventory data to file
		MoneyRegister.getInstance().printOrderReceipts(args[3]);   //serialized order receipts list to file
		serializedObjectToFile(money,args[4]);                     //serialized money register object to file
		
		System.exit(0);                                            //terminate main thread
	}

	private static void parseFileAndRun(String input) {
		try {
			Object object = new JSONParser().parse(new FileReader(input)); 
			JSONObject jsonObject = (JSONObject)object;

			initInventory(jsonObject);  
			initResourcesHolder(jsonObject);
			
			
			JSONObject servicesList = (JSONObject)jsonObject.get("services");

			// selling services
			long sellingNumLong = (long)((JSONObject)servicesList).get("selling");
			int sellingNum = Math.toIntExact(sellingNumLong);
			

			// inventory services
			long inventoryServiceNumLong = (long)((JSONObject)servicesList).get("inventoryService");
			int inventoryServiceNum = Math.toIntExact(inventoryServiceNumLong);		
			
			// logistics services
			long logisticsNumLong = (long)((JSONObject)servicesList).get("logistics");
			int logisticsNum = Math.toIntExact(logisticsNumLong);

			// resources services
			long resourcesServiceNumLong = (long)((JSONObject)servicesList).get("resourcesService");
			int resourcesServiceNum = Math.toIntExact(resourcesServiceNumLong);

			// API
			JSONArray customers = (JSONArray) servicesList.get("customers");
			int apiServiceNum = customers.size();
			
			/***create services***/
			initCountDown(sellingNum, inventoryServiceNum, logisticsNum,resourcesServiceNum, apiServiceNum);
			initSelling(sellingNum);	
			initInventoryServices(inventoryServiceNum);	
			initLogistics(logisticsNum);	
			initResourceServices(resourcesServiceNum);
			initApiServices(servicesList);	
			initTimeService(servicesList);

		} catch (Exception e) {}
	}
	
	/*** inventory ***/
	private static void initInventory(JSONObject jsonObject) {
		JSONArray booksList = (JSONArray)jsonObject.get("initialInventory");
		BookInventoryInfo[] inventory = new BookInventoryInfo[booksList.size()];

		int i=0;
		for (Object curr: booksList) {
			String bookTitle = (String)((JSONObject)curr).get("bookTitle");
			long amountLong = (long)((JSONObject)curr).get("amount");
			int amount = Math.toIntExact(amountLong);
			long priceLong = (long)((JSONObject)curr).get("price");
			int price = Math.toIntExact(priceLong);

			BookInventoryInfo toAdd = new BookInventoryInfo(bookTitle, amount, price);
			inventory[i] = toAdd;
			i++;
		}
		Inventory.getInstance().load(inventory);
	}
	
	/*** resource holder ***/
	private static void initResourcesHolder(JSONObject jsonObject) {
		JSONArray resourcesList = (JSONArray)jsonObject.get("initialResources");
		JSONObject vehiclesObj = (JSONObject)resourcesList.get(0);
		JSONArray vehiclesList = (JSONArray) vehiclesObj.get("vehicles");
		
		int i=0;
		DeliveryVehicle[] vehicles = new DeliveryVehicle[vehiclesList.size()];
		
		for (Object curr: vehiclesList) {
			long licenseLong = (long)((JSONObject)curr).get("license");
			int license = Math.toIntExact(licenseLong);

			long speedLong = (long)((JSONObject)curr).get("speed");
			int speed = Math.toIntExact(speedLong);

			DeliveryVehicle vehicle = new DeliveryVehicle(license, speed);
			vehicles[i] = vehicle;
			i++;
		}
		
		ResourcesHolder.getInstance().load(vehicles);
	}
	
	/*** counters ***/
	private static void initCountDown(int sellingNum, int inventoryNum, int logisticsNum, int resourcesNum, int apiNum) {
		int subscribeTickNum = sellingNum + apiNum;
		int subscribeTerminateNum = sellingNum + inventoryNum + logisticsNum + resourcesNum + apiNum;

		leftToSubscribeTick = new CountDownLatch(subscribeTickNum);
		leftToSubscribeTerminate = new CountDownLatch(subscribeTerminateNum);
		leftServiceTerminate = new CountDownLatch(subscribeTerminateNum+1); //+1 because including time service
	}

	/*** selling services ***/
	private static void initSelling(int sellingNum) {	
		for (int i=1; i<=sellingNum; i++) {
			SellingService curr = new SellingService(i, leftToSubscribeTick,leftServiceTerminate, leftToSubscribeTerminate);
			Thread t = new Thread(curr);
			t.start();	
		}
	}
	
	/*** inventory services ***/
	private static void initInventoryServices(int inventoryServiceNum) {
		for (int i=1; i<=inventoryServiceNum; i++) {
			InventoryService curr = new InventoryService(i,leftServiceTerminate, leftToSubscribeTerminate);
			Thread t = new Thread(curr);
			t.start();	
		}
	}
	
	/*** logistics services ***/
	private static void initLogistics(int logisticsNum) {
		for (int i=1; i<=logisticsNum; i++) {
			LogisticsService curr = new LogisticsService(i,leftServiceTerminate, leftToSubscribeTerminate);
			Thread t = new Thread(curr);
			t.start();
		}
	}

	/*** resource services ***/
	private static void initResourceServices(int resourcesServiceNum) {
		for (int i=1; i<=resourcesServiceNum; i++) {
			ResourceService curr = new ResourceService(i,leftServiceTerminate, leftToSubscribeTerminate, false);
			Thread t = new Thread(curr);
			t.start();	
		}
	}

	/*** API services ***/
	private static void initApiServices(JSONObject servicesList) {
		// API service
		JSONArray customers = (JSONArray) servicesList.get("customers");
		for (Object curr: customers) {
			// creating customer
			JSONObject customer = (JSONObject)curr;

			long idLong = (long)((JSONObject)customer).get("id");
			int id = Math.toIntExact(idLong);

			String name = (String) customer.get("name");
			String address = (String) customer.get("address");

			long distanceLong = (long)((JSONObject)customer).get("distance");
			int distance = Math.toIntExact(distanceLong);

			// creating credit card
			JSONObject creditCard = (JSONObject)customer.get("creditCard");

			long creditCardNumberLong = (long)((JSONObject)creditCard).get("number");
			int creditCardNumber = Math.toIntExact(creditCardNumberLong);

			long creditCardAmountLong = (long)((JSONObject)creditCard).get("amount");
			int creditCardAmount = Math.toIntExact(creditCardAmountLong);

			Customer currCustomer = new Customer(id, name, address, distance, creditCardNumber, creditCardAmount);
			customersMap.put(id, currCustomer);

			// creating order schedule
			JSONArray jsonOrders = (JSONArray)customer.get("orderSchedule");
			LinkedList<Order> orders = new LinkedList<Order>(); 

			for (Object currOrder: jsonOrders) {
				JSONObject order = (JSONObject)currOrder;
				String bookTitle = (String)order.get("bookTitle");

				long tickLong = (long)((JSONObject)order).get("tick");
				Integer tick = Math.toIntExact(tickLong);
				orders.add(new Order(bookTitle, tick));
			}

			APIService api= new APIService(currCustomer, orders, leftToSubscribeTick,leftServiceTerminate, leftToSubscribeTerminate);
			Thread t = new Thread(api);
			t.start();
		}
	}
	
	/*** time service ***/
	private static void initTimeService(JSONObject servicesList) {
		
		JSONObject timer = (JSONObject)servicesList.get("time");

		long speedLong = (long)((JSONObject)timer).get("speed");
		int speed = Math.toIntExact(speedLong);

		long durationLong = (long)((JSONObject)timer).get("duration");
		int duration = Math.toIntExact(durationLong);

		MicroService timerService = new TimeService(speed, duration,leftServiceTerminate);
		Thread t = new Thread(timerService);
		
		// wait until all micro services will subscribe messages from time service, then start it
		try {
			leftToSubscribeTick.await();
		} catch (InterruptedException e1) {}
		try {
			leftToSubscribeTerminate.await();
		} catch (InterruptedException e) {}
		t.start();
	}

	/*** serialize ***/
	private static void serializedObjectToFile(Object obj, String filename) {
		try
		{
			FileOutputStream fos = new FileOutputStream(filename);
			ObjectOutputStream oos = new ObjectOutputStream(fos);
			oos.writeObject(obj);
			oos.close();
			fos.close();
		}catch(IOException ioe) {}
	}

}