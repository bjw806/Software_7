package test;

import java.sql.*;

public class test {
	public static void main(String[] args) {
		Connection conn = null;
		Statement stmt = null;

		try {
			String jdbcDriver = "jdbc:mariadb://localhost:3306/SE";
			String dbUser = "root";
			String dbPass = "a1234";	// 각자 비밀번호 쓰시면 됩니다.
			
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			stmt = conn.createStatement();
			
			String create_table_User = "CREATE TABLE IF NOT EXISTS User("
										+ "UserID VARCHAR(20) PRIMARY KEY,"
										+ "PW VARCHAR(20),"
										+ "Nickname VARCHAR(10),"
										+ "role INT(1));";
			// 계정 테이블 (아이디, 비밀번호, 닉네임, 권한)
			
			String create_table_DicBoard = "CREATE TABLE IF NOT EXISTS DicBoard("
											+ "Dnumber INT(11) PRIMARY KEY AUTO_INCREMENT,"
											+ "Title VARCHAR(20),"
											+ "Content VARCHAR(500),"
											+ "UserID VARCHAR(20),"
											+ "FOREIGN KEY (UserID) REFERENCES User(UserID));";
											
			// 백과사전 게시판 (글 번호, 제목, 내용, 글쓴이)
			// UserID를 User 테이블의 UserID에서 받아와서 사용
			// DicPicture에서 사진을 받아올 때, Wnumber가 같은 사진을 찾을 수 있아서 받아옴
			
			String create_table_DicPicture = "CREATE TABLE IF NOT EXISTS DicPicture("
											+ "Inumber INT(10) PRIMARY KEY AUTO_INCREMENT,"
											+ "Picture VARCHAR(20),"
											+ "Dnumber INT(11),"
											+ "FOREIGN KEY (Dnumber) REFERENCES DicBoard(Dnumber));";
											
			// 백과사전 게시판 사진 (목록 번호, 사진 경로, 글 번호)
			// 사진을 불러올 때 Dnumber가 같은 번호를 가져와 게시판에 출력할 수 있게 함.
			
			String create_table_QBoard = "CREATE TABLE IF NOT EXISTS QBoard("
										+ "Qnumber INT(11) PRIMARY KEY AUTO_INCREMENT,"
										+ "Title VARCHAR(20),"
										+ "Content VARCHAR(500),"
										+ "UserID VARCHAR(20),"												
										+ "FOREIGN KEY (UserID) REFERENCES User(UserID));";
			// 질문 게시판 (글 번호, 제목, 내용, 글쓴이)
			// UserID를 User 테이블의 UserID에서 받아와서 사용
			 
			String create_table_AnsBoard = "CREATE TABLE IF NOT EXISTS AnsBoard("
											+ "Anumber INT(11) PRIMARY KEY AUTO_INCREMENT,"
											+ "Title VARCHAR(20),"
											+ "Content VARCHAR(500),"
											+ "Qnumber INT(11),"
											+ "UserID VARCHAR(20),"	
											+ "FOREIGN KEY (Qnumber) REFERENCES QBoard(Qnumber),"											
											+ "FOREIGN KEY (UserID) REFERENCES User(UserID));";
			// 답변 게시판 (글 번호, 제목, 내용, 질문 글 연결, 글쓴이)
			// 읽어올 때 질문 번호를 받아와 연결
			// UserID를 User 테이블의 UserID에서 받아와서 사용
			
			String create_table_EstiBoard = "CREATE TABLE IF NOT EXISTS EstiBoard("
										+ "Enumber INT(11) PRIMARY KEY AUTO_INCREMENT,"
										+ "Title VARCHAR(20),"
										+ "Content VARCHAR(500),"
										+ "Star INT(2),"
										+ "UserID VARCHAR(20),"	
										+ "FOREIGN KEY (UserID) REFERENCES User(UserID));";
			// 평가 게시판 (글 번호, 제목, 내용, 별점, 글쓴이)
			// Star를 10으로 제한하여 1을 반점으로 침
			// UserID를 User 테이블의 UserID에서 받아와서 사용
			
			String create_table_EstiPicture = "CREATE TABLE IF NOT EXISTS EstiPicture("
												+ "Inumber INT(11) PRIMARY KEY AUTO_INCREMENT,"
												+ "Picture VARCHAR(20),"
												+ "Enumber INT(11),"
												+ "FOREIGN KEY (Enumber) REFERENCES EstiBoard(Enumber));";
			
			// 평가 게시판 사진 (목록 번호, 사진 경로, 글 번호)
			// 사진을 불러올 때 Enumber가 같은 번호를 가져와 게시판에 출력할 수 있게 함.
			
			stmt.executeUpdate(create_table_User);
			stmt.executeUpdate(create_table_DicBoard);
			stmt.executeUpdate(create_table_DicPicture);
			stmt.executeUpdate(create_table_QBoard);
			stmt.executeUpdate(create_table_AnsBoard);
			stmt.executeUpdate(create_table_EstiBoard);
			stmt.executeUpdate(create_table_EstiPicture);
			
			
			System.out.println("Sucess create Table");
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try{
				stmt.close();
				conn.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}
}