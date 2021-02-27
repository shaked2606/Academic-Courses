package bgu.spl.net.api.messages;

public class LoginMsg extends ClientToServerMsg{
	 
	private String username;
	private String password;
	
	public String getUsername() {
		return username;
	}
	
	public void setUserName(String username) {
		this.username = username;
		
	}
	
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
		
	}
}
