package bgu.spl.mics.application.passiveObjects;

import static org.junit.Assert.*;

import org.junit.After;
import org.junit.BeforeClass;
import org.junit.Test;

public class InventoryTest {
	private static Inventory out;
	
	
	@BeforeClass 
	public static void setUp() throws Exception {
		out = Inventory.getInstance();		
	}

	@After
	public void tearDown() throws Exception {
		BookInventoryInfo[] toLoad = {};  
		out.load(toLoad);
	}

	@Test
	public void testGetInstance() {
		assertTrue(out!=null);               // expected to create instance
		assertEquals((Object)out, Inventory.getInstance());  // compare pointers - expected to be same pointer
	}
	
	// help function to init inventory
	public BookInventoryInfo[] setUpLoad() {
		BookInventoryInfo book1 = new BookInventoryInfo("a", 5, 10); 
		BookInventoryInfo book2 = new BookInventoryInfo("b", 0, 20);
		
		BookInventoryInfo[] toLoad2 = {book1, book2};
		out.load(toLoad2);
		return toLoad2;
	}

	@Test
	public void testLoad() {
		// inventory expected to be empty
		assertArrayEquals(new BookInventoryInfo[0], out.getBooksList());
		
		// after loading - inventory expected to contain the books
		BookInventoryInfo[] books = setUpLoad();
		assertArrayEquals(books, out.getBooksList());
	}
	
	@Test
	public void testTake() {
		//if there is no books at the inventory at all (inventoryArray = {})
		assertEquals(OrderResult.NOT_IN_STOCK, out.take("b")); 
		
		setUpLoad();
		
		// if book is in inventory (with amount>0)
		assertEquals(OrderResult.SUCCESSFULLY_TAKEN, out.take("a"));
		assertEquals(4, out.getAmount("a"));
		
		// if book is in inventory (with amount=0)
		assertEquals(OrderResult.NOT_IN_STOCK, out.take("b"));
		assertEquals(0, out.getAmount("b"));
		
		// if book isn't in inventory at all
		assertEquals(OrderResult.NOT_IN_STOCK, out.take("c"));
	}

	@Test
	public void testCheckAvailabiltyAndGetPrice() {  
		setUpLoad();

		// if book is in inventory (with amount>0)
		assertEquals(10, out.checkAvailabiltyAndGetPrice("a"));
		assertTrue(out.isExistInInventory("a"));  // checks that method didn't change anything
		assertEquals(10, out.getBookPrice("a"));
		
		
		// if book is in inventory (with amount=0)
		assertEquals(-1, out.checkAvailabiltyAndGetPrice("b"));
		assertTrue(out.isExistInInventory("b"));  // checks that method didn't change anything
		assertEquals(20, out.getBookPrice("b"));

		// if book isn't in inventory at all
		assertEquals(-1, out.checkAvailabiltyAndGetPrice("c"));
		assertFalse(out.isExistInInventory("c"));  // checks that method didn't change anything
		assertEquals(-1, out.getBookPrice("c"));
	}
}