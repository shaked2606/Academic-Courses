package bgu.spl.mics.application.passiveObjects;


//This class represents Order of customer
public class Order {

	private String bookTitle;
	private int tick;
	
	public Order(String bookTitle,int tick) {
		this.bookTitle = bookTitle;
		this.tick = tick;
	}
	
	//Function returns book title or order
	public String getBookTitle() {
		return this.bookTitle;
	}
	
	//Function returns tick of order
	public int getTick() {
		return this.tick;
	}
}
