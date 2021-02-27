package bgu.spl.net.api.messages;

public class PmMsg extends ClientToServerMsg{
	private String reciepientUsername;
	private String content;
	
	public String getReciepientUsername() {
		return reciepientUsername;
	}
	public void setReciepientUsername(String reciepientUsername) {
		this.reciepientUsername = reciepientUsername;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}

}
