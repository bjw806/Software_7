package dao;
import beans.*;
import java.sql.*;
import java.util.ArrayList;

public class db {
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
}
