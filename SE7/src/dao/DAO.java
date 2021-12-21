package dao;
import beans.user;
import beans.qboard;
import java.sql.*;
import java.util.ArrayList;

public class DAO {
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
		String sql = "SELECT PW FROM user WHERE UserID = ?";
		
	
		try {
			PreparedStatement ps= con.prepareStatement(sql);
			ps.setString(1, UserID);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				if(rs.getString(1).equals(PW)){
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
	
	
	//회원가입
	public int join(user user) {
		try {
			String sql = "INSERT INTO User(UserID, PW, Nickname) VALUES (?, ?, ?);";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, user.getUserID());
			ps.setString(2, user.getUserPW());
			ps.setString(3, user.getUserNickname());
			return ps.executeUpdate();
		}	catch (Exception e) {
			e.printStackTrace();
		}	finally {
			try {
				ps.close();
				con.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
		return -1;	// 에라
	}
	
	// Q&A 게시판 질문 글쓰기
	// 제목,내용,아이디(세션값)을 parameter로 받는다.
	// 성공시 insert된 query수(=1) 실패시 -1
	public int write(String Title, String Content,String UserID) {
		String sql = "INSERT INTO qboard(title, content, userid) values(?,?,?)";
		try {
			PreparedStatement ps= con.prepareStatement(sql);
			
			ps.setNString(1, Title);
			ps.setNString(2, Content);
			ps.setNString(3, UserID);
			
			return ps.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}return -1;
		
	}
	
	// Q&A 게시판 글쓰기
	// 제목,내용,아이디(세션값)을 parameter로 받는다.
	// 성공시 insert된 query수(=1) 실패시 -1
	public int AsnwerWrite(String Title, String Content,String UserID , int Qnumber) {
		String sql = "INSERT INTO ansBOARD(title, content, userid ,Qnumber) values(?,?,?,?)";
		try {
			PreparedStatement ps= con.prepareStatement(sql);
				
			ps.setNString(1, Title);
			ps.setNString(2, Content);
			ps.setNString(3, UserID);
			ps.setInt(4, Qnumber);
			
			return ps.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}return -1;
			
	}
	
	// 아이디에 따른 닉네임을 출력해주는 함수
	// UserID를 parameter로 가짐
	
	public String getNick(String UserID) {
		String sql = "SELECT Nickname FROM user WHERE UserID =?";
		try {
			PreparedStatement ps= con.prepareStatement(sql);
			ps.setString(1, UserID);
			rs = ps.executeQuery();
			
			rs.next();
			
			return rs.getNString(1);
		} catch(Exception e) {
			e.printStackTrace();
		}return null; // 에러
	}
	
	// 현재 마지막 글번호 후 숫자를 리턴해줌.
	public int getNext() {
		String sql = "SELECT Qnumber FROM qboard ORDER BY Qnumber DESC";
		try {
			PreparedStatement ps=con.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) +1;
			}
			return 1; // next가 없다면 첫번째 글이 됨.
		} catch (Exception e) {
			e.printStackTrace();
		}return -1; //에러
	}
	
	// 페이지목록 중 시작페이지(맨 앞 페이지)
		public int stratPage(int pageNumber) {
			return ((pageNumber -1 )/10) * 10 +1;
		}
	
	// 페이지목록 중 마지막페이지
		public int endPage(int pageNumber) {
			String sql ="SELECT count(Qnumber) FROM qboard";
			int totalPage;
			try {
				PreparedStatement ps=con.prepareStatement(sql);
				rs = ps.executeQuery();
				if(rs.next()) {
					totalPage= rs.getInt(1);
				} else {
					return -2; // rs.next 반환값 없음
				}
				return (totalPage-1) /10 +1;
			} catch(Exception e) {
				e.printStackTrace();
			}return -1; // 에러발생
		}
	
	// 다음페이지가 있는지 확인하는 함수
	// 있으면 true
	// 없으면 false
	public boolean nextPage(int pageNumber) {
		String sql = "select * from qboard where Qnumber < ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = ps.executeQuery();
			if(rs.next()) {
				return true;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}return false;
	}
	
	// Q&A게시판 DB정보를 가져오는 함수
	// return 값으로 고유번호, 제목, 내용, 작성자ID를 가져온다.
	public ArrayList<qboard> getQboardList(int pageNumber){
		ArrayList<qboard> qboardList = new ArrayList<qboard>();
		String sql = "SELECT * FROM qboard WHERE Qnumber < ? ORDER BY Qnumber DESC limit 10";
		
		try {
			PreparedStatement ps= con.prepareStatement(sql);
			ps.setInt(1,getNext() - (pageNumber -1) * 10);
			
			
			rs= ps.executeQuery();
			while(rs.next()) {
				qboard qboard = new qboard();
				
				qboard.setQnumber(rs.getInt(1));
				qboard.setTitle(rs.getNString(2));
				qboard.setContent(rs.getNString(3));
				qboard.setFilename(rs.getNString(4));
				qboard.setFileRealName(rs.getNString(5));
				qboard.setUserID(rs.getNString(6));
				
				qboardList.add(qboard);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		} return qboardList;
	}
	
	public qboard getQboard(int Qnumber) {
		String sql= "SELECT * FROM qboard WHERE Qnumber = ?";
		try {
			PreparedStatement ps= con.prepareStatement(sql);
			ps.setInt(1, Qnumber);
			rs= ps.executeQuery();
			if(rs.next()) {
				qboard qboard = new qboard();
				qboard.setQnumber(rs.getInt(1));
				qboard.setTitle(rs.getNString(2));
				qboard.setContent(rs.getNString(3));
				qboard.setFilename(rs.getNString(4));
				qboard.setFileRealName(rs.getNString(5));
				qboard.setUserID(rs.getNString(6));
				
				return qboard;
			}
		}catch(Exception e) {
			e.printStackTrace();
		} return null;
	}
	
	// #File(#파일,#이미지) 업로드 다운로드 부분
	
	// File 업로드
	public int uploadQNA(int Enumber, String fileName , String fileRealName) {
		String sql = "INSERT INTO estipicture(Enumber,fileName,fileRealName) VALUES (?,?,?)";
		try {
			PreparedStatement ps= con.prepareStatement(sql);
			ps.setInt(1, Enumber);
			ps.setString(2,fileName);
			ps.setString(3, fileRealName);
			
			return ps.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} return -1; // 에러
	}
	
	// 글을 쓴 후에 가장 최신의 게시판DB 인덱스를 가져오는 함수
	// 평가게시판이나 백과사전 같은 경우 필요.
	// 글을 쓰고 난 뒤 이미지 파일을 DB에 저장할 때 저장될 인덱스를 찾는 것이 목적
	// ::게시판에 맞게 변경해주세요.
	public int getQnumber(String UserID) {
		String sql= "SELECT MAX(Qnumber) FROM qboard WHERE UserID=?";
		try {
			PreparedStatement ps= con.prepareStatement(sql);
			ps.setString(1, UserID);
			rs= ps.executeQuery();
			rs.next();
			return rs.getInt(1);
		} catch(Exception e) {
			e.printStackTrace();
		} return -1; // 에러
	}
	
	// 각 이미지 경로 DB에서 진짜 이름을 가져오는 함수
	// 현재는 Estipicture 에서 가져오는 중
	public String getFileRealName(int Inumber) {
		String sql = "SELECT fileRealName FROM estipicture WHERE Inumber=?";
		try {
			PreparedStatement ps= con.prepareStatement(sql);
			ps.setInt(1, Inumber);
			rs= ps.executeQuery();
			rs.next();
			return rs.getString(1);
		} catch (Exception e) {
			e.printStackTrace();
		} return null;
	}
	
	public int getRole(String UserID) {
		String sql = "SELECT role FROM user WHERE UserID=?";
		
		try {
			PreparedStatement ps= con.prepareStatement(sql);
			ps.setString(1, UserID);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				return rs.getInt(1);
			}
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}return -1;
	}
	
		
	
}
