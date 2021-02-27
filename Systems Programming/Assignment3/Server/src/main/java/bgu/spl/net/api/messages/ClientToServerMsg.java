package bgu.spl.net.api.messages;


public abstract class ClientToServerMsg implements Message {
	private Message response;
	
	public Message getResponse() {
		return response;
	}

	public void setResponse(Message response) {
		this.response = response;
	}
}
