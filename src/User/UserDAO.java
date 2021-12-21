package User;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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
		
		// 로그인
		// 사용자 아이디와 비밀번호를 parameter 받는다.
		// 성공시 return 1 , 비밀번호 틀릴시 return 0, 아이디틀림 return -1 , 그외 오류 -2 
		public int login(String UserID, String PW) {
			String sql = "SELECT PW FROM user WHERE UserID = ?";
			
		
			try {
				PreparedStatement ps= conn.prepareStatement(sql);
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
			} catch(Exception e) {
				e.printStackTrace();
			} 
			return -2;
		}
		
		// --------------------------------------------------------
		
		// 제목,내용,아이디(세션값)을 parameter로 받는다.
		// 성공시 insert된 query수(=1) 실패시 -1
		public int write(String Title, String Content,String UserID) {
			String sql = "INSERT INTO qboard(title, content, userid) values(?,?,?)";
			try {
				PreparedStatement ps= conn.prepareStatement(sql);
				
				ps.setNString(1, Title);
				ps.setNString(2, Content);
				ps.setNString(3, UserID);
				
				return ps.executeUpdate();
			} catch(Exception e) {
				e.printStackTrace();
			} return -1;
		}
		
		// 아이디에 따른 닉네임을 출력해주는 함수
		// UserID를 parameter로 가짐
		
		public String getNick(String UserID) {
			String sql = "SELECT Nickname FROM user WHERE UserID =?";
			try {
				PreparedStatement ps= conn.prepareStatement(sql);
				ps.setString(1, UserID);
				rs = ps.executeQuery();
				
				rs.next();
				
				return rs.getNString(1);
			} catch(Exception e) {
				e.printStackTrace();
			} return null; // 에러
		}
		
		public int getStar(String UserID) {
			String sql = "SELECT Star FROM estiboard WHERE UserID = ?";
			try {
				PreparedStatement ps= conn.prepareStatement(sql);
				ps.setString(1, UserID);
				rs = ps.executeQuery();
				
				rs.next();
				
				return rs.getInt("Star");
			} catch(Exception e) {
				e.printStackTrace();
			} return 0; // 에러
		}
		public int writesboard(String Title, String Content, String Star,String UserID) {
			String sql = "INSERT INTO dicboard(title, content, Star, userid) values(?,?,?,?)";
			try {
				PreparedStatement ps= conn.prepareStatement(sql);
				
				ps.setNString(1, Title);
				ps.setNString(2, Content);
				ps.setNString(3, Star);
				ps.setNString(4, UserID);
				
				return ps.executeUpdate();
			} catch(Exception e) {
				e.printStackTrace();
			} return -1;
		}
		
		public int dbwrite(String Title, String Content,String UserID) {
			String sql = "INSERT INTO dicboard(title, content, userid) values(?,?,?)";
			try {
				PreparedStatement ps= conn.prepareStatement(sql);
				
				ps.setNString(1, Title);
				ps.setNString(2, Content);
				ps.setNString(3, UserID);
				
				return ps.executeUpdate();
			} catch(Exception e) {
				e.printStackTrace();
			} return -1;
		}
		
		// --------------------------------------------------------
		// Q&A 게시판 글쓰기
		// 현재 마지막 글번호 후 숫자를 리턴해줌.
		public int getNext() {
			String sql = "SELECT Qnumber FROM qboard ORDER BY Qnumber DESC";
			try {
				PreparedStatement ps=conn.prepareStatement(sql);
				rs = ps.executeQuery();
				if(rs.next()) {
					return rs.getInt(1) +1;
				}
				return 1; // next가 없다면 첫번째 글이 됨.
			} catch (Exception e) {
				e.printStackTrace();
			} return -1; //에러
		}
		
		public int getNexte() {
			String sql = "SELECT Enumber FROM estiboard ORDER BY Enumber DESC";
			try {
				PreparedStatement ps=conn.prepareStatement(sql);
				rs = ps.executeQuery();
				if(rs.next()) {
					return rs.getInt(1) +1;
				}
				return 1; // next가 없다면 첫번째 글이 됨.
			} catch (Exception e) {
				e.printStackTrace();
			} return -1; //에러
		}
		
		public int getNextd() {
			String sql = "SELECT Dnumber FROM dicboard ORDER BY Dnumber DESC";
			try {
				PreparedStatement ps=conn.prepareStatement(sql);
				rs = ps.executeQuery();
				if(rs.next()) {
					return rs.getInt(1) +1;
				}
				return 1; // next가 없다면 첫번째 글이 됨.
			} catch (Exception e) {
				e.printStackTrace();
			} return -1; //에러
		}
		
		// 다음페이지가 있는지 확인하는 함수
		// 있으면 true
		// 없으면 false
		public boolean nextPage(int pageNumber) {
			String sql = "select * from qboard where Qnumber < ?";
			try {
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setInt(1, getNext() - (pageNumber - 1) * 10);
				rs = ps.executeQuery();
				if(rs.next()) {
					return true;
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
			return false;
		}
		
		// Q&A게시판 DB정보를 가져오는 함수
		// return 값으로 고유번호, 제목, 내용, 작성자ID를 가져온다.
		public ArrayList<qboard> getQboardList(int pageNumber){
			ArrayList<qboard> qboardList = new ArrayList<qboard>();
			String sql = "SELECT * FROM qboard WHERE Qnumber < ? ORDER BY Qnumber DESC limit 10";
			
			try {
				PreparedStatement ps= conn.prepareStatement(sql);
				ps.setInt(1,getNext() - (pageNumber -1) * 10);
				
				rs= ps.executeQuery();
				while(rs.next()) {
					qboard qboard = new qboard();
					
					qboard.setQnumber(rs.getInt(1));
					qboard.setTitle(rs.getNString(2));
					qboard.setContent(rs.getNString(3));
					qboard.setUserID(rs.getNString(4));
					
					qboardList.add(qboard);
				}
			}catch(Exception e) {
				e.printStackTrace();
			} return qboardList;
		}
		
		public qboard getQboard(int Qnumber) {
			String sql= "SELECT * FROM qboard WHERE Qnumber = ?";
			try {
				PreparedStatement ps= conn.prepareStatement(sql);
				ps.setInt(1, Qnumber);
				rs= ps.executeQuery();
				if(rs.next()) {
					qboard qboard = new qboard();
					qboard.setQnumber(rs.getInt(1));
					qboard.setTitle(rs.getNString(2));
					qboard.setContent(rs.getNString(3));
					qboard.setUserID(rs.getNString(4));
					
					return qboard;
				}
			}catch(Exception e) {
				e.printStackTrace();
			} 
			return null;
		}
		
		// --------------------------------------------------------
				
		// Q&A게시판 DB정보를 가져오는 함수
		// return 값으로 고유번호, 제목, 내용, 작성자ID를 가져온다.
		public ArrayList<scoreboard> getSboardList(int pageNumber){
			ArrayList<scoreboard> sboardList = new ArrayList<scoreboard>();
			String sql = "SELECT * FROM estiboard WHERE Enumber < ? ORDER BY Enumber DESC limit 10";
			
			try {
				PreparedStatement ps= conn.prepareStatement(sql);
				ps.setInt(1,getNexte() - (pageNumber -1) * 10);
				
					
				rs= ps.executeQuery();
				while(rs.next()) {
					scoreboard scoreboard = new scoreboard();
					
					scoreboard.setEnumber(rs.getInt(1));
					scoreboard.setTitle(rs.getNString(2));
					scoreboard.setContent(rs.getNString(3));
					scoreboard.setStar(rs.getInt(4));
					scoreboard.setUserID(rs.getNString(5));
					
					sboardList.add(scoreboard);
					}
				}catch(Exception e) {
					e.printStackTrace();
				} return sboardList;
			}
				
			public scoreboard getSboard(int Enumber) {
				String sql= "SELECT * FROM estiboard WHERE Enumber = ?";
				try {
					PreparedStatement ps= conn.prepareStatement(sql);
					ps.setInt(1, Enumber);
					rs= ps.executeQuery();
					if(rs.next()) {
						scoreboard sboard = new scoreboard();
						sboard.setEnumber(rs.getInt(1));
						sboard.setTitle(rs.getNString(2));
						sboard.setContent(rs.getNString(3));
						sboard.setStar(rs.getInt(4));
						sboard.setUserID(rs.getNString(5));
						
						return sboard;
					}
				}catch(Exception e) {
					e.printStackTrace();
				} 
				return null;
			}
			
			public String outStar(int star) {
				String rating  = "☆☆☆☆☆";
				if(star == 0) {
					rating = "☆☆☆☆☆";
				}
				if(star == 1) {
					rating = "★☆☆☆☆";
				}
				if(star == 2) {
					rating = "★★☆☆☆";
				}
				if(star == 3) {
					rating = "★★★☆☆";
				}
				if(star == 4) {
					rating = "★★★★☆";
				}
				if(star == 5) {
					rating = "★★★★★";
				}
				return rating;
			}
		
		// --------------------------------------------------------
		
			
			// dic게시판 DB정보를 가져오는 함수
			// return 값으로 고유번호, 제목, 내용, 작성자ID를 가져온다.
			public ArrayList<dicboard> getDboardList(int pageNumber){
				ArrayList<dicboard> dboardList = new ArrayList<dicboard>();
				String sql = "SELECT * FROM dicboard WHERE Dnumber < ? ORDER BY Dnumber DESC limit 10";
				
				try {
					PreparedStatement ps= conn.prepareStatement(sql);
					ps.setInt(1,getNextd() - (pageNumber -1) * 10);
					
					rs= ps.executeQuery();
					while(rs.next()) {
						dicboard dicboard = new dicboard();
						
						dicboard.setDnumber(rs.getInt(1));
						dicboard.setTitle(rs.getNString(2));
						dicboard.setContent(rs.getNString(3));
						dicboard.setUserID(rs.getNString(4));
						
						dboardList.add(dicboard);
						}
					}catch(Exception e) {
						e.printStackTrace();
					} return dboardList;
				}
					
				public dicboard getDboard(int Dnumber) {
					String sql= "SELECT * FROM dicboard WHERE Dnumber = ?";
					try {
						PreparedStatement ps= conn.prepareStatement(sql);
						ps.setInt(1, Dnumber);
						rs= ps.executeQuery();
						if(rs.next()) {
							dicboard dboard = new dicboard();
							dboard.setDnumber(rs.getInt(1));
							dboard.setTitle(rs.getNString(2));
							dboard.setContent(rs.getNString(3));
							dboard.setUserID(rs.getNString(4));
							
							return dboard;
						}
					}catch(Exception e) {
						e.printStackTrace();
					} 
					return null;
				}
				
		//----------------------------------------------------------
		public int join(String UserID, String UserPW, String UserNickname) {
			try {
				String SQL = "INSERT INTO User(UserID, PW, Nickname) VALUES (?, ?, ?);";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, UserID);
				pstmt.setString(2, UserPW);
				pstmt.setString(3, UserNickname);
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
			return -1;
		}
		//------------------------------------------------------------
		
		public ArrayList<dicboard> getSearchd(String searchField, String searchText){
			ArrayList<dicboard> list = new ArrayList<dicboard>();
		      String SQL ="select * from dicboard WHERE "+ searchField.trim();
		      try {
		            if(searchText != null && !searchText.equals("") ){//이거 빼면 안 나온다ㅜ 왜지?
		                SQL +=" LIKE '%"+searchText.trim()+"%' order by Dnumber desc limit 10";
		            }
		            PreparedStatement pstmt=conn.prepareStatement(SQL);
					rs=pstmt.executeQuery();//select
		         while(rs.next()) {
		            dicboard bbs = new dicboard();
		            bbs.setDnumber(rs.getInt(1));
		            bbs.setTitle(rs.getString(2));
		            bbs.setContent(rs.getString(3));
		            bbs.setUserID(rs.getString(4));
		            
		            list.add(bbs);//list에 해당 인스턴스를 담는다.
		         }       
		      } catch(Exception e) {
		         e.printStackTrace();
		      }
		      return list;
		   }
		public ArrayList<scoreboard> getSearchS(String searchField, String searchText){
			ArrayList<scoreboard> list = new ArrayList<scoreboard>();
		      String SQL ="select * from estiboard WHERE "+ searchField.trim();
		      try {
		            if(searchText != null && !searchText.equals("") ){//이거 빼면 안 나온다ㅜ 왜지?
		                SQL +=" LIKE '%"+searchText.trim()+"%' order by Enumber desc limit 10";
		            }
		            PreparedStatement pstmt=conn.prepareStatement(SQL);
					rs=pstmt.executeQuery();//select
		         while(rs.next()) {
		            scoreboard bbs = new scoreboard();
		            bbs.setEnumber(rs.getInt(1));
		            bbs.setTitle(rs.getString(2));
		            bbs.setContent(rs.getString(3));
		            bbs.setStar(rs.getInt(4));
		            bbs.setUserID(rs.getString(5));
		            
		            list.add(bbs);//list에 해당 인스턴스를 담는다.
		         }       
		      } catch(Exception e) {
		         e.printStackTrace();
		      }
		      return list;
		   }
		public ArrayList<qboard> getSearchQ(String searchField, String searchText){
			ArrayList<qboard> list = new ArrayList<qboard>();
		      String SQL ="select * from qboard WHERE "+ searchField.trim();
		      try {
		            if(searchText != null && !searchText.equals("") ){//이거 빼면 안 나온다ㅜ 왜지?
		                SQL +=" LIKE '%"+searchText.trim()+"%' order by Qnumber desc limit 10";
		            }
		            PreparedStatement pstmt=conn.prepareStatement(SQL);
					rs=pstmt.executeQuery();//select
		         while(rs.next()) {
		            qboard bbs = new qboard();
		            bbs.setQnumber(rs.getInt(1));
		            bbs.setTitle(rs.getString(2));
		            bbs.setContent(rs.getString(3));
		            bbs.setUserID(rs.getString(4));
		            
		            list.add(bbs);//list에 해당 인스턴스를 담는다.
		         }       
		      } catch(Exception e) {
		         e.printStackTrace();
		      }
		      return list;
		   }
}
