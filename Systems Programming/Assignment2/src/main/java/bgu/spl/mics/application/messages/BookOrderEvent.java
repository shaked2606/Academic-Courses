package bgu.spl.mics.application.messages;

import bgu.spl.mics.Event;
import bgu.spl.mics.application.passiveObjects.*;

public class BookOrderEvent implements Event<OrderReceipt>{

    private String bookTitle;
    private Customer customer;
    private int orderTick;
    
    public BookOrderEvent(String bookTitle, Customer customer,int orderTick) {
        this.bookTitle = bookTitle;
        this.customer = customer;
        this.orderTick=orderTick;
    }

    public String getBookTitle() {
        return bookTitle;
    }
    
    public Customer getCustomer() {
    	return customer;
    }
    
    public int getOrderTick() {
    	return this.orderTick;
    }
}
