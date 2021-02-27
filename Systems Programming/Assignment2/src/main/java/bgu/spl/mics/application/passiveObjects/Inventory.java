package bgu.spl.mics.application.passiveObjects;

import java.util.HashMap;
import java.io.*;

/**
 * Passive data-object representing the store inventory.
 * It holds a collection of {@link BookInventoryInfo} for all the
 * books in the store.
 * <p>
 * This class must be implemented safely as a thread-safe singleton.
 * You must not alter any of the given public methods of this class.
 * <p>
 * You can add ONLY private fields and methods to this class as you see fit.
 */
public class Inventory implements Serializable{
	private static class SingeltonHolder {
		private static Inventory instance = new Inventory();
	}
	
	private  BookInventoryInfo[] books;
	
	private Inventory() {}
	
	/**
     * Retrieves the single instance of this class.
     */
	public static Inventory getInstance() {
		return SingeltonHolder.instance;
	}
	
	/* ---------functions to use in test--------- */
	// returns amount of book in inventory
	public int getAmount(String name) {
		BookInventoryInfo book = findBook(name);
		if(book != null) {
			return book.getAmountInInventory();
		}
		return -1;
	}
	
	// return true if book is in the array (also if it's amount is 0)
	public boolean isExistInInventory(String name) {
		if(findBook(name)==null) {
			return false;
		}
		return true;
	}
	
	// return price of book if exist (amount>=0), or -1 if doesn't exist
	public int getBookPrice(String name) {
		int price = -1;
		BookInventoryInfo book = findBook(name);
		if (book!=null) {
			price = book.getPrice();
		}
		return price;
	}
	
	public BookInventoryInfo[] getBooksList() {
		BookInventoryInfo[] output = this.books;
		return output;
	}
	/* ---------end of functions to use in test--------- */
	
	/**
     * Initializes the store inventory. This method adds all the items given to the store
     * inventory.
     * <p>
     * @param inventory 	Data structure containing all data necessary for initialization
     * 						of the inventory.
     */
	public void load (BookInventoryInfo[ ] inventory ) {
		books = inventory;
	}
	
	/**
     * Attempts to take one book from the store.
     * <p>
     * @param book 		Name of the book to take from the store
     * @return 	an {@link Enum} with options NOT_IN_STOCK and SUCCESSFULLY_TAKEN.
     * 			The first should not change the state of the inventory while the 
     * 			second should reduce by one the number of books of the desired type.
     */
	public OrderResult take(String book) {
		OrderResult output = OrderResult.NOT_IN_STOCK;
		BookInventoryInfo currBook = findBook(book);
		if(currBook!=null) {
			synchronized (currBook) {
				if( currBook.getAmountInInventory() > 0) {
					currBook.reduceAmount();
					output = OrderResult.SUCCESSFULLY_TAKEN;
				}
			}
		}
		return output;
	}

	/**
     * Checks if a certain book is available in the inventory.
     * <p>
     * @param book 		Name of the book.
     * @return the price of the book if it is available, -1 otherwise.
     */
	public int checkAvailabiltyAndGetPrice(String book) {
		int price = -1;
		BookInventoryInfo currBook = findBook(book);
		if(currBook!=null && currBook.getAmountInInventory() > 0) {
			price = currBook.getPrice();
		}	
		return price;
	}
	
	// find book in inventory, returns null if wasn't found
	private BookInventoryInfo findBook(String name) {
		boolean found = false;
		BookInventoryInfo output = null;
		
		for (int i=0; i<books.length & !found; i++) {
			if (books[i].getBookTitle().equals(name)) {
				found = true;
				output = books[i];
			}
		}
		return output;
	}
	

	/**
     * 
     * <p>
     * Prints to a file name @filename a serialized object HashMap<String,Integer> which is a Map of all the books in the inventory. The keys of the Map (type {@link String})
     * should be the titles of the books while the values (type {@link Integer}) should be
     * their respective available amount in the inventory. 
     * This method is called by the main method in order to generate the output.
     */
	public void printInventoryToFile(String filename){
		HashMap<String,Integer> h = new HashMap<String,Integer>(books.length);            //initilazing hashmap
		
		for(BookInventoryInfo curr:books)                         //add books to hashmap
			h.put(curr.getBookTitle(), curr.getAmountInInventory());
		
		printSerializedHashMap(h,filename);                      //writing serializedHashMap to the file
	}
	
	private void printSerializedHashMap(HashMap<String,Integer> h, String filename) {
		try
        {
               FileOutputStream fos = new FileOutputStream(filename);
               ObjectOutputStream oos = new ObjectOutputStream(fos);
               oos.writeObject(h);
               oos.close();
               fos.close();
        }catch(IOException ioe) {
        	 ioe.printStackTrace();
        }
	}
}
