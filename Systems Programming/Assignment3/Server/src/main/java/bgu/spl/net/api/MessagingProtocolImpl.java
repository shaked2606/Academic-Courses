package bgu.spl.net.api;

public class MessagingProtocolImpl<T> implements MessagingProtocol<T>{
	private boolean shouldTerminate = false;
	
	@Override
	public T process(T msg) {
		
		return null;
	}

	@Override
	public boolean shouldTerminate() {
		return shouldTerminate;
	}

}
