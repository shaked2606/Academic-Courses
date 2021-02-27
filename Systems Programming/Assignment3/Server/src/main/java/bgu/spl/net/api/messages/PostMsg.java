package bgu.spl.net.api.messages;

import java.util.LinkedList;
import java.util.List;

public class PostMsg extends ClientToServerMsg{
	private String content;
	private List<String> usersToSend;

	public PostMsg() {
		this.usersToSend = new LinkedList<>();
	}

	public List<String> getUsers() {
		return this.usersToSend;
	}

	public void setContent(String str) {
		this.content = str;
		if (content!=null) {
			extractUsersToList(); 
		}
	}

	public String getContent() {
		return this.content;
	}

	private void extractUsersToList() {
		int fromIndex = 0;
		int currIndex;

		while (content.indexOf('@', fromIndex)!=-1) {
			currIndex = content.indexOf('@', fromIndex);
			int spaceIndex = content.indexOf(' ', currIndex);

			String username = extracrtUsername(currIndex);
			if (!usersToSend.contains(username)) {
				usersToSend.add(username);
			}
			if (spaceIndex!=-1) {
				fromIndex = spaceIndex+1;
			}
			else {
				break;
			}
		}
	}

	private String extracrtUsername(int currIndex) {
		String username;
		int spaceIndex = content.indexOf(' ', currIndex);
		if (spaceIndex!=-1) {
			username = content.substring(currIndex+1, spaceIndex);
		}
		else {
			username = content.substring(currIndex+1);
		}
		return username;
	}
}
