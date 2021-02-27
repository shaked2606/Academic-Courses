package bgu.spl.net.api.messages;

public class AckStatMsg extends ACKMsg {
	private short numPosts;
	private short numFollowers;
	private short numFollowing;
	
	public AckStatMsg() {
		super((short)8);
	}
	
	public short getNumPosts() {
		return numPosts;
	}

	public void setNumPosts(short numPosts) {
		this.numPosts = numPosts;
	}

	public short getNumFollowers() {
		return numFollowers;
	}

	public void setNumFollowers(short numFollowers) {
		this.numFollowers = numFollowers;
	}

	public short getNumFollowing() {
		return numFollowing;
	}

	public void setNumFollowing(short numFollowing) {
		this.numFollowing = numFollowing;
	}
	
}
