package User;

public class User {
	private String userID;
	private String userPW;
	private String userNickname;
	private int userRole;
	
	public String getUserID() {
		return userID;
	}
	public String getUserPW() {
		return userPW;
	}
	public String getUserNickname() {
		return userNickname;
	}
	public int getUserrole() {
		return userRole;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public void setUserPW(String userPW) {
		this.userPW = userPW;
	}
	public void setUserNickname(String userNickname) {
		this.userNickname = userNickname;
	}
	public void setUserrole(int userRole) {
		this.userRole = userRole;
	}
	
}