package dao;
import beans.*;
import java.sql.*;
import java.util.ArrayList;

public class dao {
	private Connection con;
	private PreparedStatement ps;
	private ResultSet rs;
	
	// jdbc 연동
	// Port, User , Password 확인하세요
	//String jdbcDriver = "jdbc:mariadb://localhost:TomcatPort/DB이름?useUnicode=true&characterEncoding=utf8";
	//String dbUser = "mariadb 아이디";
	//String dbPass = "mariadb 비밀번호";
	public void connect() {
		
		try {
			String jdbcDriver = "jdbc:mariadb://localhost:3308/SE?useUnicode=true&characterEncoding=utf8";
			String dbUser = "root";
			String dbPass = "root";
			//Class.forName("org.mariadb.jdbc.Driver");
			con = DriverManager.getConnection(jdbcDriver,dbUser,dbPass);	
			
		} catch(Exception e) {
			e.printStackTrace();
		} 
	}
	
	// 로그인
	// 사용자 아이디와 비밀번호를 parameter 받는다.
	// 성공시 return 1 , 비밀번호 틀릴시 return 0, 아이디틀림 return -1 , 그외 오류 -2 
	public int login(String UserID, String PW) {
		String sql = "select PW from user where UserID = ?";
		try {
			ps.setString(1, UserID);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				if(rs.getNString(1).equals(PW)){
					//성공
					return 1;
				}else
					//비밀번호 틀림
					return 0;
			}
			//re.next()가 false(select문 결과없음.)
			return -1;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2;
	}
	
	public int signup(String UserID, String PW, String Nickname) {
		String sql = "INSERT INTO user VALUES (?, ?, ?)";
		try {
			ps.setNString(1, UserID);
			ps.setNString(2, PW);
			ps.setNString(3, Nickname);

			return ps.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}return -1; // 에러
	}
}
