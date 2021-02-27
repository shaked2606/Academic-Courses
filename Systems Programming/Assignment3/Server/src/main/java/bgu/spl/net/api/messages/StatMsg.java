package bgu.spl.net.api.messages;

public class StatMsg extends ClientToServerMsg{
	private String username;

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	
}
