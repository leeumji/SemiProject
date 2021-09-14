package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.BbsDto;
import dto.MemberDto;

public class MemberDao {

	private static MemberDao dao = new MemberDao();

	private MemberDao() {
		// 한번만 실행하면 되서 생성자에 넣어주면 끗!
		DBConnection.initConnection();
	}

	public static MemberDao getInstance() {
		return dao;
	}

	public boolean addMember(MemberDto dto) {

		String sql = " INSERT INTO MEMBER " + " VALUES(?, ?, ?, ?, ?, ?, 3) ";

		Connection conn = null;
		PreparedStatement psmt = null;

		int count = 0;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 addMember success");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPwd());
			psmt.setString(3, dto.getNickname());
			psmt.setString(4, dto.getBirth());
			psmt.setString(5, dto.getGender());
			psmt.setString(6, dto.getEmail());
			System.out.println("2/3 addMember success");

			count = psmt.executeUpdate();
			System.out.println("3/3 addMember success");
		} catch (SQLException e) {
			System.out.println("addMember fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		return count > 0;
	}

	public boolean getId(String id) {

		String sql = " SELECT ID FROM MEMBER WHERE ID=? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null; // select 할때 필요하다.

		boolean findId = false;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getId success");
			psmt = conn.prepareStatement(sql);
			System.out.println("2/3 getId success");
			psmt.setString(1, id);

			rs = psmt.executeQuery(); // 쿼리문을 실행해라
			if (rs.next()) {
				findId = true; // 같은값이 있을 경우
			}
			System.out.println("3/3 getId success");
		} catch (SQLException e) {
			System.out.println("getId fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		return findId;
	}

	public boolean getName(String name) {

		String sql = " SELECT * FROM MEMBER WHERE NICKNAME=? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		boolean findName = false;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getName success");
			psmt = conn.prepareStatement(sql);
			System.out.println("2/3 getName success");
			psmt.setString(1, name);

			rs = psmt.executeQuery();
			if (rs.next()) {
				findName = true;
			}
			System.out.println("3/3 getName success");
		} catch (SQLException e) {
			System.out.println("getName fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		return findName;
	}

	public boolean getEmail(String email) {

		String sql = " SELECT * FROM MEMBER WHERE EMAIL=? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		boolean findEmail = false;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getEmail success");
			psmt = conn.prepareStatement(sql);
			System.out.println("2/3 getEmail success");
			psmt.setString(1, email);

			rs = psmt.executeQuery();
			if (rs.next()) {
				findEmail = true;
			}
			System.out.println("3/3 getEmail success");
		} catch (SQLException e) {
			System.out.println("getEmail fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		return findEmail;
	}

	// 6.25 초희수정
	public MemberDto login(String id, String pwd) {

		String sql = " SELECT * FROM MEMBER WHERE ID=? AND PWD=? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		MemberDto mem = null;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 login success");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, pwd);
			System.out.println("2/4 login success");
			rs = psmt.executeQuery();
			System.out.println("3/4 login success");
			// login session에 저장하기 위해 pwd를 제외하고 다시 저장해준다.
			// 출력된 결과 테이블의 컬럼명순으로 지정한다.
			if (rs.next()) {
				String _id = rs.getString(1);
				String nickname = rs.getString(3);
				String birth = rs.getNString(4);
				String gender = rs.getNString(5);
				String email = rs.getString(6);
				int auth = rs.getInt(7);

				mem = new MemberDto(_id, null, nickname, birth, gender, email, auth);

			}
			System.out.println("4/4 login success");
		} catch (SQLException e) {
			System.out.println("login fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		return mem;
	}

	public MemberDto findId(String nickname, String email) {

		String sql = " SELECT * FROM MEMBER " + " WHERE NICKNAME=? AND EMAIL=? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		MemberDto dto = null;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 findId success");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, nickname);
			psmt.setString(2, email);
			System.out.println("2/3 findId success");
			rs = psmt.executeQuery();

			if (rs.next()) {
				int i = 1;
				dto = new MemberDto(rs.getString(i++), rs.getString(i++), rs.getString(i++), rs.getString(i++),
						rs.getString(i++), rs.getString(i++), rs.getInt(i++));
			}
			System.out.println("3/3 findId success");
		} catch (SQLException e) {
			System.out.println("findId fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		return dto;

	}

	public MemberDto findPwd(String id, String nickname, String email) {

		String sql = " SELECT * FROM MEMBER " + " WHERE ID=? AND NICKNAME=? AND EMAIL=? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		MemberDto dto = null;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 findId success");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, nickname);
			psmt.setString(3, email);
			System.out.println("2/3 findId success");
			rs = psmt.executeQuery();

			if (rs.next()) {
				int i = 1;
				dto = new MemberDto(rs.getString(i++), rs.getString(i++), rs.getString(i++), rs.getString(i++),
						rs.getString(i++), rs.getString(i++), rs.getInt(i++));
			}
			System.out.println("3/3 findId success");
		} catch (SQLException e) {
			System.out.println("findId fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		return dto;

	}

	// 6.23 은희_내정보 수정
	public boolean updateMypage(String pwd, String nickname, String birth, String gender, String email, String id) {

		String sql = " UPDATE MEMBER SET " + " PWD=?, NICKNAME=?, BIRTH=?, GENDER=?, EMAIL=? " + " WHERE ID=?        ";

		Connection conn = null;
		PreparedStatement psmt = null;

		int count = 0;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 update success");

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, pwd);
			psmt.setString(2, nickname);
			psmt.setString(3, birth);
			psmt.setString(4, gender);
			psmt.setString(5, email);
			psmt.setString(6, id);
			System.out.println("2/3 update success");

			count = psmt.executeUpdate();
			System.out.println("3/3 update success");

		} catch (SQLException e) {
			System.out.println("update fail");
		} finally {
			DBClose.close(conn, psmt, null);
		}
		return count > 0 ? true : false;
	}

	// 6.24 수정 은희
	public MemberDto getMember(String id) {

		String sql = " SELECT * " + "      FROM MEMBER " + "    WHERE ID=? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		MemberDto dto = null;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getMember success");

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			System.out.println("2/3 getMember success");

			rs = psmt.executeQuery();
			if (rs.next()) {
				int n = 1;
				dto = new MemberDto(rs.getString(n++), rs.getString(n++), rs.getString(n++), rs.getString(n++),
						rs.getString(n++), rs.getString(n++), rs.getInt(n++));

			}
			System.out.println("3/3 getMember success");

		} catch (SQLException e) {
			System.out.println("getMember fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}

		return dto;
	}
	
	   
	   
	   
	 //0628 은희  계정삭제 
	 		public boolean deleteMember(String id,String pwd) {
	 			long resTime = System.currentTimeMillis(); 
	 			System.out.println(resTime);
	 			
	 			
	 			String sql = " UPDATE MEMBER SET AUTH=9, PWD="+resTime+", EMAIL=\'@\' WHERE ID=? AND PWD=? ";
	 			
	 			Connection conn = null;
	 		    PreparedStatement psmt = null;
	 		      
	 		    int count = 0;
	 				
	 				try {
	 					conn = DBConnection.getConnection();
	 					System.out.println("1/3 S deleteMember");
	 					System.out.println("id : "+ id + " pwd : " + pwd);
	 					psmt = conn.prepareStatement(sql);
	 					psmt.setString(1, id);
	 					psmt.setString(2, pwd);
	 					System.out.println("2/3 S deleteMember");
	 					
	 					count = psmt.executeUpdate();
	 					System.out.println("3/3 S deleteMember");
	 					
	 				} catch (Exception e) {		
	 					System.out.println("fail deleteMember");
	 					e.printStackTrace();
	 				} finally {
	 					DBClose.close(conn, psmt, null);			
	 				}
	 				
	 				return count>0?true:false;
	 		}
	 		//0625 은지수정 - 모든 멤버 불러오기
	 		public List<MemberDto> getMemberList() {
	 			
	 			String sql = " SELECT * "
	 		               + " FROM MEMBER ";
	 		      
	 		      Connection conn = null;         // DB 연결
	 		      PreparedStatement psmt = null;   // Query문을 실행
	 		      ResultSet rs = null;         // 결과 취득
	 		      
	 		      List<MemberDto> list = new ArrayList<MemberDto>();

	 		      try {
	 		         conn = DBConnection.getConnection();
	 		         System.out.println("1/4 getMemberList success");
	 		         
	 		         psmt = conn.prepareStatement(sql);
	 		         System.out.println("2/4 getMemberList success");
	 		         
	 		         rs = psmt.executeQuery();
	 		         System.out.println("3/4 getMemberList success");
	 		         
	 		         while(rs.next()) {
	 		            int i=1;
	 		            MemberDto dto = new MemberDto(	rs.getString(i++), 
	 		            								rs.getString(i++), 
	 		            								rs.getString(i++), 
	 		            								rs.getString(i++), 
	 		            								rs.getString(i++), 
	 		            								rs.getString(i++), 
	 		            								rs.getInt(i++));
	 		            list.add(dto);
	 		         }
	 		         System.out.println("4/4 getMemberList success");
	 		         
	 		      } catch (SQLException e) {
	 		         System.out.println("getMemberList fail");
	 		         e.printStackTrace();
	 		      } finally {
	 		         DBClose.close(conn, psmt, rs);
	 		      }
	 		      
	 		      return list;      
	 		}
	 		//0625 은지수정 - 검색해서 불러오기
	 		public List<MemberDto> getMemberSearchList(String choice, String search) {
	 			String sql = " SELECT ID, PWD, NICKNAME, BIRTH, GENDER, EMAIL, AUTH "
	 						+ " FROM MEMBER "
	 						+ " WHERE AUTH=3 "; //관리자는 목록에 안뿌려줌
	 			
	 			String sWord = "";
	 			
	 			if(choice.equals("id")) {
	 				sWord = "AND ID LIKE '%" + search + "%' ";
	 			}else if(choice.equals("pwd")) {
	 				sWord = "AND PWD LIKE '%" + search + "%' ";
	 			}else if(choice.equals("nickname")) {
	 				sWord = "AND NICKNAME LIKE '%" + search + "%' ";
	 			}else if(choice.equals("birth")) {
	 				sWord = "AND BIRTH LIKE '%" + search + "%' ";
	 			}else if(choice.equals("gender")) {
	 				sWord = "AND GENDER LIKE '%" + search + "%' ";
	 			}else if(choice.equals("email")) {
	 				sWord = "AND EMAIL LIKE '%" + search + "%' ";
	 			}
	 			
	 			sql = sql + sWord; //쿼리문 합치기
	 			
	 			Connection conn = null;			// DB 연결
	 			PreparedStatement psmt = null;	// Query문을 실행
	 			ResultSet rs = null;			// 결과 취득
	 			
	 			List<MemberDto> list = new ArrayList<MemberDto>();
	 			
	 			try {
	 				conn = DBConnection.getConnection();
	 				System.out.println("1/4 getMemberSearchList success");
	 				
	 				psmt = conn.prepareStatement(sql);
	 				System.out.println("2/4 getMemberSearchList success");
	 				
	 				rs = psmt.executeQuery();
	 				System.out.println("3/4 getMemberSearchList success");
	 				
	 				while(rs.next()) {
	 					int i = 1;
	 					MemberDto dto = new MemberDto(rs.getString(i++), 
	 													rs.getString(i++), 
	 													rs.getString(i++), 
	 													rs.getString(i++), 
	 													rs.getString(i++), 
	 													rs.getString(i++), 
	 													rs.getInt(i++));
	 					list.add(dto);
	 				}
	 				System.out.println("4/4 getMemberSearchList success");
	 				
	 			} catch (SQLException e) {
	 				System.out.println("getMemberSearchList fail");
	 			} finally {
	 				DBClose.close(conn, psmt, rs);
	 			}
	 			
	 			return list;		
	 		}
	 		
	 		////0625 은지수정 - 멤버 여러명 탈퇴시키기
	 		//한번에 여러개 삭제되면 commit 해주고 한번에 여러개 삭제되지 않으면 rollback해줘야 한다.
	 		public int multiResign(String[] id) {
	 			String sql = " DELETE FROM MEMBER "
	 						+ " WHERE ID=? ";	 	
	 			
	 			Connection conn = null;
	 			PreparedStatement psmt = null;

	 			int count[] = null;
	 			int res = 0;
	 			
	 			try {
	 				conn = DBConnection.getConnection();
	 				System.out.println("1/6multiResign success");
	 				
	 				psmt = conn.prepareStatement(sql);
	 				System.out.println("2/6multiResign success");
	 				
	 				for(int i=0; i<id.length; i++) {
	 					psmt.setString(1, id[i]);
	 					
	 					//쿼리문 모두 쌓아 한번에 처리
	 					psmt.addBatch();
	 				}
	 				System.out.println("3/6multiResign success");
	 				
	 				count = psmt.executeBatch();
	 				System.out.println("4/6multiResign success");
	 				
	 				//쿼리성공 : -2
	 				for(int i=0; i<count.length; i++) {
	 					if(count[i] == -2) {
	 						res++;
	 					}
	 				}
	 				System.out.println("5/6multiResign success");
	 				//모아둔 쿼리 실행 끝나면 커밋
	 				if(id.length == res) {
	 					conn.commit();
	 				}else {
	 					conn.rollback();
	 				}
	 				System.out.println("6/6multiResign success");
	 			} catch (SQLException e) {
	 				System.out.println("multiResign fail");
	 				e.printStackTrace();
	 			} finally {
	 				DBClose.close(conn, psmt, null);
	 			}
	 			return res;
	 		}
	 		
	 		//0628 은지수정
	 		public List<MemberDto> getMembers(String id){

	 			String sql = " SELECT * " + "      FROM MEMBER " + "    WHERE ID=? ";

	 			Connection conn = null;
	 			PreparedStatement psmt = null;
	 			ResultSet rs = null;

	 			List<MemberDto> list = new ArrayList<MemberDto>();

	 			try {
	 				conn = DBConnection.getConnection();
	 				System.out.println("1/3 getMembers success");

	 				psmt = conn.prepareStatement(sql);
	 				psmt.setString(1, id);
	 				System.out.println("2/3 getMembers success");

	 				rs = psmt.executeQuery();
	 				if (rs.next()) {
	 					int n = 1;
	 					MemberDto dto = new MemberDto(rs.getString(n++), rs.getString(n++), rs.getString(n++), rs.getString(n++),
	 							rs.getString(n++), rs.getString(n++), rs.getInt(n++));
	 					
	 					list.add(dto);

	 				}
	 				System.out.println("3/3 getMembers success");

	 			} catch (SQLException e) {
	 				System.out.println("getMembers fail");
	 				e.printStackTrace();
	 			} finally {
	 				DBClose.close(conn, psmt, rs);
	 			}

	 			return list;
	 		}
	 		
	 		////0629 은지수정
	 		public List<MemberDto> getMemberPagingList(String choice, String search, int pageNumber) {
	 		      
	 		      String sql =  " SELECT ID, PWD, NICKNAME, BIRTH, GENDER, EMAIL, AUTH "
	 		                + " FROM ";
	 		      
	 		      sql += " (SELECT ROW_NUMBER()OVER(ORDER BY ID DESC) AS RNUM, ID, PWD, "
	 		              + " NICKNAME, BIRTH, GENDER, EMAIL, AUTH FROM MEMBER ";
	 		        
	 		      String sWord = "";
	 		      
	 		      	if(choice.equals("id")) {
		 				sWord = "WHERE ID LIKE '%" + search + "%' ";
		 			}else if(choice.equals("pwd")) {
		 				sWord = "WHERE PWD LIKE '%" + search + "%' ";
		 			}else if(choice.equals("nickname")) {
		 				sWord = "WHERE NICKNAME LIKE '%" + search + "%' ";
		 			}else if(choice.equals("birth")) {
		 				sWord = "WHERE BIRTH LIKE '%" + search + "%' ";
		 			}else if(choice.equals("gender")) {
		 				sWord = "WHERE GENDER LIKE '%" + search + "%' ";
		 			}else if(choice.equals("email")) {
		 				sWord = "WHERE EMAIL LIKE '%" + search + "%' ";
		 			}
	 		      sql = sql + sWord;      
	 		      
	 		      sql = sql + " ORDER BY ID DESC) ";
	 		      
	 		      sql = sql + " WHERE RNUM >= ? AND RNUM <= ? AND AUTH=3 ";
	 		      
	 		      int start, end;
	 		    
	 		      
	 		      start = 1 + 10 * pageNumber;   // 0 -> 1 ~ 10   1 -> 11 ~ 20
	 		      end = 10 + 10 * pageNumber;      
	 		      
	 		      Connection conn = null;         // DB     
	 		      PreparedStatement psmt = null;   // Query         
	 		      ResultSet rs = null;         //        
	 		      
	 		      List<MemberDto> list = new ArrayList<MemberDto>();

	 		      try {
	 		         conn = DBConnection.getConnection();
	 		         System.out.println("1/4 getMemberPagingList success");
	 		         
	 		         psmt = conn.prepareStatement(sql);
	 		         psmt.setInt(1, start);
	 		         psmt.setInt(2, end);
	 		         System.out.println("2/4 getMemberPagingList success");
	 		         
	 		         rs = psmt.executeQuery();
	 		         System.out.println("3/4 getMemberPagingList success");
	 		         
	 		         while(rs.next()) {
	 		            int i=1;
	 		           MemberDto dto = new MemberDto(rs.getString(i++), 
													rs.getString(i++), 
													rs.getString(i++), 
													rs.getString(i++), 
													rs.getString(i++), 
													rs.getString(i++), 
													rs.getInt(i++));
	 		            list.add(dto);
	 		         }
	 		         System.out.println("4/4 getMemberPagingList success");
	 		         
	 		      } catch (SQLException e) {
	 		         System.out.println("getMemberPagingList fail");
	 		         e.printStackTrace();
	 		      } finally {
	 		         DBClose.close(conn, psmt, rs);
	 		      }
	 		      
	 		      return list;      
	 		   }   
	 	// 멤버의 총수
	 	   public int getAllMember(String choice, String search) {
	 	      
	 	      String sql = " SELECT COUNT(*) FROM MEMBER WHERE AUTH=3 ";
	 	      
	 	      String sWord = "";
	 	      if(choice.equals("id")) {
	 				sWord = "AND ID LIKE '%" + search + "%' ";
	 			}else if(choice.equals("pwd")) {
	 				sWord = "AND PWD LIKE '%" + search + "%' ";
	 			}else if(choice.equals("nickname")) {
	 				sWord = "AND NICKNAME LIKE '%" + search + "%' ";
	 			}else if(choice.equals("birth")) {
	 				sWord = "AND BIRTH LIKE '%" + search + "%' ";
	 			}else if(choice.equals("gender")) {
	 				sWord = "AND GENDER LIKE '%" + search + "%' ";
	 			}else if(choice.equals("email")) {
	 				sWord = "AND EMAIL LIKE '%" + search + "%' ";
	 			}
	 	      sql = sql + sWord;
	 	      
	 	      Connection conn = null;         // DB 연결
	 	      PreparedStatement psmt = null;   // Query문을 실행
	 	      ResultSet rs = null;         // 결과 취득
	 	      
	 	      int len = 0;
	 	      
	 	      try {
	 	         conn = DBConnection.getConnection();
	 	         System.out.println("1/3 getAllMember success");
	 	         
	 	         psmt = conn.prepareStatement(sql);
	 	         System.out.println("2/3 getAllMember success");
	 	         
	 	         rs = psmt.executeQuery();
	 	         if(rs.next()) {
	 	            len = rs.getInt(1);
	 	         }
	 	         System.out.println("3/3 getAllMember success");
	 	         
	 	      } catch (SQLException e) {
	 	         System.out.println("getAllMember fail");
	 	         e.printStackTrace();
	 	      } finally {
	 	         DBClose.close(conn, psmt, rs);
	 	      }
	 	      
	 	      return len;
	 	   }	
	 	   
	 	  public boolean deleteMember(String id) {
	 			String sql = " DELETE FROM MEMBER WHERE ID=? ";
	 			
	 			 Connection conn = null;
	 		      PreparedStatement psmt = null;
	 		      int count = 0;
	 				
	 				try {
	 					conn = DBConnection.getConnection();
	 					System.out.println("1/3 S deleteMember");
	 					
	 					psmt = conn.prepareStatement(sql);
	 					psmt.setString(1, id);
	 					System.out.println("2/3 S deleteMember");
	 					
	 					count = psmt.executeUpdate();
	 					System.out.println("3/3 S deleteMember");
	 					
	 				} catch (Exception e) {		
	 					System.out.println("fail deleteMember");
	 					e.printStackTrace();
	 				} finally {
	 					DBClose.close(conn, psmt, null);			
	 				}
	 				
	 				return count>0?true:false;
	 		}
}
