package bgu.spl.mics.application.passiveObjects;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * Passive data-object representing a customer of the store.
 * You must not alter any of the given public methods of this class.
 * <p>
 * You may add fields and methods to this class as you see fit (including public methods).
 */
public class Customer implements Serializable{

	private int id;
	private String name;
	private String address;
	private int distance;
	private List<OrderReceipt> receipts;
	private int creditCard;
	private int availableAmountInCreditCard;

	public Customer(int id, String name, String address, int distance, int creditCard, int availableAmountInCreditCard) {
		this.id = id;
		this.name = name;
		this.address = address;
		this.distance = distance;
		this.receipts = Collections.synchronizedList(new ArrayList<>());
		this.creditCard = creditCard;
		this.availableAmountInCreditCard = availableAmountInCreditCard;
	}

	/**
     * Retrieves the name of the customer.
     */
	public String getName() {
		return name;
	}

	/**
     * Retrieves the ID of the customer  . 
     */
	public int getId() {
		return id;
	}
	
	/**
     * Retrieves the address of the customer.  
     */
	public String getAddress() {
		return address;
	}
	
	/**
     * Retrieves the distance of the customer from the store.  
     */
	public int getDistance() {
		return this.distance;
	}

	
	/**
     * Retrieves a list of receipts for the purchases this customer has made.
     * <p>
     * @return A list of receipts.
     */
	public List<OrderReceipt> getCustomerReceiptList() {
		return this.receipts;
	}
	
	/**
     * Retrieves the amount of money left on this customers credit card.
     * <p>
     * @return Amount of money left.   
     */
	public int getAvailableCreditAmount() {
		return this.availableAmountInCreditCard;
	}
	
	/**
     * Retrieves this customers credit card serial number.    
     */
	public int getCreditNumber() {
		return this.creditCard;
	}
	
	// returns true if charge succeed
	public void chargeCreditCard(int amount) {
			this.availableAmountInCreditCard -= amount;
	}
	
	public void addOrderReceipt(OrderReceipt receipt) {
		this.receipts.add(receipt);
	}
	
}
