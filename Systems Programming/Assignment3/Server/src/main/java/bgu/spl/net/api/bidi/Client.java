package bgu.spl.net.api.bidi;

import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

public class Client {
	private String username;
	private String password;
	private List<String> following;
	private List<String> followers;
	private short numOfPosts;
	
	public Client(String username, String password) {
		this.username = username;
		this.password = password;
		this.following = new CopyOnWriteArrayList<>();     //thread safe list
		this.followers = new CopyOnWriteArrayList<>();    //thread safe list
		this.numOfPosts = 0;
	}
	
	public String getUsername() {
		return username;
	}
	
	public String getPassword() {
		return password;
	}
	
	public void addFollower(String username) {
		followers.add(username);
	}
	
	public void addUserToFollow(String username) {
		following.add(username);
	}
	
	public void unfollow(String username) {
		following.remove(username);
	}
	
	public void removeFollower(String username) {
		followers.remove(username);
	}
	
	public List<String> getFollowingList(){
		return this.following;
	}
	
	public short getFollowingNum(){
		return (short)following.size();
	}
	
	public List<String> getFollowersList(){
		return this.followers;
	}
	
	public short getFollowersNum(){
		return (short)followers.size();
	}
	
	public short getNumOfPosts() {
		return numOfPosts;
	}

	public void increaseNumOfPosts() {
		this.numOfPosts++;
	}
	
}
