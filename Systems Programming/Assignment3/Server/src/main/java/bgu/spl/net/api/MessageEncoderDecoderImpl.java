package bgu.spl.net.api;

import java.nio.charset.StandardCharsets;
import java.util.Arrays;

import bgu.spl.net.api.messages.*;

public class MessageEncoderDecoderImpl implements MessageEncoderDecoder<Message> {

	private byte[] shortBytes = new byte[2];
	private short opcode;

	private byte[] bytes = new byte[2];
	private int len;

	private Message tmpMessage;
	private Message msgToReturn;
	
	private int bytesCounter;
	private int zerosCounter;

	public MessageEncoderDecoderImpl() {
		this.bytesCounter = 0;
		this.len = 0;
	}

	@Override
	public Message decodeNextByte(byte nextByte) {
		msgToReturn = null;
		
		// reading opcode
		if (bytesCounter==0) {
			shortBytes[bytesCounter] = nextByte;
			bytesCounter++;
		}
		else if (bytesCounter==1) {

			shortBytes[bytesCounter] = nextByte;
			bytesCounter++; 

			opcode = bytesToShort(shortBytes);
			
			createMsgInstance();
		}
		else {
			decodeMessageData(nextByte);
		}
		
		return msgToReturn;
	}

	// creates message instance according to opcode
	private void createMsgInstance() {
		switch (opcode) {

		case 1: tmpMessage = new RegisterMsg();
		break;

		case 2: tmpMessage = new LoginMsg();
		break;

		case 3: tmpMessage = new LogoutMsg();
		completeAndReset();
		break;
		
		case 4: tmpMessage = new FollowMsg();
		break;

		case 5: tmpMessage = new PostMsg();
		break;

		case 6: tmpMessage = new PmMsg();
		break;

		case 7: tmpMessage = new UserlistMsg();
		completeAndReset();
		break;
		
		case 8: tmpMessage = new StatMsg();
		break;
		}
	}

	
	private void decodeMessageData(byte nextByte) {
		switch (opcode) {
		case 1: 
			handleRegister(nextByte);
			break;

		case 2:
			handleLogin(nextByte);
			break;

		case 4:
			handleFollow(nextByte);
			break;

		case 5: 
			handlePost(nextByte);
			break;

		case 6:
			handlePM(nextByte);
			break;

		case 8:
			handleStat(nextByte);
			break;
		}
	}

	// Register message
	private void handleRegister(byte nextByte) {
		//username
		if (zerosCounter==0) {
			String username = extractString(nextByte);
			
			if(username!=null) {
				((RegisterMsg)tmpMessage).setUserName(username);
				zerosCounter++;
			}
		}
		//password
		else if (zerosCounter==1) {
			String password = extractString(nextByte);

			if(password!=null) {
				((RegisterMsg)tmpMessage).setPassword(password);
				zerosCounter++;
				completeAndReset();
			}
		}
	}

	// Login message
	private void handleLogin(byte nextByte) {
		//username
		if (zerosCounter==0) {
			String username = extractString(nextByte);

			if(username!=null) {
				((LoginMsg)tmpMessage).setUserName(username);

				zerosCounter++;
			}
		}
		//password
		else if (zerosCounter==1) {
			String password = extractString(nextByte);

			if(password!=null) {
				((LoginMsg)tmpMessage).setPassword(password);
				zerosCounter++;
				completeAndReset();
			}
		}
	}


	// follow/unfollow message
	private void handleFollow(byte nextByte) {
		if (bytesCounter<5) {
			switch (bytesCounter) {
			
			// type - follow/unfollow
			case 2:	((FollowMsg)tmpMessage).setType(nextByte);
			bytesCounter++;
			break;
			
			// 3&4 - num of users
			case 3: shortBytes[0] = nextByte;
			bytesCounter++;
			break;

			case 4: shortBytes[1] = nextByte;
			short usersNum = bytesToShort(shortBytes);

			((FollowMsg)tmpMessage).setUsersNum(usersNum);

			bytesCounter++;
			len=0;
			break;
			}
		}
		// users to follow/unfollow
		else {
			short usersNum = ((FollowMsg)tmpMessage).getUsersNum();
			String username = extractString(nextByte);
			if(username!=null) {
				((FollowMsg)tmpMessage).addUserToList(username);
				zerosCounter++;

				if (zerosCounter==usersNum) {
					completeAndReset();
		
				}
			}
		}
	}


	// post message
	private void handlePost(byte nextByte) {
		if (nextByte!=0) {
			pushByte(nextByte);
		}
		else {
			String content = popString();
			((PostMsg)tmpMessage).setContent(content);
			completeAndReset();
		}
	}
	
	// PM message
	private void handlePM(byte nextByte) {
		// username
		if (zerosCounter==0) {
			String reciepientUsername = extractString(nextByte);
			if (reciepientUsername!=null) {
				((PmMsg)tmpMessage).setReciepientUsername(reciepientUsername);
				zerosCounter++;
			}
		}
		
		// content of message
		else if (zerosCounter==1) {
			String content = extractString(nextByte);
			if (content!=null) {
				((PmMsg)tmpMessage).setContent(content);
				completeAndReset();
			}
		}
	}
	
	// Stat message
	private void handleStat(byte nextByte) {
		//username
		String username = extractString(nextByte);
		if (username!=null) {
			((StatMsg)tmpMessage).setUsername(username);
		
			completeAndReset();
		}
	}

	private String popString() {
		String result = new String(bytes, 0, len, StandardCharsets.UTF_8);
		len = 0;
		return result;
	}

	private void completeAndReset() {
		msgToReturn = tmpMessage;
		this.tmpMessage = null;
		this.bytesCounter = 0;
		this.zerosCounter = 0;
		this.len = 0;
	}

	private String extractString(byte nextByte) {
		String output = null;
		if (nextByte!='\0') {
			pushByte(nextByte);
		}
		else {
			output = popString();
		}
		return output;
	}
	
	private short bytesToShort(byte[] byteArr) {
		short result = (short)((byteArr[0] & 0xff) << 8);
		result += (short)(byteArr[1] & 0xff);
		return result;
	}


	@Override
	public byte[] encode(Message message) {
		this.opcode  = ((ServerToClientMsg)message).getOpcode();
		encodeOpcode(opcode);
		short msgOpcode;

		switch (opcode) {
		case 9:    // Notification Message 
			handleNotificationMsg(message);
			break;

		case 10:    // Ack Message
			handleAckMsg(message);
			break;

		case 11:       // Error Message
			msgOpcode =((ErrorMsg)message).getMsgOpcode();
			encodeOpcode(msgOpcode);

			break;
		}
		
		byte[] output = Arrays.copyOf(bytes, len);
		resetAfterEncode();
		
		return output;
	}


	private void resetAfterEncode() {
		this.len = 0;
		bytes = new byte[2];
	}

	private void handleNotificationMsg(Message message) {
		NotificationMsg notification = (NotificationMsg)message;
		String type = Character.toString(notification.getType());
		pushString(type);
		pushString(notification.getPostingUser());
		pushByte((byte)'\0');
		pushString(notification.getContent());
		pushByte((byte)'\0');
	}


	private void handleAckMsg(Message message) {
		short msgOpcode =((ACKMsg)message).getMsgOpcode();
		encodeOpcode(msgOpcode);
	
		switch (msgOpcode) {
		case 4:     // Ack of Follow Message
			ACKFollowMsg follow = (ACKFollowMsg)message;
			pushShort(follow.getNumOfUsers());	
			pushBytes(follow.getUsersListAsString().getBytes());  // includes the terminate zero
			break;

		case 7:	    // Ack of userlist Message
			AckUserlistMsg userlist =  (AckUserlistMsg)message;
			pushShort(userlist.getNumUsers());
			pushBytes(userlist.getUsersListAsString().getBytes());
			break;

		case 8:    // Ack of Stat Message
			AckStatMsg stat = (AckStatMsg)message;
			pushShort(stat.getNumPosts());
			pushShort(stat.getNumFollowers());
			pushShort(stat.getNumFollowing());
			break;
		}
	}

	private void encodeOpcode(short opcode) {
		pushBytes(shortToBytes(opcode));
	}

	private void pushShort(short num) {
		pushBytes(shortToBytes(num));
	}

	private void pushString(String str) {
		pushBytes(str.getBytes());  //uses utf8 by default
	}

	private void pushBytes(byte[] bytesToInsert) {
		for (byte curr: bytesToInsert) {
			pushByte(curr);
		}
	}

	private void pushByte(byte nextByte) {
		if (len >= bytes.length) {
			bytes = Arrays.copyOf(bytes, len * 2);
		}

		bytes[len++] = nextByte;
	}

	private byte[] shortToBytes(short num)
	{
		byte[] bytesArr = new byte[2];
		bytesArr[0] = (byte)((num >> 8) & 0xFF);
		bytesArr[1] = (byte)(num & 0xFF);
		
		return bytesArr;
	}

}
