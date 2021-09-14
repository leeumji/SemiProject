package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;

import org.eclipse.jdt.internal.compiler.ast.RequiresStatement;

import db.DBClose;
import db.DBConnection;
import dto.QnaDto;

public class QnaDao {

	private static QnaDao dao = null;
	
	private QnaDao() {
		DBConnection.initConnection();
	}
	
	public static QnaDao getInstance() {
		if(dao ==null) {
			dao = new QnaDao();
		}
		return dao;
	}
	
////////////////////////////////////////////// 1단계 기본 리스트 가져오기
	public List<QnaDto> getQnaList(){
		String sql = " SELECT * FROM QNA ";
		
		Connection conn = null; //db를 연결
		PreparedStatement psmt = null; //query문을 실행
		ResultSet rs = null;//결과 취득...
		
		List<QnaDto> list = new ArrayList<QnaDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getQnaList success");
			psmt = conn.prepareStatement(sql);
			System.out.println("2/4 getQnaList success");
			rs = psmt.executeQuery();
			System.out.println("3/4 getQnaList success");
		
			while(rs.next()) {
				int i = 1;
				QnaDto dto = new QnaDto(rs.getInt(i++),
										rs.getString(i++),
										rs.getInt(i++),
										rs.getInt(i++),
										rs.getString(i++),
										rs.getString(i++),
										rs.getString(i++),
										rs.getInt(i++), 
										rs.getInt(i++),
										rs.getInt(i++),
										rs.getInt(i++),
										rs.getInt(i++));
				list.add(dto);
			}
			System.out.println("4/4 getQnaList success");
		} catch (SQLException e) {
			System.out.println("getQnaList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}return list;
		
	}
	
//////////////////////////////////////////////////////일반 qna 작성하기
	public boolean writeqna(QnaDto dto) {
		String sql = " INSERT INTO QNA(SEQ, NICKNAME, REF, STEP, TITLE, CONTENT, "
				+ " WDATE, DEL, WAIT, READCOUNT, NOTICE) "
				+ " VALUES(SEQ_QNA.NEXTVAL,?,(SELECT NVL(MAX(REF),0)+1 FROM QNA),0,?,?,SYSDATE,0,0,0,0) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn=DBConnection.getConnection();
			System.out.println("1/3 writeqna success");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getNickname());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			System.out.println("2/3 writeqna success");
			count = psmt.executeUpdate();
			System.out.println("3/3 writeqna success");
		} catch (SQLException e) {
			System.out.println("writeqna fail");
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		return count>0?true:false;
	}
	
//////////////////////////////////////////////////////비밀 qna 작성하기	
	public boolean writePwdQna(QnaDto dto) {
		String sql = " INSERT INTO QNA(SEQ, NICKNAME, REF, STEP, TITLE, CONTENT, "
				+ "	 WDATE, DEL, WAIT, READCOUNT, NOTICE, PWD) "
				+ " VALUES(SEQ_QNA.NEXTVAL,?,(SELECT NVL(MAX(REF),0)+1 FROM QNA),0,?,?,SYSDATE,0,0,0,0,?) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn=DBConnection.getConnection();
			System.out.println("1/3 writeqna success");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getNickname());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getPwd());
			System.out.println("2/3 writeqna success");
			count = psmt.executeUpdate();
			System.out.println("3/3 writeqna success");
		} catch (SQLException e) {
			System.out.println("writeqna fail");
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		return count>0?true:false;
	}
	
//////////////////////////////////////////////일반 QNA 상세글 보기
	public QnaDto getQnaInfo(int seq) {
		String sql = " SELECT SEQ, NICKNAME, REF, STEP, TITLE, CONTENT, WDATE, DEL, WAIT, READCOUNT, NOTICE, DELBY, PWD "
				 	+ " FROM QNA WHERE SEQ = ? ";
		
		Connection conn = null; //db를 연결
		PreparedStatement psmt = null; //query문을 실행
		ResultSet rs = null;//결과 취득...
		
		QnaDto dto = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getqnaInfo success");
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1,seq);
			System.out.println("2/3 getqnaInfo success");
			rs = psmt.executeQuery();
			if(rs.next()) {
				int n = 1;
				dto = new QnaDto(rs.getInt(n++), 
								 rs.getString(n++), 
								 rs.getInt(n++), 
								 rs.getInt(n++), 
								 rs.getString(n++),
								 rs.getString(n++), 
								 rs.getString(n++), 
								 rs.getInt(n++), 
								 rs.getInt(n++), 
								 rs.getInt(n++), 
								 rs.getInt(n++),
								 rs.getInt(n++));
				
			System.out.println("3/3 getqnaInfo success");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("getqnaInfo fail");
		}finally {
			DBClose.close(conn, psmt, rs);
		}
		return dto;
		}
	
//////////////////////////////////////////////비밀 QNA 상세글 보기	
	public QnaDto getPwdQnaInfo(int seq, String pwd) {
		String sql = " SELECT SEQ, NICKNAME, REF, STEP, TITLE, CONTENT, WDATE, DEL, WAIT, READCOUNT, NOTICE, DELBY "
				 	+ " FROM QNA WHERE SEQ = ? AND PWD = ? ";
		
		Connection conn = null; //db를 연결
		PreparedStatement psmt = null; //query문을 실행
		ResultSet rs = null;//결과 취득...
		
		QnaDto dto = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getqnaInfo success");
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1,seq);
			psmt.setString(2,pwd);
			System.out.println("2/3 getqnaInfo success");
			rs = psmt.executeQuery();
			if(rs.next()) {
				int n = 1;
				dto = new QnaDto(rs.getInt(n++), 
								 rs.getString(n++), 
								 rs.getInt(n++), 
								 rs.getInt(n++), 
								 rs.getString(n++),
								 rs.getString(n++), 
								 rs.getString(n++), 
								 rs.getInt(n++), 
								 rs.getInt(n++), 
								 rs.getInt(n++), 
								 rs.getInt(n++),
								 rs.getInt(n++),
								 rs.getString(n++));
				
			System.out.println("3/3 getqnaInfo success");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("getqnaInfo fail");
		}finally {
			DBClose.close(conn, psmt, rs);
		}
		return dto;
		}
	
	
	
	
	
	
///////////////////////////////////////////////////조회수 늘리기
	
	public void readcount(int seq) {
		String sql = " UPDATE QNA " + " SET READCOUNT=READCOUNT+1 " + " WHERE SEQ = ?";
		Connection conn = null; //db를 연결
		PreparedStatement psmt = null; //query문을 실행
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 readcount success");
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/3 readcount success");
			psmt.executeQuery();
			System.out.println("3/3 readcount success");
			
		}catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			DBClose.close(conn, psmt, null);
		}
	}
//////////////////////////////////////////////////qna 삭제하기(관리자), 두개 다 날림
	
	public boolean deleteAdminQna(int seq) {
		
		String sql = " UPDATE QNA SET DEL = 1, TITLE = '!! 이 글은 부적절한 사유로 관리자에 의해 삭제되었습니다 !!', DELBY = 1 " 
					+ " WHERE REF=(SELECT REF FROM QNA WHERE SEQ=?) AND DEL = 0";
		
		Connection conn = null; //db를 연결
		PreparedStatement psmt = null; //query문을 실행
		int count = 0;
		
		conn = DBConnection.getConnection();
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 deleteAdminQna success");
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/3 deleteAdminQna  success");
			count = psmt.executeUpdate();
			System.out.println("3/3 deleteAdminQna  success");
		}catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			DBClose.close(conn, psmt, null);
		}
		return count>0?true:false;
	}
		
/////////////////////////////////////////////////////qna 삭제하기 (회원, 답글은 유지)
		
	public boolean deleteQna(int seq) {
		String sql = " UPDATE QNA SET DEL = 1, TITLE = '!! 이 글은 작성자가 삭제한 글입니다 !!', DELBY = 3 " 
					+ " WHERE SEQ = ? ";
		
		Connection conn = null; //db를 연결
		PreparedStatement psmt = null; //query문을 실행
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 deleteQna success");
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/3 deleteQna success");
			count = psmt.executeUpdate();
			System.out.println("3/3 deleteQna success");
			
		}catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			DBClose.close(conn, psmt, null);
		}
		return count>0?true:false;
	}
		
/////////////////////////////////////////////////////검색 결과값 포함하는 목록 만들기
		public List<QnaDto> getSearchlist(String category, String keyword) {
			String sql = " SELECT SEQ, NICKNAME, REF, STEP, TITLE, CONTENT, WDATE, DEL, WAIT, READCOUNT, NOTICE FROM QNA ";

			String sqlcondition = "";

			if (category.equals("title")) {
				sqlcondition = " WHERE TITLE LIKE '%" + keyword.trim() + "%' AND DEL = 0";
			} else if (category.equals("content")) {
				sqlcondition = " WHERE CONTENT LIKE '%" + keyword.trim() + "%' AND DEL = 0";
			} else if (category.equals("nickname")) {
				sqlcondition = " WHERE NICKNAME LIKE '%" + keyword.trim() + "%' AND DEL = 0";
			}

			sql += sqlcondition;
			sql += " ORDER BY REF DESC, STEP ASC ";

			Connection conn = null; // db를 연결
			PreparedStatement psmt = null; // query문을 실행
			ResultSet rs = null;// 결과 취득...

			List<QnaDto> list = new ArrayList<QnaDto>();

			try {
				conn = DBConnection.getConnection();
				System.out.println("1/4 getQnaList success");
				psmt = conn.prepareStatement(sql);
				System.out.println("2/4 getQnaList success");
				rs = psmt.executeQuery();
				System.out.println("3/4 getQnaList success");

				while (rs.next()) {
					int i = 1;
					QnaDto dto = new QnaDto(rs.getInt(i++), rs.getString(i++), rs.getInt(i++), rs.getInt(i++),
							rs.getString(i++), rs.getString(i++), rs.getString(i++), rs.getInt(i++), rs.getInt(i++),
							rs.getInt(i++), rs.getInt(i++), rs.getInt(i++));
					list.add(dto);
				}
				System.out.println("4/4 getQnaList success");
			} catch (SQLException e) {
				System.out.println("getQnaList fail");
				e.printStackTrace();
			} finally {
				DBClose.close(conn, psmt, rs);
			}
			return list;
		}

//////////////////////////////////////////////qna 수정하기
		public boolean updateQna(String title, String content, int seq) {
			String sql = " UPDATE QNA " + " SET TITLE=?, CONTENT=? " + " WHERE SEQ =? ";

			Connection conn = null; // db를 연결
			PreparedStatement psmt = null; // query문을 실행

			int count = 0;

			try {
				conn = DBConnection.getConnection();
				System.out.println("1/3 updateQna success");
				psmt = conn.prepareStatement(sql);

				psmt.setString(1, title);
				psmt.setString(2, content);
				psmt.setInt(3, seq);
				System.out.println("2/3 updateQna success");
				count = psmt.executeUpdate();
				System.out.println("3/3 updateQna success");

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				DBClose.close(conn, psmt, null);
			}
			return count > 0 ? true : false;
		}
		
		
///////////////////////////////////////////////////////////글의 총 갯수 구하기
		public int getAllQna(String category, String keyword) {
			String sql = " SELECT COUNT(*) FROM QNA ";
			
			String sqlcondition = "";
			
			if(category.equals("title")) {
				sqlcondition = " WHERE TITLE LIKE '%" + keyword.trim() + "%'";
			}else if(category.equals("content")){
				sqlcondition = " WHERE CONTENT LIKE'%" + keyword.trim() + "%'";
			}else if(category.equals("nickname")){
				sqlcondition = " WHERE NICKNAME = '" + keyword.trim() + "'";
			}
			
			sql+=sqlcondition;
			
			Connection conn = null; //db를 연결
			PreparedStatement psmt = null; //query문을 실행
			ResultSet rs = null;//결과 취득...
			
			int len = 0;
			
			try {
				conn = DBConnection.getConnection();
				System.out.println("1/3 getAllQna success");
				psmt = conn.prepareStatement(sql);
				System.out.println("2/3 getAllQna success");
				
				rs = psmt.executeQuery();
				if(rs.next()) {
					len = rs.getInt(1);
				}
				System.out.println("2/3 getAllQna success");
				} catch (SQLException e) {
				System.out.println("getAllQna fail");
				e.printStackTrace();
				}finally {
					DBClose.close(conn, psmt, rs);
				}
				return len; 
			}
///////////////////////////////////////////////////////페이징 리스트
		
		public List<QnaDto> getPagingList(String category, String keyword, int pageNumber) {
			String sql = " SELECT SEQ, NICKNAME, REF, STEP, TITLE, CONTENT, WDATE, DEL, WAIT, READCOUNT, NOTICE, DELBY " 
					   + " FROM ";
			//1. number설정
			sql += " (SELECT ROW_NUMBER()OVER(ORDER BY REF DESC, STEP ASC) AS RNUM, SEQ, NICKNAME, REF, STEP,  "
					+ " TITLE, CONTENT, WDATE, DEL, WAIT, READCOUNT, NOTICE, DELBY FROM QNA ";
			
			String sqlcondition = "";
						 
			if(category.equals("title")) {
				sqlcondition = " WHERE TITLE LIKE '%" + keyword.trim() + "%' AND DEL = 0";
			}else if(category.equals("content")){
				sqlcondition = " WHERE CONTENT LIKE'%" + keyword.trim() + "%' AND DEL = 0";
			}else if(category.equals("titleandcontent")) {
				sqlcondition = " WHERE TITLE LIKE '%" + keyword.trim() + "%' OR CONTENT LIKE '%" + keyword.trim() + "%' AND DEL = 0";
			}else if(category.equals("nickname")){
				sqlcondition = " WHERE NICKNAME = '" + keyword.trim() + "'";
			}
	
			sql+=sqlcondition;
			sql += " ORDER BY NOTICE DESC, REF DESC, STEP ASC) ";
			sql += " WHERE RNUM>=? AND RNUM<=? "; 
			//sql+=" "; //몇 페이지인지 모르니까 ?로 처리해야함
			
			int start, end;
			start = 1 + 10*pageNumber;// pageNumber가 0일때는 1부터 10, 1일때는 11부터 20
			end = 10 + 10*pageNumber;
			
			Connection conn = null; //db를 연결
			PreparedStatement psmt = null; //query문을 실행
			ResultSet rs = null;//결과 취득...
			
			List<QnaDto> list = new ArrayList<QnaDto>();
			
			try {
				conn = DBConnection.getConnection();
				System.out.println("1/4 getPagingList success");
				psmt = conn.prepareStatement(sql);
				psmt.setInt(1, start);
				psmt.setInt(2, end);
				System.out.println("2/4 getPagingList success");
				rs = psmt.executeQuery();
				System.out.println("3/4 getPagingList success");
				
				while(rs.next()) {
					int i = 1;
					QnaDto dto = new QnaDto(rs.getInt(i++), 
											rs.getString(i++), 
											rs.getInt(i++), 
											rs.getInt(i++), 
											rs.getString(i++), 
											rs.getString(i++), 
											rs.getString(i++), 
											rs.getInt(i++), 
											rs.getInt(i++), 
											rs.getInt(i++),
											rs.getInt(i++),
											rs.getInt(i++));
					list.add(dto);
				}
					System.out.println("4/4 getPagingList success");
				
			} catch (SQLException e) {
				System.out.println("getPagingList fail");
			}finally {
				DBClose.close(conn, psmt, rs);
			}
			return list;
		}

//////////////////////////////////////////////////답글달기
		
		public boolean qnaAnswer(int seq, QnaDto qna) {
			// 부모 글 번호, 새로운 답글
//update

			String sql1 = " UPDATE QNA " + "SET STEP=STEP+1 " + " WHERE REF=(SELECT REF FROM QNA WHERE SEQ=? )"
					+ " AND STEP > (SELECT STEP FROM QNA WHERE SEQ=? )";
//insert
			String sql2 = " INSERT INTO QNA(SEQ, NICKNAME, REF, STEP, TITLE, CONTENT, WDATE, DEL, WAIT, READCOUNT, NOTICE ) "
					+ " VALUES(SEQ_QNA.NEXTVAL, ?, (SELECT REF FROM QNA WHERE SEQ=?), (SELECT STEP FROM QNA WHERE SEQ=?)+1, "
					+ " ?, ?, SYSDATE, 0,0,0,0)";
			
			Connection conn = null; // db를 연결
			PreparedStatement psmt = null; // query문을 실행
			int count = 0;

			conn = DBConnection.getConnection();
			try {
				conn = DBConnection.getConnection();
				conn.setAutoCommit(false);
				System.out.println("1/6 answer success");
//update
				psmt = conn.prepareStatement(sql1);
				psmt.setInt(1, seq);
				psmt.setInt(2, seq);
				System.out.println("2/6 answer success");
				count = psmt.executeUpdate();
				System.out.println("3/6 answer success");

//psmt 초기화
				psmt.clearParameters();

//insert
				psmt = conn.prepareStatement(sql2);

				psmt.setString(1, qna.getNickname());
				psmt.setInt(2, seq);
				psmt.setInt(3, seq);
				psmt.setString(4, qna.getTitle());
				psmt.setString(5, qna.getContent());
				System.out.println("4/6 answer success");

				count = psmt.executeUpdate();
				System.out.println("5/6 answer success");

				conn.commit();
				System.out.println("6/6 answer success");
			} catch (SQLException e) {

				System.out.println("answer fail");
				try {
					conn.rollback();
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				e.printStackTrace();
			} finally {
				try {
					conn.setAutoCommit(true);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				DBClose.close(conn, psmt, null);
			}
			return count > 0 ? true : false;
		}
//////////////////////////////////////////////////////이 글에 달린 답글 세기
		public int getReQna(int ref, int seq) {
			String sql = " SELECT(SELECT COUNT(TITLE) FROM QNA GROUP BY REF HAVING REF = ?) "
					+ "FROM QNA WHERE SEQ = ?";
		
				Connection conn = null; //db를 연결
				PreparedStatement psmt = null; //query문을 실행
				ResultSet rs = null;//결과 취득...
				
				int count= 0;
				
				try {
					conn = DBConnection.getConnection();
					System.out.println("1/3 getReQna success");
					psmt = conn.prepareStatement(sql);
					psmt.setInt(1, ref);
					psmt.setInt(2, seq);
					System.out.println("2/3 getReQna success");
					
					rs = psmt.executeQuery();
					if(rs.next()) {
						count = rs.getInt(1);
					}
					System.out.println("2/3 getReQna success");
					} catch (SQLException e) {
					System.out.println("getReQna fail");
					e.printStackTrace();
					}finally {
						DBClose.close(conn, psmt, rs);
					}
					return count; 
				}
////////////////////////////////////////////////////////////특정 게시글 최상위에 올리기 --toplist.jsp
		public boolean notice(QnaDto dto) {
		String sql = " INSERT INTO QNA(SEQ, NICKNAME, REF, STEP, TITLE, CONTENT, "
				+ " WDATE, DEL, WAIT, READCOUNT, NOTICE) "
				+ " VALUES(SEQ_QNA.NEXTVAL,?,(SELECT NVL(MAX(REF),0)+1 FROM QNA),0,?,?,SYSDATE,0,0,0,1) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn=DBConnection.getConnection();
			System.out.println("1/3 notice success");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getNickname());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			System.out.println("2/3 notice success");
			count = psmt.executeUpdate();
			System.out.println("3/3 notice success");
		} catch (SQLException e) {
			System.out.println("notice fail");
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		return count>0?true:false;
	}
		
//////////////////////////////////////////////////////////최신순
		public List<QnaDto> getSortingLatestList(){
			String sql = " SELECT SEQ, NICKNAME, REF, STEP, TITLE, CONTENT, WDATE, DEL, WAIT, READCOUNT, NOTICE, DELBY FROM QNA "
					+ " WHERE ROWNUM <=10 ORDER BY WDATE DESC ";
			
			Connection conn = null; //db를 연결
			PreparedStatement psmt = null; //query문을 실행
			ResultSet rs = null;//결과 취득...
			
			List<QnaDto> list = new ArrayList<QnaDto>();
			
			try {
				conn = DBConnection.getConnection();
				System.out.println("1/4 getSortingList success");
				psmt = conn.prepareStatement(sql);
				System.out.println("2/4 getSortingList success");
				rs = psmt.executeQuery();
				System.out.println("3/4 getSortingList success");
			
				while(rs.next()) {
					int i = 1;
					QnaDto dto = new QnaDto(rs.getInt(i++),
											rs.getString(i++),
											rs.getInt(i++),
											rs.getInt(i++),
											rs.getString(i++),
											rs.getString(i++),
											rs.getString(i++),
											rs.getInt(i++), 
											rs.getInt(i++),
											rs.getInt(i++),
											rs.getInt(i++),
											rs.getInt(i++));
					list.add(dto);
				}
				System.out.println("4/4 getSortingList success");
			} catch (SQLException e) {
				System.out.println("getSortingList fail");
				e.printStackTrace();
			} finally {
				DBClose.close(conn, psmt, rs);
			}return list;
			
		}
		
////////////////////////////////////////////////조회순 정렬하기 
		public List<QnaDto> getSortingReadList(){
			String sql = " SELECT SEQ, NICKNAME, REF, STEP, TITLE, CONTENT, WDATE, DEL, WAIT, READCOUNT, NOTICE, DELBY FROM QNA "
					+ " WHERE ROWNUM <=10 ORDER BY READCOUNT DESC ";
			
			Connection conn = null; //db를 연결
			PreparedStatement psmt = null; //query문을 실행
			ResultSet rs = null;//결과 취득...
			
			List<QnaDto> list = new ArrayList<QnaDto>();
			
			try {
				conn = DBConnection.getConnection();
				System.out.println("1/4 getSortingList success");
				psmt = conn.prepareStatement(sql);
				System.out.println("2/4 getSortingList success");
				rs = psmt.executeQuery();
				System.out.println("3/4 getSortingList success");
			
				while(rs.next()) {
					int i = 1;
					QnaDto dto = new QnaDto(rs.getInt(i++),
											rs.getString(i++),
											rs.getInt(i++),
											rs.getInt(i++),
											rs.getString(i++),
											rs.getString(i++),
											rs.getString(i++),
											rs.getInt(i++), 
											rs.getInt(i++),
											rs.getInt(i++),
											rs.getInt(i++),
											rs.getInt(i++));
					list.add(dto);
				}
				System.out.println("4/4 getSortingList success");
			} catch (SQLException e) {
				System.out.println("getSortingList fail");
				e.printStackTrace();
			} finally {
				DBClose.close(conn, psmt, rs);
			}return list;
			
		}
		
}
