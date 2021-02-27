package bgu.spl.mics.application.messages;

import bgu.spl.mics.Event;
import bgu.spl.mics.application.passiveObjects.OrderResult;

public class TakeEvent implements Event<OrderResult> {
	private String bookTitle;
	
	public TakeEvent(String bookTitle) {
		this.bookTitle = bookTitle;
	}
	
	public String getBookTitle() {
		return bookTitle;
	}
}
