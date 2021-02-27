package bgu.spl.net.api.bidi;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Queue;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.CopyOnWriteArrayList;

import bgu.spl.net.api.messages.Message;

public class UsersData {
	private List<Client> clients;                    //registered clients
	private ConcurrentHashMap<String, String> usersDetails;  // <Username, password>
	private ConcurrentHashMap<String, Integer> connectedUsers; // <Username, connectionId>
	private ConcurrentHashMap<String,Queue<Message>> unreadMessages;       //<username, queue of unread messages>
	
	public UsersData() {
		this.usersDetails = new ConcurrentHashMap<>();
		this.connectedUsers = new ConcurrentHashMap<>();
		this.clients = new CopyOnWriteArrayList<>();
		this.unreadMessages = new ConcurrentHashMap<>();
	}
	
	public boolean registerClient(String username, String password) {
		if (usersDetails.putIfAbsent(username, password)==null) {   // if returns null -> the value was added
			Client toAdd = new Client(username, password);
			clients.add(toAdd);
			unreadMessages.put(username, new ConcurrentLinkedQueue<Message>());
			return true;
		}
		return false;
	}

	public boolean loginClient(String username, String password, int connectionId) {
		
			if (connectedUsers.putIfAbsent(username, connectionId)==null) {
					return true;
			}
		return false;
	}
	
	public int numOfConnected() {
		return this.connectedUsers.size();
	}

	public boolean checkLogin(String username, String password, int connectionId) {
		return isUserNameExist(username) && (passwordMatch(username, password) & (!chAlreadyConnected(connectionId)));
	}

	// returns true if there's another username that already connect through connection handler
	public boolean chAlreadyConnected(int connectionId) {
		return getUsernameByConnectionID(connectionId) != null;
	}
	
	public boolean logoutClient(int connectionId) {
		String username = getUsernameByConnectionID(connectionId);
		if(username != null) {
			connectedUsers.remove(username);
			return true;
		}
		return false;
	}

	public boolean isUserNameExist(String username) {
		return usersDetails.containsKey(username);
	}
	
	private boolean passwordMatch(String username, String password) {
		if(usersDetails.get(username) != null) {
			return (usersDetails.get(username).equals(password));
		}
		return false;
	}
	
	private String getUsernameByConnectionID(int connectionId) {
		for(Map.Entry<String, Integer> currConnection: connectedUsers.entrySet()) {
			if(currConnection.getValue() == connectionId) {
				return currConnection.getKey();
			}
		}
		return null;
	}
	
	public Integer getConnectionIDByUsername(String username) {
		return connectedUsers.get(username);
	}
	
	public boolean isConnected(String username) {
		return connectedUsers.containsKey(username);
	}
	
	public Client getClient(String username) {
		for(Client currClient:clients) {
			if(currClient.getUsername().equals(username))
				return currClient;
		}
		return null;
	}
	
	public Queue<Message> getQueueOfUnreadMessages(String username){
		return this.unreadMessages.get(username);
	}
	
	public void clearAllMessages(String username) {
		this.unreadMessages.get(username).clear();
	}
	
	public void addMessageToQueueOfUsername(String username, Message message) {
		Queue<Message> queue = this.unreadMessages.get(username);
		
			queue.add(message);
	}
	
	public List<String> getUserslist(){
		List<String> users = new LinkedList<>();
		
		for(Map.Entry<String, String> currUser:usersDetails.entrySet()) {
			users.add(currUser.getKey());
		}

		return users;
	}
}
