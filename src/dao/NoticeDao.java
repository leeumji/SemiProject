package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.NoticeDto;


public class NoticeDao {

	private static NoticeDao dao = null;
	
	private NoticeDao() {
		DBConnection.initConnection();
	}
	
	public static NoticeDao getInstance() {
		if(dao ==null) {
			dao = new NoticeDao();
		}
		return dao;
	}
	
////////////////////////////////////////////// 1단계 기본 리스트 가져오기
	public List<NoticeDto> getNoticeList(){
		String sql = " SELECT SEQ, NICKNAME, TITLE, CONTENT, FILENAME, NEWFILENAME, WDATE, READCOUNT, DOWNCOUNT FROM NOTICE ";
		
		Connection conn = null; //db를 연결
		PreparedStatement psmt = null; //query문을 실행
		ResultSet rs = null;//결과 취득...
		
		List<NoticeDto> list = new ArrayList<NoticeDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getNoticeList success");
			psmt = conn.prepareStatement(sql);
			System.out.println("2/4 getNoticeList success");
			rs = psmt.executeQuery();
			System.out.println("3/4 getNoticeList success");
		
			while(rs.next()) {
				int i = 1;
				NoticeDto dto = new NoticeDto(rs.getInt(i++),
											rs.getString(i++),
											rs.getString(i++),
											rs.getString(i++),
											rs.getString(i++),
											rs.getString(i++),
											rs.getString(i++),
											rs.getInt(i++),
											rs.getInt(i++));
				list.add(dto);
			}
			System.out.println("4/4 getNoticeList success");
		} catch (SQLException e) {
			System.out.println("getNoticeList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}return list;
		
	}
	
//////////////////////////////////////////////////////공지사항 작성하기
	public boolean writeNotice(NoticeDto dto) {
		System.out.println(dto.toString());
		String sql = " INSERT INTO NOTICE(SEQ, NICKNAME, TITLE, CONTENT, FILENAME, NEWFILENAME, "
				+ " WDATE,READCOUNT,DOWNCOUNT) "
				+ " VALUES(SEQ_NOTICE.NEXTVAL,?,?,?,?,?,SYSDATE,0,0) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn=DBConnection.getConnection();
			System.out.println("1/3 writenotice success");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getNickname());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getFilename());
			psmt.setString(5, dto.getNewFilename());
			System.out.println("2/3 writenotice success");
			count = psmt.executeUpdate();
			System.out.println("3/3 writenotice success");
		} catch (SQLException e) {
			System.out.println("writenotice fail");
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		return count>0?true:false;
	}
	
//////////////////////////////////////////////NOTICE 상세글 보기
	public NoticeDto getNoticeInfo(int seq) {
		String sql = " SELECT SEQ, NICKNAME, TITLE, CONTENT, FILENAME, NEWFILENAME, WDATE, READCOUNT, DOWNCOUNT "
				 	+ " FROM NOTICE WHERE SEQ = ? ";
		
		Connection conn = null; //db를 연결
		PreparedStatement psmt = null; //query문을 실행
		ResultSet rs = null;//결과 취득...
		
		NoticeDto dto = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getNoticeInfo success");
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1,seq);
			System.out.println("2/3 getNoticeInfo success");
			rs = psmt.executeQuery();
			if(rs.next()) {
				int n = 1;
						dto = new NoticeDto(rs.getInt(n++), 
												rs.getString(n++), 
												rs.getString(n++),
												rs.getString(n++), 
												rs.getString(n++), 
												rs.getString(n++), 
												rs.getString(n++), 
												rs.getInt(n++),
												rs.getInt(n++));
				
			System.out.println("3/3 getNoticeInfo success");
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
		String sql = " UPDATE NOTICE " + " SET READCOUNT=READCOUNT+1 " + " WHERE SEQ = ?";
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
//////////////////////////////////////////////////qna 삭제하기
	
	public boolean deleteNotice(int seq) {
		String sql = " DELETE FROM NOTICE " + " WHERE SEQ = ? ";
		
		Connection conn = null; //db를 연결
		PreparedStatement psmt = null; //query문을 실행
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 deleteNotice success");
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/3 deleteNotice success");
			count = psmt.executeUpdate();
			System.out.println("3/3 deleteNotice success");
			
		}catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			DBClose.close(conn, psmt, null);
		}
		return count>0?true:false;
		}
	
/////////////////////////////////////////////////////검색 결과값 포함하는 목록 만들기
		public List<NoticeDto> getSearchlist(String category, String keyword) {
			String sql = " SELECT SEQ, NICKNAME, TITLE, CONTENT, FILENAME, NEWFILENAME, WDATE, READCOUNT, DOWNCOUNT FROM NOTICE ";

			String sqlcondition = "";

			if (category.equals("title")) {
				sqlcondition = " WHERE TITLE LIKE '%" + keyword.trim() + "%'";
			} else if (category.equals("content")) {
				sqlcondition = " WHERE CONTENT LIKE '%" + keyword.trim() + "%'";
			} else if (category.equals("nickname")) {
				sqlcondition = " WHERE NICKNAME LIKE '%" + keyword.trim() + "%'";
			}

			sql += sqlcondition;
			sql += " ORDER BY SEQ DESC ";

			Connection conn = null; // db를 연결
			PreparedStatement psmt = null; // query문을 실행
			ResultSet rs = null;// 결과 취득...

			List<NoticeDto> list = new ArrayList<NoticeDto>();

			try {
				conn = DBConnection.getConnection();
				System.out.println("1/4 getSearchList success");
				psmt = conn.prepareStatement(sql);
				System.out.println("2/4 getSearchList success");
				rs = psmt.executeQuery();
				System.out.println("3/4 getSearchList success");

				while (rs.next()) {
					int i = 1;
					NoticeDto dto = new NoticeDto(rs.getInt(i++), 
													rs.getString(i++),  
													rs.getString(i++),
													rs.getString(i++), 
													rs.getString(i++), 
													rs.getString(i++), 
													rs.getString(i++), 
													rs.getInt(i++),
													rs.getInt(i++));
					list.add(dto);
				}
				System.out.println("4/4 getSearchList success");
			} catch (SQLException e) {
				System.out.println("getSearchList fail");
				e.printStackTrace();
			} finally {
				DBClose.close(conn, psmt, rs);
			}
			return list;
		}

//////////////////////////////////////////////Notice 수정하기
		public boolean updateNotice(String title, String content, String filename, String newfilename, int iseq) {
			String sql = " UPDATE NOTICE SET TITLE=?, CONTENT=?, FILENAME=?, NEWFILENAME=? " + " WHERE SEQ =? ";
			
			Connection conn = null; // db를 연결
			PreparedStatement psmt = null; // query문을 실행

			int count = 0;

			try {
				conn = DBConnection.getConnection();
				System.out.println("1/3 updateNotice success");
				psmt = conn.prepareStatement(sql);
				psmt.setString(1, title.toString());
				psmt.setString(2, content);
				psmt.setString(3, filename);
				psmt.setString(4, newfilename);
				psmt.setInt(5, iseq);
				System.out.println("2/3 updateNotice success");
				count = psmt.executeUpdate();
				
				System.out.println("3/3 updateNotice success");

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				DBClose.close(conn, psmt, null);
			}
			return count > 0 ? true : false;
		}
		
///////////////////////////////////////////////////////////글의 총 갯수 구하기
		public int getAllNotice(String category, String keyword) {
			String sql = " SELECT COUNT(*) FROM NOTICE ";
			
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
				System.out.println("1/3 getAllNotice success");
				psmt = conn.prepareStatement(sql);
				System.out.println("2/3 getAllNotice success");
				
				rs = psmt.executeQuery();
				if(rs.next()) {
					len = rs.getInt(1);
				}
				System.out.println("2/3 getAllNotice success");
				} catch (SQLException e) {
				System.out.println("getAllNotice fail");
				e.printStackTrace();
				}finally {
					DBClose.close(conn, psmt, rs);
				}
				return len; 
			}
///////////////////////////////////////////////////////페이징 리스트
		
		public List<NoticeDto> getPagingList(String category, String keyword, int pageNumber) {
			
			String sql = " SELECT SEQ, NICKNAME, TITLE, CONTENT, FILENAME, NEWFILENAME, WDATE, READCOUNT, DOWNCOUNT " 
					   + " FROM ";
			//1. number설정
			sql += " (SELECT ROW_NUMBER()OVER(ORDER BY SEQ DESC) AS RNUM, SEQ, NICKNAME, "
					+ " TITLE, CONTENT, FILENAME, NEWFILENAME, WDATE, READCOUNT, DOWNCOUNT FROM NOTICE ";
			
			String sqlcondition = "";
						 
			if(category.equals("title")) {
				sqlcondition = " WHERE TITLE LIKE '%" + keyword.trim() + "%'";
			}else if(category.equals("content")){
				sqlcondition = " WHERE CONTENT LIKE'%" + keyword.trim() + "%'";
			}else if(category.equals("titleandcontent")) {
				sqlcondition = " WHERE TITLE LIKE '%" + keyword.trim() + "%' OR CONTENT LIKE '%" + keyword.trim() + "%'";
			}else if(category.equals("nickname")){
				sqlcondition = " WHERE NICKNAME = '" + keyword.trim() + "'";
			}
			
			sql+=sqlcondition;
			sql += " ORDER BY SEQ DESC) ";
			sql += " WHERE RNUM>=? AND RNUM<=? "; 
			
			//sql+=" "; //몇 페이지인지 모르니까 ?로 처리해야함
			
			int start, end;
			start = 1 + 10*pageNumber;// pageNumber가 0일때는 1부터 10, 1일때는 11부터 20
			end = 10 + 10*pageNumber;
			
			Connection conn = null; //db를 연결
			PreparedStatement psmt = null; //query문을 실행
			ResultSet rs = null;//결과 취득...
			
			List<NoticeDto> list = new ArrayList<NoticeDto>();
			
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
					NoticeDto dto = new NoticeDto(rs.getInt(i++), 
													rs.getString(i++),  
													rs.getString(i++),
													rs.getString(i++), 
													rs.getString(i++),
													rs.getString(i++),
													rs.getString(i++), 
													rs.getInt(i++),
													rs.getInt(i++));
					list.add(dto);
				}
					System.out.println("4/4 getPagingList success");
				
			} catch (SQLException e) {
				System.out.println("getPagingList fail");
				e.printStackTrace();
			}finally {
				DBClose.close(conn, psmt, rs);
			}
			return list;
		}
////////////////////////////////////////////////////////다운로드 횟수
		
		public void downcount(int seq) {
			String sql = " UPDATE NOTICE " + " SET DOWNCOUNT=DOWNCOUNT+1 " + " WHERE SEQ = ?";
			Connection conn = null; //db를 연결
			PreparedStatement psmt = null; //query문을 실행
			
			try {
				conn = DBConnection.getConnection();
				System.out.println("1/3 downcount success");
				psmt = conn.prepareStatement(sql);
				psmt.setInt(1, seq);
				System.out.println("2/3 downcount success");
				psmt.executeQuery();
				System.out.println("3/3 downcount success");
				
			}catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				DBClose.close(conn, psmt, null);
			}
		}
}
