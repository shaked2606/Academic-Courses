package bgu.spl.net.api.messages;

import java.util.List;

public class ACKFollowMsg extends ACKMsg{
	private short numOfUsers;
	private List<String> usersList;
	
	public ACKFollowMsg() {
		super((short)04);
	}

	public short getNumOfUsers() {
		return numOfUsers;
	}

	public void setNumOfUsers(short numOfUsers) {
		this.numOfUsers = numOfUsers;
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
