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

public class BbsDao {

   private static BbsDao dao = null;
   
   private BbsDao() {
      DBConnection.initConnection();
   }
   
   public static BbsDao getInstance() {
      if(dao == null) {
         dao = new BbsDao();
      }      
      return dao;
   }
   
   public List<BbsDto> getBbsList() {
	      
	      String sql = " SELECT * FROM BBS ";
	      
	      Connection conn = null;         // DB 연결
	      PreparedStatement psmt = null;   // Query문을 실행
	      ResultSet rs = null;         // 결과 취득
	      
	      List<BbsDto> list = new ArrayList<BbsDto>();

	      try {
	         conn = DBConnection.getConnection();
	         System.out.println("1/4 getBbsList success");
	         
	         psmt = conn.prepareStatement(sql);
	         System.out.println("2/4 getBbsList success");
	         
	         rs = psmt.executeQuery();
	         System.out.println("3/4 getBbsList success");
	         
	         while(rs.next()) {
	            int i=1;
	            BbsDto dto = new BbsDto(rs.getInt(i++), 
	                              rs.getString(i++),
	                              rs.getString(i++), 
	                              rs.getString(i++),
	                              rs.getString(i++), 
	                              rs.getString(i++), 
	                              rs.getString(i++), 
	                              rs.getString(i++), 
	                              rs.getInt(i++), 
	                              rs.getInt(i++),
	                              rs.getInt(i++));
	            list.add(dto);
	         }
	         System.out.println("4/4 getBbsList success");
	         
	      } catch (SQLException e) {
	         System.out.println("getBbsList fail");
	         e.printStackTrace();
	      } finally {
	         DBClose.close(conn, psmt, rs);
	      }
	      
	      return list;      
	   }
	   
   
   public boolean writeBbs(BbsDto dto) {
   
      String sql = " INSERT INTO BBS (SEQ, NICKNAME, TITLE, CONTENT, CAGO, FILENAME, NEWFILENAME, WDATE, DEL, DOWNCOUNT, READCOUNT) "
               + " VALUES(SEQ_BBS.NEXTVAL, ?, ?, ?, ?, ?, ?, SYSDATE, 0, 0, 0) ";

      
      Connection conn = null;         
      PreparedStatement psmt = null;   
      
      int count = 0;
      
      try {
         conn = DBConnection.getConnection();         
         System.out.println("1/3 writeBbs success");
         System.out.println(dto.getContent());
         psmt = conn.prepareStatement(sql);
         psmt.setString(1, dto.getNickname());
         psmt.setString(2, dto.getTitle());
         psmt.setString(3, dto.getContent());
         psmt.setString(4, dto.getCago());
         psmt.setString(5, dto.getFilename());
         psmt.setString(6, dto.getNewfilename());
         System.out.println("2/3 writeBbs success");
         
         count = psmt.executeUpdate();
         System.out.println("3/3 writeBbs success");
         
      } catch (SQLException e) {
         System.out.println("writeBbs fail");
         e.printStackTrace();
      } finally {
         DBClose.close(conn, psmt, null);
      }
      return count>0?true:false;
   }
   
   public BbsDto getBbs(int seq) {
      
      String sql = " SELECT * "
            + "      FROM BBS "
            + "    WHERE SEQ=? ";
      
      Connection conn = null;         
      PreparedStatement psmt = null;   
      ResultSet rs = null;   
      
      BbsDto dto = null;      
      
      try {
         conn = DBConnection.getConnection();
         System.out.println("1/3 getBbs success");
         
         psmt = conn.prepareStatement(sql);
         psmt.setInt(1, seq);
         System.out.println("2/3 getBbs success");
         
         rs = psmt.executeQuery();   
         if(rs.next()) {
            int i = 1;
            dto = new BbsDto(   rs.getInt(i++), 
	                           rs.getString(i++),
	                           rs.getString(i++), 
	                           rs.getString(i++),
	                           rs.getString(i++), 
	                           rs.getString(i++), 
	                           rs.getString(i++), 
	                           rs.getString(i++), 
	                           rs.getInt(i++), 
	                           rs.getInt(i++),
	                           rs.getInt(i++));
         }   
         System.out.println("3/3 getBbs success");
         
      } catch (SQLException e) {
         System.out.println("getBbs fail");
         e.printStackTrace();
      } finally {
         DBClose.close(conn, psmt, rs);
      }
      
      return dto;
   }
   
   public void readcount(int seq) {
      String sql = " UPDATE BBS "
               + " SET READCOUNT=READCOUNT+1 "
               + " WHERE SEQ=? ";
      
      Connection conn = null;         
      PreparedStatement psmt = null;   
      
      try {
         conn = DBConnection.getConnection();
            
         psmt = conn.prepareStatement(sql);
         psmt.setInt(1, seq);
         
         psmt.executeQuery();
         
      } catch (SQLException e) {         
         e.printStackTrace();
      } finally {
         DBClose.close(conn, psmt, null);
      }      
   }
   
   
   public List<BbsDto> getBbsSearchList(String choice, String search) {
      
      String sql = " SELECT SEQ, NICKNAME, TITLE, CONTENT, CAGO, "
               + "       FILENAME, NEWFILENAME, WDATE, DEL, DOWNCOUNT, READCOUNT "
               + " FROM BBS WHERE DEL=0 ";
      
      String sWord = "";
      if(choice.equals("title")) {
         sWord = " AND TITLE LIKE '%" + search + "%' ";
      }else if(choice.equals("content")) {
         sWord = " AND CONTENT LIKE '%" + search + "%' ";
      }else if(choice.equals("nickname")) {
         sWord = " AND NICKNAME='" + search + "%' ";
      }else if(choice.equals("cago")) {
          sWord = " AND CAGO='" + search + "%' ";
       }        
      sql = sql + sWord;
      
      sql = sql + " ORDER BY SEQ DESC ";
      
    int pageNumber=0;  	
  	int start, end;
	start = 1 + 20 * pageNumber;	// 0 -> 1 ~ 10	1 -> 11 ~ 20
	end = 20 + 20 * pageNumber;	
      
      Connection conn = null;         // DB 연결
      PreparedStatement psmt = null;   // Query문을 실행
      ResultSet rs = null;         // 결과 취득
      
      List<BbsDto> list = new ArrayList<BbsDto>();

      try {
         conn = DBConnection.getConnection();
         System.out.println("1/4 getBbsList success");
         
         psmt = conn.prepareStatement(sql);
         //psmt.setInt(1, start);
 		 //psmt.setInt(2, end);
         System.out.println("2/4 getBbsList success");
         
         rs = psmt.executeQuery();
         System.out.println("3/4 getBbsList success");
         
         while(rs.next()) {
            int i=1;
            BbsDto dto = new BbsDto(rs.getInt(i++), 
                              rs.getString(i++),
                              rs.getString(i++), 
                              rs.getString(i++),
                              rs.getString(i++), 
                              rs.getString(i++), 
                              rs.getString(i++), 
                              rs.getString(i++), 
                              rs.getInt(i++), 
                              rs.getInt(i++),
                              rs.getInt(i++));
            list.add(dto);
         }
         System.out.println("4/4 getBbsList success");
         
      } catch (SQLException e) {
         System.out.println("getBbsList fail");
      } finally {
         DBClose.close(conn, psmt, rs);
      }
      
      return list;      
   }
   
   
   public List<BbsDto> getBbsPagingList(String choice, String search, int pageNumber) {
	      
	      String sql =  " SELECT SEQ, NICKNAME, TITLE, CONTENT, CAGO, "
	               + "       FILENAME, NEWFILENAME, WDATE, DEL, DOWNCOUNT, READCOUNT "
	                + " FROM ";
	      
	      sql += " (SELECT ROW_NUMBER()OVER(ORDER BY SEQ DESC) AS RNUM, SEQ, NICKNAME, "
	              + " TITLE, CONTENT, CAGO, FILENAME, NEWFILENAME, WDATE, DEL, DOWNCOUNT, READCOUNT FROM BBS WHERE DEL=0 ";
	        
	      String sWord = "";
	      
	      if(choice.equals("title")) {
	         sWord = " AND TITLE LIKE '%" + search + "%' ";
	      }else if(choice.equals("content")) {
	         sWord = " AND CONTENT LIKE '%" + search + "%' ";
	      }else if(choice.equals("nickname")) {
	         sWord = " AND NICKNAME='" + search + "' ";
	      }else if(choice.equals("cago")) {
	          sWord = " AND CAGO='" + search + "' ";
	       }         
	      sql = sql + sWord;      
	      
	      sql = sql + " ORDER BY SEQ DESC) ";
	      
	      sql = sql + " WHERE RNUM >= ? AND RNUM <= ? ";
	      
	      int start, end;
	      start = 1 + 20 * pageNumber;   // 0 -> 1 ~ 10   1 -> 11 ~ 20
	      end = 20 + 20 * pageNumber;      
	      
	      Connection conn = null;         // DB     
	      PreparedStatement psmt = null;   // Query         
	      ResultSet rs = null;         //        
	      
	      List<BbsDto> list = new ArrayList<BbsDto>();

	      try {
	         conn = DBConnection.getConnection();
	         System.out.println("1/4 getBbsPagingList success");
	         
	         psmt = conn.prepareStatement(sql);
	         psmt.setInt(1, start);
	         psmt.setInt(2, end);
	         System.out.println("2/4 getBbsPagingList success");
	         
	         rs = psmt.executeQuery();
	         System.out.println("3/4 getBbsPagingList success");
	         
	         while(rs.next()) {
	            int i=1;
	            BbsDto dto = new BbsDto(rs.getInt(i++), 
	                              rs.getString(i++),
	                              rs.getString(i++), 
	                              rs.getString(i++),
	                              rs.getString(i++), 
	                              rs.getString(i++), 
	                              rs.getString(i++), 
	                              rs.getString(i++), 
	                              rs.getInt(i++), 
	                              rs.getInt(i++),
	                              rs.getInt(i++));
	            list.add(dto);
	         }
	         System.out.println("4/4 getBbsPagingList success");
	         
	      } catch (SQLException e) {
	         System.out.println("getBbsList fail");
	         e.printStackTrace();
	      } finally {
	         DBClose.close(conn, psmt, rs);
	      }
	      
	      return list;      
	   }
	   
   
   public boolean updateBbs(int seq, String title, String content, String cago) {
      String sql = " UPDATE BBS SET "
            + " TITLE=?, CONTENT=?, CAGO=? "
            + " WHERE SEQ=? ";
      
      Connection conn = null;
      PreparedStatement psmt = null;
      int count = 0;
      
      try {
         conn = DBConnection.getConnection();
         System.out.println("1/3 S updateBbs");
         
         psmt = conn.prepareStatement(sql);
       
         psmt.setString(1, title);
         psmt.setString(2, content);
         psmt.setString(3, cago);
         psmt.setInt(4, seq);
       
         //psmt.setString(5, newfilename);
         
         System.out.println("2/3 S updateBbs");
        
         count = psmt.executeUpdate();
         System.out.println("3/3 S updateBbs");
         
      } catch (Exception e) {         
         e.printStackTrace();
      } finally{
         DBClose.close(conn, psmt, null);         
      }      
      
      return count>0?true:false;
   }
   
   public boolean updateBbs(String title, String content, String cago, String newfilename, String filename, int iseq) {
	      String sql = " UPDATE BBS SET "
	            + " TITLE=?, CONTENT=?, CAGO=?, NEWFILENAME=?, FILENAME=? "
	            + " WHERE SEQ=? ";
	      
	      Connection conn = null;
	      PreparedStatement psmt = null;
	      int count = 0;
	      
	      try {
	         conn = DBConnection.getConnection();
	         System.out.println("1/3 S updateBbs");
	         
	         psmt = conn.prepareStatement(sql);
	       
	         psmt.setString(1, title);
	         psmt.setString(2, content);
	         psmt.setString(3, cago);
	         psmt.setString(4, newfilename);
	         psmt.setString(5, filename);
	         psmt.setInt(6, iseq);
	       
	         //psmt.setString(5, newfilename);
	         System.out.println("2/3 S updateBbs");
	         
	         count = psmt.executeUpdate();
	         System.out.println("3/3 S updateBbs");
	         
	      } catch (Exception e) {         
	         e.printStackTrace();
	      } finally{
	         DBClose.close(conn, psmt, null);         
	      }      
	      
	      return count>0?true:false;
	   }
   
   public boolean deleteBbs(int seq) {
      
      String sql = " UPDATE BBS SET DEL=9 "
               + " WHERE SEQ=? ";
      
      Connection conn = null;
      PreparedStatement psmt = null;
      int count = 0;
      
      try {
         conn = DBConnection.getConnection();
         System.out.println("1/3 S deleteBbs");
         
         psmt = conn.prepareStatement(sql);
         psmt.setInt(1, seq);
         System.out.println("2/3 S deleteBbs");
         
         count = psmt.executeUpdate();
         System.out.println("3/3 S deleteBbs");
         
      } catch (Exception e) {      
         System.out.println("fail deleteBbs");
         e.printStackTrace();
      } finally {
         DBClose.close(conn, psmt, null);   
      }   
      return count>0?true:false;
   }
   // 6.25 엄지,초희	
 public List<BbsDto> getMainList() {
       
       String sql = " SELECT * FROM BBS WHERE DEL=0 ORDER BY READCOUNT DESC ";
       
       Connection conn = null;         // DB 연결
       PreparedStatement psmt = null;   // Query문을 실행
       ResultSet rs = null;         // 결과 취득
       
       List<BbsDto> list = new ArrayList<BbsDto>();

       try {
          conn = DBConnection.getConnection();
          System.out.println("1/4 getBbsList success");
          
          psmt = conn.prepareStatement(sql);
          System.out.println("2/4 getBbsList success");
          
          rs = psmt.executeQuery();
          System.out.println("3/4 getBbsList success");
          
          while(rs.next()) {
             int i=1;
             BbsDto dto = new BbsDto(rs.getInt(i++), 
                               rs.getString(i++),
                               rs.getString(i++), 
                               rs.getString(i++),
                               rs.getString(i++), 
                               rs.getString(i++), 
                               rs.getString(i++), 
                               rs.getString(i++), 
                               rs.getInt(i++), 
                               rs.getInt(i++),
                               rs.getInt(i++));
             list.add(dto);
          }
          System.out.println("4/4 getBbsList success");
          
       } catch (SQLException e) {
          System.out.println("getBbsList fail");
          e.printStackTrace();
       } finally {
          DBClose.close(conn, psmt, rs);
       }
       
       return list;      
    }
   
   public int multiDelete(String[] seq) {
	      String sql = " DELETE FROM BBS WHERE SEQ=? ";
	      
	       Connection conn = null;
	         PreparedStatement psmt = null;

	         int count[] = null;
	         int res = 0;
	         
	         try {
	            conn = DBConnection.getConnection();
	            System.out.println("1/6multiDelete success");
	            
	            psmt = conn.prepareStatement(sql);
	            System.out.println("2/6multiDelete success");
	            
	            for(int i=0; i<seq.length; i++) {
	               psmt.setString(1, seq[i]);
	               
	               //荑쇰━臾  紐⑤몢  뙎 븘  븳踰덉뿉 泥섎━
	               psmt.addBatch();
	            }
	            System.out.println("3/6multiDelete success");
	            
	            count = psmt.executeBatch();
	            System.out.println("4/6multiDelete success");
	            
	            //荑쇰━ 꽦怨  : -2
	            for(int i=0; i<count.length; i++) {
	               if(count[i] == -2) {
	                  res++;
	               }
	            }
	            System.out.println("5/6multiDelete success");
	            //紐⑥븘 몦 荑쇰━  떎 뻾  걹 굹硫  而ㅻ컠
	            if(seq.length == res) {
	               conn.commit();
	            }else {
	               conn.rollback();
	            }
	            System.out.println("6/6multiDelete success");
	         } catch (SQLException e) {
	            System.out.println("multiDelete fail");
	            e.printStackTrace();
	         } finally {
	            DBClose.close(conn, psmt, null);
	         }
	         return res;
	      }
   
   
   public boolean updateBbs(int seq, String title, String content) {
		String sql = " UPDATE BBS SET "
				+ " TITLE=?, CONTENT=? "
				+ " WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 S updateBbs");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, title);
			psmt.setString(2, content);
			psmt.setInt(3, seq);
			
			System.out.println("2/3 S updateBbs");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 S updateBbs");
			
		} catch (Exception e) {			
			e.printStackTrace();
		} finally{
			DBClose.close(conn, psmt, null);			
		}		
		
		return count>0?true:false;
	}
   //0628 은지수정
   public List<BbsDto> getBbsSearchList(String choice, String search, String cagoselect) {
	      
	      String sql = " SELECT SEQ, NICKNAME, TITLE, CONTENT, CAGO, "
	               + "       FILENAME, NEWFILENAME, WDATE, DEL, DOWNCOUNT, READCOUNT "
	               + " FROM BBS WHERE DEL=0 ";
	      
	      String sWord = "";
	      if(choice.equals("title")) {
	         sWord = " AND TITLE LIKE '%" + search + "%' ";
	      }else if(choice.equals("content")) {
	         sWord = " AND CONTENT LIKE '%" + search + "%' ";
	      }else if(choice.equals("nickname")) {
	         sWord = " AND NICKNAME='" + search + "' ";
	      }else if(choice.equals("cago")) {
	    	 sWord = " AND CAGO LIKE '%" + cagoselect + "%' ";
	      }
	      sql = sql + sWord;
	      
	      sql = sql + " ORDER BY SEQ DESC ";
	      
	      Connection conn = null;         // DB 연결
	      PreparedStatement psmt = null;   // Query문을 실행
	      ResultSet rs = null;         // 결과 취득
	      
	      List<BbsDto> list = new ArrayList<BbsDto>();

	      try {
	         conn = DBConnection.getConnection();
	         System.out.println("1/4 getBbsList success");
	         
	         psmt = conn.prepareStatement(sql);
	         System.out.println("2/4 getBbsList success");
	         
	         rs = psmt.executeQuery();
	         System.out.println("3/4 getBbsList success");
	         
	         while(rs.next()) {
	            int i=1;
	            BbsDto dto = new BbsDto(rs.getInt(i++), 
	                              rs.getString(i++),
	                              rs.getString(i++), 
	                              rs.getString(i++),
	                              rs.getString(i++), 
	                              rs.getString(i++), 
	                              rs.getString(i++), 
	                              rs.getString(i++), 
	                              rs.getInt(i++), 
	                              rs.getInt(i++),
	                              rs.getInt(i++));
	            list.add(dto);
	         }
	         System.out.println("4/4 getBbsList success");
	         
	      } catch (SQLException e) {
	         System.out.println("getBbsList fail");
	      } finally {
	         DBClose.close(conn, psmt, rs);
	      }
	      
	      return list;      
	   }
   
   //0628 bbs
   public List<BbsDto> getBbsPagingList(String choice, String search, String cagoselect, int pageNumber) {
	      
	      String sql =  " SELECT SEQ, NICKNAME, TITLE, CONTENT, CAGO, "
	                + "   FILENAME, NEWFILENAME, WDATE, DEL, DOWNCOUNT, READCOUNT "
	                + " FROM ";
	      
	      sql += " (SELECT ROW_NUMBER()OVER(ORDER BY SEQ DESC) AS RNUM, SEQ, NICKNAME, "
	              + " TITLE, CONTENT, CAGO, FILENAME, NEWFILENAME, WDATE, DEL, DOWNCOUNT, READCOUNT FROM BBS WHERE DEL=0 ";
	        
	      String sWord = "";
	      
	      if(choice.equals("title")) {
	         sWord = " AND TITLE LIKE '%" + search + "%' ";
	      }else if(choice.equals("content")) {
	         sWord = " AND CONTENT LIKE '%" + search + "%' ";
	      }else if(choice.equals("nickname")) {
	         sWord = " AND NICKNAME='" + search + "' ";
	      }else if(choice.equals("cago")) {
	         sWord = " AND CAGO LIKE '%" + cagoselect + "' ";
	       }         
	      sql = sql + sWord;      
	      
	      sql = sql + " ORDER BY SEQ DESC) ";
	      
	      sql = sql + " WHERE RNUM >= ? AND RNUM <= ? ";
	      
	      
	      int start, end;
	    
	      
	      start = 1 + 20 * pageNumber;   // 0 -> 1 ~ 10   1 -> 11 ~ 20
	      end = 20 + 20 * pageNumber;      
	      
	      Connection conn = null;         // DB     
	      PreparedStatement psmt = null;   // Query         
	      ResultSet rs = null;         //        
	      
	      List<BbsDto> list = new ArrayList<BbsDto>();

	      try {
	         conn = DBConnection.getConnection();
	         System.out.println("1/4 getBbsPagingList success");
	         
	         psmt = conn.prepareStatement(sql);
	         psmt.setInt(1, start);
	         psmt.setInt(2, end);
	         System.out.println("2/4 getBbsPagingList success");
	         
	         rs = psmt.executeQuery();
	         System.out.println("3/4 getBbsPagingList success");
	         
	         while(rs.next()) {
	            int i=1;
	            BbsDto dto = new BbsDto(rs.getInt(i++), 
	                              rs.getString(i++),
	                              rs.getString(i++), 
	                              rs.getString(i++),
	                              rs.getString(i++), 
	                              rs.getString(i++), 
	                              rs.getString(i++), 
	                              rs.getString(i++), 
	                              rs.getInt(i++), 
	                              rs.getInt(i++),
	                              rs.getInt(i++));
	            list.add(dto);
	         }
	         System.out.println("4/4 getBbsPagingList success");
	         
	      } catch (SQLException e) {
	         System.out.println("getBbsList fail");
	         e.printStackTrace();
	      } finally {
	         DBClose.close(conn, psmt, rs);
	      }
	      
	      return list;      
	   }
   
   //0628 은지수정 관리자에의한 삭제
   public boolean deleteBbsAdmin(int seq) {
	      
	      String sql = " UPDATE BBS "
	    		   + " SET DEL=DEL+1 "
	               + " WHERE SEQ=? ";
	      
	      Connection conn = null;
	      PreparedStatement psmt = null;
	      int count = 0;
	      
	      try {
	         conn = DBConnection.getConnection();
	         System.out.println("1/3 S deleteBbsAdmin");
	         
	         psmt = conn.prepareStatement(sql);
	         psmt.setInt(1, seq);
	         System.out.println("2/3 S deleteBbsAdmin");
	         
	         count = psmt.executeUpdate();
	         System.out.println("3/3 S deleteBbsAdmin");
	         
	      } catch (Exception e) {      
	         System.out.println("fail deleteBbsAdmin");
	         e.printStackTrace();
	      } finally {
	         DBClose.close(conn, psmt, null);   
	      }   
	      return count>0?true:false;
	   }
   //0630 은희 내 게시글 수 불러오기 
   public int getMyBbs(String choice, String search,String nickname) {
         
         String sql = " SELECT COUNT(*) FROM BBS WHERE NICKNAME=? AND DEL=0 ";
         
         /*
         String sWord = "";
         if(choice.equals("title")) {
            sWord = " AND TITLE LIKE '%" + search + "%' ";
         }else if(choice.equals("content")) {
            sWord = " AND CONTENT LIKE '%" + search + "%' ";
         }  
         sql = sql + sWord;
         */
         Connection conn = null;         // DB  뜝 럥 뿼 뇦猿볦삕
         PreparedStatement psmt = null;   // Query占쎈닱筌뤾쑴諭   뜝 럥堉꾢뜝 럥六 
         ResultSet rs = null;         //  뇦猿됲 쀯옙沅  占쎈퓛占쎈 獄 占 
         
         int len = 0;
         
         try {
            conn = DBConnection.getConnection();
            System.out.println("1/3 getMyBbs success");
            
            psmt = conn.prepareStatement(sql);
            psmt.setString(1, nickname);
            System.out.println("2/3 getMyBbs success");
         
            rs = psmt.executeQuery();
            if(rs.next()) {
               len = rs.getInt(1);
            }
            System.out.println("3/3 getMyBbs success");
            
         } catch (SQLException e) {
            System.out.println("getMyBbs fail");
            e.printStackTrace();
         } finally {
            DBClose.close(conn, psmt, rs);
         }
         
         return len;
      }
   
   //0630 은희 mypage 
   public List<BbsDto> getMyBbsPagingList(String choice, String search, String cagoselect, int pageNumber,String nickname) {
         
         String sql =  " SELECT SEQ, NICKNAME, TITLE, CONTENT, CAGO, "
                   + "   FILENAME, NEWFILENAME, WDATE, DEL, DOWNCOUNT, READCOUNT "
                   + " FROM ";
         
         sql += " (SELECT ROW_NUMBER()OVER(ORDER BY SEQ DESC) AS RNUM, SEQ, NICKNAME, "
                 + " TITLE, CONTENT, CAGO, FILENAME, NEWFILENAME, WDATE, DEL, DOWNCOUNT, READCOUNT FROM BBS WHERE NICKNAME=? AND DEL=0 ";
           
         String sWord = "";
         
         if(choice.equals("title")) {
            sWord = " AND TITLE LIKE '%" + search + "%' ";
         }else if(choice.equals("content")) {
            sWord = " AND CONTENT LIKE '%" + search + "%' ";
         }else if(choice.equals("cago")) {
            sWord = " AND CAGO LIKE '%" + cagoselect + "' ";
          }         
         sql = sql + sWord;      
         
         sql = sql + " ORDER BY SEQ DESC) ";
         
         sql = sql + " WHERE RNUM >= ? AND RNUM <= ? ";
         
         int start, end;
       
         
         start = 1 + 20 * pageNumber;   // 0 -> 1 ~ 10   1 -> 11 ~ 20
         end = 20 + 20 * pageNumber;      
         
         Connection conn = null;         // DB     
         PreparedStatement psmt = null;   // Query         
         ResultSet rs = null;         //        
         
         List<BbsDto> list = new ArrayList<BbsDto>();

         try {
            conn = DBConnection.getConnection();
            System.out.println("1/4 getMyBbsPagingList success");
            
            psmt = conn.prepareStatement(sql);
            psmt.setString(1,nickname);
            psmt.setInt(2, start);
            psmt.setInt(3, end);
         
            System.out.println("2/4 getMyBbsPagingList success");
            
            rs = psmt.executeQuery();
            System.out.println("3/4 getMyBbsPagingList success");
            
            while(rs.next()) {
               int i=1;
               BbsDto dto = new BbsDto(rs.getInt(i++), 
                                 rs.getString(i++),
                                 rs.getString(i++), 
                                 rs.getString(i++),
                                 rs.getString(i++), 
                                 rs.getString(i++), 
                                 rs.getString(i++), 
                                 rs.getString(i++), 
                                 rs.getInt(i++), 
                                 rs.getInt(i++),
                                 rs.getInt(i++));
               list.add(dto);
            }
            System.out.println("4/4 getMyBbsPagingList success");
            
         } catch (SQLException e) {
            System.out.println("getMyBbsList fail");
            e.printStackTrace();
         } finally {
            DBClose.close(conn, psmt, rs);
         }
         
         return list;      
      }

   public String getWriter(int seq) {
       
       String sql = " SELECT NICKNAME FROM BBS WHERE SEQ=? AND DEL=0 ";
       
       Connection conn = null;         // DB 연결
       PreparedStatement psmt = null;   // Query문을 실행
       ResultSet rs = null;         // 결과 취득
       
       String writerNickname = "";

       try {
          conn = DBConnection.getConnection();
          System.out.println("1/4 getWriter success");
          
          psmt = conn.prepareStatement(sql);
          psmt.setInt(1, seq);
          System.out.println("2/4 getWriter success");
          
          rs = psmt.executeQuery();
          System.out.println("3/4 getWriter success");
          
          if(rs.next()) {
        	  writerNickname = rs.getString(1);
          }
          System.out.println("4/4 getWriter success");
          
       } catch (SQLException e) {
          System.out.println("getBbsList fail");
          e.printStackTrace();
       } finally {
          DBClose.close(conn, psmt, rs);
       }
       
       return writerNickname;      
    }
   
   // 글의 총수
   public int getAllBbs(String choice, String search) {
      
      String sql = " SELECT COUNT(*) FROM BBS WHERE DEL=0 ";
      
      String sWord = "";
      if(choice.equals("title")) {
         sWord = " AND TITLE LIKE '%" + search + "%' ";
      }else if(choice.equals("content")) {
         sWord = " AND CONTENT LIKE '%" + search + "%' ";
      }else if(choice.equals("writer")) {
         sWord = " AND ID='" + search + "' ";
      }      
      sql = sql + sWord;
      
      Connection conn = null;         // DB 연결
      PreparedStatement psmt = null;   // Query문을 실행
      ResultSet rs = null;         // 결과 취득
      
      int len = 0;
      
      try {
         conn = DBConnection.getConnection();
         System.out.println("1/3 getAllBbs success");
         
         psmt = conn.prepareStatement(sql);
         System.out.println("2/3 getAllBbs success");
         
         rs = psmt.executeQuery();
         if(rs.next()) {
            len = rs.getInt(1);
         }
         System.out.println("3/3 getAllBbs success");
         
      } catch (SQLException e) {
         System.out.println("getAllBbs fail");
         e.printStackTrace();
      } finally {
         DBClose.close(conn, psmt, rs);
      }
      
      return len;
   }
   
   
   // 글의 총수 (오버로딩 - 은지 수정 0630)
   public int getAllBbs(String choice, String search, String cagoselect) {
      
      String sql = " SELECT COUNT(*) FROM BBS WHERE DEL=0 ";
      
      String sWord = "";
      if(choice.equals("title")) {
         sWord = " AND TITLE LIKE '%" + search + "%' ";
      }else if(choice.equals("content")) {
         sWord = " AND CONTENT LIKE '%" + search + "%' ";
      }else if(choice.equals("nickname")) {
         sWord = " AND NICKNAME='" + search + "' ";
      }else if(choice.equals("cago")) {
         sWord = " AND CAGO='" + cagoselect + "' ";
      }       
      sql = sql + sWord;
      
      Connection conn = null;         // DB 연결
      PreparedStatement psmt = null;   // Query문을 실행
      ResultSet rs = null;         // 결과 취득
      
      int len = 0;
      
      try {
         conn = DBConnection.getConnection();
         System.out.println("1/3 getAllBbs success");
         
         psmt = conn.prepareStatement(sql);
         System.out.println("2/3 getAllBbs success");
         
         rs = psmt.executeQuery();
         if(rs.next()) {
            len = rs.getInt(1);
         }
         System.out.println("3/3 getAllBbs success");
         
      } catch (SQLException e) {
         System.out.println("getAllBbs fail");
         e.printStackTrace();
      } finally {
         DBClose.close(conn, psmt, rs);
      }
      
      return len;
   }
   //0701 은희 
   public boolean deleteMylist(int seq) {
         
	   String sql = " UPDATE BBS SET DEL=9 "
               + " WHERE SEQ=? ";
         
         Connection conn = null;
         PreparedStatement psmt = null;
         int count = 0;
         
         try {
            conn = DBConnection.getConnection();
            System.out.println("1/3 S deleteBbsMylist");
            
            psmt = conn.prepareStatement(sql);
            psmt.setInt(1, seq);
            System.out.println("2/3 S deleteBbsMylist");
            
            count = psmt.executeUpdate();
            System.out.println("3/3 S deleteBbsMylist");
            
         } catch (Exception e) {      
            System.out.println("fail deleteBbsMylist");
            e.printStackTrace();
         } finally {
            DBClose.close(conn, psmt, null);   
         }   
         return count>0?true:false;
      }
}


