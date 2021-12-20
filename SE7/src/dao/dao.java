package dao;
import beans.*;
import java.sql.*;
import java.util.ArrayList;

public class dao {
	private Connection con;
	private PreparedStatement ps;
	private ResultSet rs;
	
	
	// 로그인
	// 사용자 아이디와 비밀번호를 parameter 받는다.
	// 성공시 return 1 , 비밀번호 틀릴시 return 0, 아이디틀림 return -1 , 그외 오류 -2 
	public int login(user user) {
		String sql = "select PW from user where UserID = ?";
		try {
			ps.setString(1, user.getUserID());
			rs = ps.executeQuery();
			
			while(rs.next()) {
				if(rs.getNString(1).equals(user.getPW())){
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
	
	
	
	
}
