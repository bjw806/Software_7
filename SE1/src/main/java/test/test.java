package test;

import java.sql.*;

public class test {
	public static void main(String[] args) {
		Connection conn = null;
		Statement stmt = null;

		try {
			String jdbcDriver = "jdbc:mariadb://localhost:3306/SE";
			String dbUser = "root";
			String dbPass = "a1234";	// ���� ��й�ȣ ���ø� �˴ϴ�.
			
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			stmt = conn.createStatement();
			
			String create_table_User = "CREATE TABLE IF NOT EXISTS User("
										+ "UserID VARCHAR(20) PRIMARY KEY,"
										+ "PW VARCHAR(20),"
										+ "Nickname VARCHAR(10),"
										+ "role INT(1));";
			// ���� ���̺� (���̵�, ��й�ȣ, �г���, ����)
			
			String create_table_DicBoard = "CREATE TABLE IF NOT EXISTS DicBoard("
											+ "Dnumber INT(11) PRIMARY KEY AUTO_INCREMENT,"
											+ "Title VARCHAR(20),"
											+ "Content VARCHAR(500),"
											+ "UserID VARCHAR(20),"
											+ "FOREIGN KEY (UserID) REFERENCES User(UserID));";
											
			// ������� �Խ��� (�� ��ȣ, ����, ����, �۾���)
			// UserID�� User ���̺��� UserID���� �޾ƿͼ� ���
			// DicPicture���� ������ �޾ƿ� ��, Wnumber�� ���� ������ ã�� �� �־Ƽ� �޾ƿ�
			
			String create_table_DicPicture = "CREATE TABLE IF NOT EXISTS DicPicture("
											+ "Inumber INT(10) PRIMARY KEY AUTO_INCREMENT,"
											+ "Picture VARCHAR(20),"
											+ "Dnumber INT(11),"
											+ "FOREIGN KEY (Dnumber) REFERENCES DicBoard(Dnumber));";
											
			// ������� �Խ��� ���� (��� ��ȣ, ���� ���, �� ��ȣ)
			// ������ �ҷ��� �� Dnumber�� ���� ��ȣ�� ������ �Խ��ǿ� ����� �� �ְ� ��.
			
			String create_table_QBoard = "CREATE TABLE IF NOT EXISTS QBoard("
										+ "Qnumber INT(11) PRIMARY KEY AUTO_INCREMENT,"
										+ "Title VARCHAR(20),"
										+ "Content VARCHAR(500),"
										+ "UserID VARCHAR(20),"												
										+ "FOREIGN KEY (UserID) REFERENCES User(UserID));";
			// ���� �Խ��� (�� ��ȣ, ����, ����, �۾���)
			// UserID�� User ���̺��� UserID���� �޾ƿͼ� ���
			 
			String create_table_AnsBoard = "CREATE TABLE IF NOT EXISTS AnsBoard("
											+ "Anumber INT(11) PRIMARY KEY AUTO_INCREMENT,"
											+ "Title VARCHAR(20),"
											+ "Content VARCHAR(500),"
											+ "Qnumber INT(11),"
											+ "UserID VARCHAR(20),"	
											+ "FOREIGN KEY (Qnumber) REFERENCES QBoard(Qnumber),"											
											+ "FOREIGN KEY (UserID) REFERENCES User(UserID));";
			// �亯 �Խ��� (�� ��ȣ, ����, ����, ���� �� ����, �۾���)
			// �о�� �� ���� ��ȣ�� �޾ƿ� ����
			// UserID�� User ���̺��� UserID���� �޾ƿͼ� ���
			
			String create_table_EstiBoard = "CREATE TABLE IF NOT EXISTS EstiBoard("
										+ "Enumber INT(11) PRIMARY KEY AUTO_INCREMENT,"
										+ "Title VARCHAR(20),"
										+ "Content VARCHAR(500),"
										+ "Star INT(2),"
										+ "UserID VARCHAR(20),"	
										+ "FOREIGN KEY (UserID) REFERENCES User(UserID));";
			// �� �Խ��� (�� ��ȣ, ����, ����, ����, �۾���)
			// Star�� 10���� �����Ͽ� 1�� �������� ħ
			// UserID�� User ���̺��� UserID���� �޾ƿͼ� ���
			
			String create_table_EstiPicture = "CREATE TABLE IF NOT EXISTS EstiPicture("
												+ "Inumber INT(11) PRIMARY KEY AUTO_INCREMENT,"
												+ "Picture VARCHAR(20),"
												+ "Enumber INT(11),"
												+ "FOREIGN KEY (Enumber) REFERENCES EstiBoard(Enumber));";
			
			// �� �Խ��� ���� (��� ��ȣ, ���� ���, �� ��ȣ)
			// ������ �ҷ��� �� Enumber�� ���� ��ȣ�� ������ �Խ��ǿ� ����� �� �ְ� ��.
			
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