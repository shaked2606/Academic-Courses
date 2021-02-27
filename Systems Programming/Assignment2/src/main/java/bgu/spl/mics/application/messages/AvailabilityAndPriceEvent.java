package bgu.spl.mics.application.messages;

import bgu.spl.mics.Event;

public class AvailabilityAndPriceEvent implements Event<Integer> {
	private String bookTitle;
	
	public AvailabilityAndPriceEvent(String bookTitle) {
		this.bookTitle = bookTitle;
	}
	
	public String getBookTitle() {
		return bookTitle;
	}
}
