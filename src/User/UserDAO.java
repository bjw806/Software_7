package User;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
		public UserDAO() {
			try {
				String jdbcDriver = "jdbc:mariadb://localhost:3306/SE";
				String dbUser = "root";
				String dbPass = "a1234";
				conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			}	catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		public int join(User user) {
		try {
			String SQL = "INSERT INTO User(UserID, PW, Nickname) VALUES (?, ?, ?);";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPW());
			pstmt.setString(3, user.getUserNickname());
			return pstmt.executeUpdate();
		}	catch (Exception e) {
			e.printStackTrace();
		}	finally {
			try {
				pstmt.close();
				conn.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
		return -1;	// 데이터베이스 오류
	}
}
