package bgu.spl.net.api.messages;

import java.util.LinkedList;
import java.util.List;

public class FollowMsg extends ClientToServerMsg{
	private byte type;                 //Follow = 0 / Unfollow = 1
	private short usersNum;
	private List<String> usersList;
	
	public FollowMsg() {
		this.usersList = new LinkedList<>();
	}
	
	public byte getType() {
		return type;
	}

	public void setType(byte type) {
		this.type = type;
	}

	public short getUsersNum() {
		return usersNum;
	}

	public void setUsersNum(short usersNum) {
		this.usersNum = usersNum;
	}

	public List<String> getUsersList() {
		return usersList;
	}
	
	/*
	public void setUsersList(List<String> usersList) {
		this.usersList = usersList;
	}
*/
	public void addUserToList(String username) {
		usersList.add(username);
		
	}
}
