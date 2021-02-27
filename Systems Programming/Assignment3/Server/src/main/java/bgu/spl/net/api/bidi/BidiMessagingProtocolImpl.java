package bgu.spl.net.api.bidi;


import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

import bgu.spl.net.api.messages.*;

public class BidiMessagingProtocolImpl implements BidiMessagingProtocol<Message> {

	private boolean shouldTerminate = false;
	private Connections<Message> connections;
	private int ownerConnectionId; 
	private String username;  //current connected user
	private UsersData data;  // shared object
	
	public BidiMessagingProtocolImpl(UsersData data) {
		this.data = data;
	}

	@Override
	public void start(int connectionId, Connections<Message> connections) {
		this.connections = connections;
		this.ownerConnectionId = connectionId;
	}

	@Override
	public void process(Message message) {
		//***handling ClientToServer Messages***//
		if (message instanceof RegisterMsg) {
			RegisterMsg registerMsg = (RegisterMsg)message;
			handleRegister(registerMsg);
		}

		if (message instanceof LoginMsg) {
			LoginMsg loginMsg = (LoginMsg)message;
			handleLogin(loginMsg);
		}

		if (message instanceof LogoutMsg) {
			LogoutMsg logoutMsg = (LogoutMsg)message;
			handleLogOut(logoutMsg);
		}

		if (message instanceof FollowMsg) {
			FollowMsg followMsg = (FollowMsg)message;
			handleFollow(followMsg);
		}

		if (message instanceof PostMsg) {
			PostMsg postMsg = (PostMsg)message;
			handlePost(postMsg);
		}

		if (message instanceof PmMsg) {
			PmMsg PMMsg = (PmMsg)message;
			handlePm(PMMsg);
		}

		if (message instanceof UserlistMsg) {
			UserlistMsg userlistMsg = (UserlistMsg)message;
			handleUserlist(userlistMsg);
		}

		if (message instanceof StatMsg) {
			StatMsg statMsg = (StatMsg)message;
			handleStat(statMsg);
		}	
	}

	@Override
	public boolean shouldTerminate() {
		return shouldTerminate;
	}
	
	private void handleRegister(RegisterMsg message) {
		String username = message.getUsername();
		String password = message.getPassword();

		if((!data.chAlreadyConnected(ownerConnectionId)) && data.registerClient(username, password)) {      //registerClient checks if username is already exist
			sendACK((short)01);
		}
		else {
			sendError((short) 01);
		}
	}

	private void handleLogin(LoginMsg message) {
		String username = message.getUsername();
		String password = message.getPassword();

		if(data.checkLogin(username, password, ownerConnectionId)) {
			Client client = data.getClient(username);

			boolean loginSucceed = data.loginClient(username, password, ownerConnectionId);
			if (loginSucceed) {
				this.username = username;   //username field == connected user
				sendACK((short)02);                              
				synchronized(client) {				
					Queue<Message> unreadMessages = (Queue<Message>) data.getQueueOfUnreadMessages(username);			
					while(!unreadMessages.isEmpty()) {
						sendOwner(unreadMessages.remove());
					}      
				}
			}
			else {
				sendError((short) 02);
			}
		}
		else {
			sendError((short) 02);
		}
	}

	private void handleLogOut(LogoutMsg message) {
		Client client = data.getClient(username);
		
		if(data.logoutClient(ownerConnectionId)){
			synchronized(client) {
				this.username = null;
				this.shouldTerminate = true;
				sendACK((short) 03);
				connections.disconnect(ownerConnectionId);
			}
		}
		else {
			sendError((short) 03);
		}
	}

	private void handleFollow(FollowMsg message) {
		List<String> successfulFollow = new LinkedList<>();
		Client currClient = data.getClient(username);
		if(username!=null && data.isConnected(username)) {            //username logged in
			if (message.getType()==0) {                                 //Follow action
				for(String userToFollow: message.getUsersList()) {      //iterating on the userlist of the message and adds users to follow that has'nt already in the list
					if (data.isUserNameExist(userToFollow)) {
						if(!currClient.getFollowingList().contains(userToFollow)) {   
							followClient(currClient, userToFollow);
							successfulFollow.add(userToFollow);
						}
					}
				}
				
				if(!successfulFollow.isEmpty()) {                      //succesfully adding following
					createAckFollowMsg(successfulFollow);
				}
				else {                                                //unsuccesfully adding following
					sendError((short)04);
				}
			}

			else {                                                   //Unfollow action (type = 1)
				handleUnfollow(message, currClient);   
			}
		}
		else {                                                       //username not logged in
			sendError((short)04);
		}
	}
	
	// follow client and add this client to his followers
	private void followClient(Client currClient, String userToFollow) {
		currClient.addUserToFollow(userToFollow);
		Client clientToFollow = data.getClient(userToFollow);
		clientToFollow.addFollower(username);
	}

	private void handleUnfollow(FollowMsg message, Client client) {
		List<String> successfulUnfollow = new LinkedList<>();
		
		for(String toUnfollow: message.getUsersList()) {          //iterating on the userlist of the message and unfollow users that is in the following list
			if(client.getFollowingList().contains(toUnfollow)) {
				unfollowClient(client, toUnfollow);
				successfulUnfollow.add(toUnfollow);
			}
		}

		if(!successfulUnfollow.isEmpty()) {          //succesfully unfollowing
			createAckFollowMsg(successfulUnfollow);
		}
		else {
			sendError((short)04);                   
		}
	}
	
	// unfollow client and remove from this user from his followers
	private void unfollowClient(Client client, String toUnfollow) {
		client.unfollow(toUnfollow);
		Client other = data.getClient(toUnfollow);
		other.removeFollower(client.getUsername());
	}
	
	private void createAckFollowMsg(List<String> successful) {
		ACKFollowMsg response = new ACKFollowMsg();
		response.setNumOfUsers((short)successful.size());
		response.setUsersList(successful);
		sendOwner((Message) response);
	}


	private void handlePost(PostMsg message) {
		if(username != null && data.isConnected(username)) {                                     //checks if user logged in
			sendACK((short) 05); 
			NotificationMsg notifMsg = new NotificationMsg((short)9,(char)1,username,message.getContent());
			Client currClient = data.getClient(username);
			currClient.increaseNumOfPosts();               //for STAT action

			HashSet<String> usersToSend = mergeTaggedAndFollowers(currClient, message);
			for (String user: usersToSend) {
				sendNotifToUser(notifMsg, user);
			}
		}

		else {   //   user isn't logged in
			sendError((short)05);
		}
	}
	
	
	private HashSet<String> mergeTaggedAndFollowers(Client client, PostMsg msg) {
		HashSet<String> toSendNotif = new HashSet<>();
		toSendNotif.addAll(client.getFollowersList());   // followers
		toSendNotif.addAll(msg.getUsers()); 			// tagged users
		return toSendNotif;
	}
	

	// if user is connected - send immediately, otherwise - add to his queue
	private void sendNotifToUser(NotificationMsg notifMsg, String username) {
		Client client = data.getClient(username);
		Integer id = data.getConnectionIDByUsername(username);
		synchronized(client) {
			if(data.isConnected(username)) {
				connections.send(id, (Message)notifMsg); 
			}
			else {
				data.addMessageToQueueOfUsername(username, notifMsg);      
			}
		}
	}
	
	private void handlePm(PmMsg message) {
		String reciepientUsername = message.getReciepientUsername();
		NotificationMsg notifMsg = new NotificationMsg((short)9,(char)0, username, message.getContent());
		
		if(username != null && (data.isConnected(username) & data.isUserNameExist(reciepientUsername))) {  
			sendNotifToUser(notifMsg, reciepientUsername);
			sendACK((short) 06);
		}

		else {     
			sendError((short) 06);
		}
	}

	private void handleUserlist(UserlistMsg message) {
		AckUserlistMsg userlistMsg = createAckUserlistMsg();
		
		if(username != null && data.isConnected(username)) {         
			sendOwner((Message) userlistMsg);
		}
		
		else {      //   user isn't logged in
			sendError((short) 07);
		}
	}

	private AckUserlistMsg createAckUserlistMsg() {
		List<String> usersList = data.getUserslist();
		AckUserlistMsg userlistMsg = new AckUserlistMsg();
		userlistMsg.setNumUsers((short)usersList.size());
		userlistMsg.setUsersList(usersList);
		return userlistMsg;
	}

	private void handleStat(StatMsg message) {
		String statUsername = message.getUsername();
		if(username != null && data.isConnected(username)) {
			if(data.isUserNameExist(statUsername)){
				
				AckStatMsg ackStatMsg = createStatMsg(statUsername);
				sendOwner((Message) ackStatMsg);
			}
			else {    //username not registered so we can't send statistics about him
				sendError((short) 8);
			}
		}
	
		else {   //   user isn't logged in
			sendError((short) 8);
		}
	}

	private AckStatMsg createStatMsg(String statUsername) {
		Client statClient = data.getClient(statUsername);
		AckStatMsg ackStatMsg = new AckStatMsg();
		ackStatMsg.setNumFollowers(statClient.getFollowersNum());
		ackStatMsg.setNumFollowing(statClient.getFollowingNum());
		ackStatMsg.setNumPosts(statClient.getNumOfPosts());
		return ackStatMsg;
	}
	
	
	private void sendOwner(Message msg) {
		connections.send(ownerConnectionId, msg);
	}
	
	private void sendACK(short num) {
		sendOwner((Message)new ACKMsg(num));
	}
	
	private void sendError(short num) {
		sendOwner((Message)new ErrorMsg(num));
	}
	

}
