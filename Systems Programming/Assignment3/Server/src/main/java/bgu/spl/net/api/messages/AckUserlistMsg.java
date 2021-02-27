package bgu.spl.net.api.messages;

import java.util.List;

public class AckUserlistMsg extends ACKMsg {
	private short numUsers;
	private List<String> usersList;
	
	public AckUserlistMsg() {
		super((short)07);
	}

	public short getNumUsers() {
		return numUsers;
	}

	public void setNumUsers(short numUsers) {
		this.numUsers = numUsers;
	}

	public List<String> getUsersList() {
		return usersList;
	}
	
	public String getUsersListAsString() {
		String output = "";
		for (String curr: usersList) {
			output += curr + '\0';
		}
		
		return output;
	}

	public void setUsersList(List<String> usersList) {
		this.usersList = usersList;
	}
}
