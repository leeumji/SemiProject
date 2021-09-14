package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.CommentsDto;

public class CommentsDao {
	

	   private static CommentsDao dao = null;
	   
	   
	   
	   private CommentsDao() {
	      DBConnection.initConnection();
	   }
	   
	   public static CommentsDao getInstance() {
	      if(dao == null) {
	         dao = new CommentsDao();
	      }      
	      return dao;
	   }
	
	
	   public List<CommentsDto> getCommentsList(int seq) {
		      
		      String sql = " SELECT * FROM COMMENTS WHERE SEQ=? ORDER BY WDATE ASC ";
		      
		      Connection conn = null;         // DB 연결
		      PreparedStatement psmt = null;   // Query문을 실행
		      ResultSet rs = null;         // 결과 취득
		      
		      List<CommentsDto> list = new ArrayList<CommentsDto>();

		      try {
		         conn = DBConnection.getConnection();
		         System.out.println("1/4 getBbsList success");
		         
		         psmt = conn.prepareStatement(sql);
		         System.out.println("2/4 getBbsList success");
		         psmt.setInt(1, seq);
		         
		         rs = psmt.executeQuery();
		         System.out.println("3/4 getBbsList success");
		         
		         while(rs.next()) {
		            int i=1;
		            CommentsDto dto = new CommentsDto(rs.getInt(i++), 
		                              				  rs.getString(i++),
		                              				  rs.getString(i++), 
		                              				  rs.getInt(i++),
		                              				  rs.getString(i++));
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
	   
	   
	   public boolean writeComments(CommentsDto dto) {
		   	System.out.println(dto.toString());
		      String sql = " INSERT INTO COMMENTS "
		               + " VALUES(SEQ_COMMENTS.NEXTVAL, ?, SYSDATE, ?, ?) ";

		      
		      Connection conn = null;         
		      PreparedStatement psmt = null;   
		      
		      int count = 0;
		      
		      try {
		         conn = DBConnection.getConnection();         
		         System.out.println("1/3 writeBbs success");
		         
		         psmt = conn.prepareStatement(sql);
		         psmt.setString(1, dto.getNickname());
		         psmt.setInt(2, dto.getSeq());
		         psmt.setString(3, dto.getContent());
		         
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
	   
	    // 엄지
	      public boolean updateComments(int renumber, String content) {
	          String sql = " UPDATE COMMENTS SET "
	                   + " CONTENT=? "
	                   + " WHERE RENUMBER=? ";
	          
	          Connection conn = null;
	          PreparedStatement psmt = null;
	          int count = 0;
	          
	          try {
	             conn = DBConnection.getConnection();
	             System.out.println("1/3 updateComm SSS");
	             
	             psmt = conn.prepareStatement(sql);
	             psmt.setString(1, content);
	             psmt.setInt(2, renumber);
	             
	             System.out.println("2/3 updateComm SSS");
	             
	             count = psmt.executeUpdate();
	             System.out.println("3/3 updateComm SSS");
	             
	          } catch (SQLException e) {
	             e.printStackTrace();
	          } finally {
	             DBClose.close(conn, psmt, null);
	          }
	          
	          return count>0;
	          
	       }
	      
	      public boolean deleteComments(int renumber) {
	          String sql = " DELETE COMMENTS WHERE RENUMBER=? ";
	          
	          Connection conn = null;
	          PreparedStatement psmt = null;
	          int count = 0;
	          
	          try {
	             conn = DBConnection.getConnection();
	             System.out.println("1/3 deleteComments SSS");
	             
	             psmt = conn.prepareStatement(sql);
	             psmt.setInt(1, renumber);
	             System.out.println("2/3 deleteComments SSS");
	             
	             count = psmt.executeUpdate();
	             System.out.println("3/3 deleteComments SSS");
	          } catch (SQLException e) {
	             e.printStackTrace();
	          } finally {
	             DBClose.close(conn, psmt, null);
	          }
	          
	          return count>0;
	          
	       }
	      
	      public  List<CommentsDto> selectComments(int renumber) {
	          String sql = " SELECT * FROM COMMENTS WHERE RENUMBER=? ";
		      
		      Connection conn = null;         // DB 연결
		      PreparedStatement psmt = null;   // Query문을 실행
		      ResultSet rs = null;         // 결과 취득
		      
		      List<CommentsDto> list = new ArrayList<CommentsDto>();

		      try {
		         conn = DBConnection.getConnection();
		         System.out.println("1/4 getBbsList success");
		         
		         psmt = conn.prepareStatement(sql);
		         System.out.println("2/4 getBbsList success");
		         psmt.setInt(1, renumber);
		         
		         rs = psmt.executeQuery();
		         System.out.println("3/4 getBbsList success");
		         
		         while(rs.next()) {
		            int i=1;
		            CommentsDto dto = new CommentsDto(rs.getInt(i++), 
		                              				  rs.getString(i++),
		                              				  rs.getString(i++), 
		                              				  rs.getInt(i++),
		                              				  rs.getString(i++));
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
	      
	      
	         /////////// 댓글수 불러오기///////////////
	         public int commentsCount(int seq) {
	            
	            String sql = " SELECT COUNT(*) FROM COMMENTS WHERE SEQ=? ";
	            
	            Connection conn = null;         // DB 연결
	            PreparedStatement psmt = null;   // Query문을 실행
	            ResultSet rs = null;         // 결과 취득
	            
	            int count = 0;
	            
	            try {
	             conn = DBConnection.getConnection();
	             System.out.println("1/3 commentsCount success");
	            psmt = conn.prepareStatement(sql);
	            psmt.setInt(1, seq);
	            System.out.println("2/3 commentsCount success");
	            rs = psmt.executeQuery();
	            if(rs.next()) {
	               count = rs.getInt(1);
	            }
	            System.out.println("3/3 commentsCount success");
	         } catch (SQLException e) {
	            System.out.println(" commentsCount fail");
	            e.printStackTrace();
	         } finally {
	            DBClose.close(conn, psmt, rs);
	         }
	            return count;
	         }
	            
	            
	      
	      //0630 은지 모든 댓글 불러오기
	      public List<CommentsDto> getAllCommentsList() {
		      
		      String sql = " SELECT * FROM COMMENTS ORDER BY WDATE ASC ";
		      
		      Connection conn = null;         // DB 연결
		      PreparedStatement psmt = null;   // Query문을 실행
		      ResultSet rs = null;         // 결과 취득
		      
		      List<CommentsDto> list = new ArrayList<CommentsDto>();

		      try {
		         conn = DBConnection.getConnection();
		         System.out.println("1/4 getAllCommentsList success");
		         
		         psmt = conn.prepareStatement(sql);
		         System.out.println("2/4 getAllCommentsList success");
		         
		         rs = psmt.executeQuery();
		         System.out.println("3/4 getAllCommentsList success");
		         
		         while(rs.next()) {
		            int i=1;
		            CommentsDto dto = new CommentsDto(rs.getInt(i++), 
		                              				  rs.getString(i++),
		                              				  rs.getString(i++), 
		                              				  rs.getInt(i++),
		                              				  rs.getString(i++));
		            list.add(dto);
		         }
		         System.out.println("4/4 getAllCommentsList success");
		         
		      } catch (SQLException e) {
		         System.out.println("getAllCommentsList fail");
		         e.printStackTrace();
		      } finally {
		         DBClose.close(conn, psmt, rs);
		      }
		      
		      return list;      
		   }
	    //
	      public List<CommentsDto> getCommentsPagingList(String choice, String search, int pageNumber) {
		      
		      String sql =  " SELECT RENUMBER, NICKNAME, WDATE, SEQ, CONTENT "
		                + " FROM ";
		      
		      sql += " (SELECT ROW_NUMBER()OVER(ORDER BY RENUMBER DESC) AS RNUM, RENUMBER, NICKNAME, "
		              + " WDATE, SEQ, CONTENT FROM COMMENTS ";
		        
		      String sWord = "";
		      
		      if(choice.equals("content")) {
		         sWord = " WHERE CONTENT LIKE '%" + search + "%' ";
		      }else if(choice.equals("nickname")) {
		         sWord = " WHERE NICKNAME='" + search + "' ";
		      }
		      sql = sql + sWord;      
		      
		      sql = sql + " ORDER BY SEQ DESC) ";
		      
		      sql = sql + " WHERE RNUM >= ? AND RNUM <= ? ";
		      
		      int start, end;
		    
		      
		      start = 1 + 10 * pageNumber;   // 0 -> 1 ~ 10   1 -> 11 ~ 20
		      end = 10 + 10 * pageNumber;      
		      
		      Connection conn = null;         // DB     
		      PreparedStatement psmt = null;   // Query         
		      ResultSet rs = null;         //        
		      
		      List<CommentsDto> list = new ArrayList<CommentsDto>();

		      try {
		         conn = DBConnection.getConnection();
		         System.out.println("1/4 getCommentsPagingList success");
		         
		         psmt = conn.prepareStatement(sql);
		         psmt.setInt(1, start);
		         psmt.setInt(2, end);
		         System.out.println("2/4 getCommentsPagingList success");
		         
		         rs = psmt.executeQuery();
		         System.out.println("3/4 getCommentsPagingList success");
		         
		         while(rs.next()) {
		            int i=1;
		            CommentsDto dto = new CommentsDto(rs.getInt(i++), 
						            				  rs.getString(i++),
						            				  rs.getString(i++), 
						            				  rs.getInt(i++),
						            				  rs.getString(i++));
		            list.add(dto);
		         }
		         System.out.println("4/4 getCommentsPagingList success");
		         
		      } catch (SQLException e) {
		         System.out.println("getCommentsPagingList fail");
		         e.printStackTrace();
		      } finally {
		         DBClose.close(conn, psmt, rs);
		      }
		      
		      return list;      
		   }   
	    //0630 은지수정 관리자에의한 삭제
	      public boolean deleteCommentAdmin(int renumber) {
	   	      
	   	      String sql = " UPDATE COMMENTS "
	   	    		   + " SET WDATE=0000-00-00 00:00:00.0 "
	   	               + " WHERE RENUMBER=? ";
	   	      
	   	      Connection conn = null;
	   	      PreparedStatement psmt = null;
	   	      int count = 0;
	   	      
	   	      try {
	   	         conn = DBConnection.getConnection();
	   	         System.out.println("1/3 S deleteCommentAdmin");
	   	         
	   	         psmt = conn.prepareStatement(sql);
	   	         psmt.setInt(1, renumber);
	   	         System.out.println("2/3 S deleteCommentAdmin");
	   	         
	   	         count = psmt.executeUpdate();
	   	         System.out.println("3/3 S deleteCommentAdmin");
	   	         
	   	      } catch (Exception e) {      
	   	         System.out.println("fail deleteCommentAdmin");
	   	         e.printStackTrace();
	   	      } finally {
	   	         DBClose.close(conn, psmt, null);   
	   	      }   
	   	      return count>0?true:false;
	   	   }
	      ///0630 은희 선택 삭제 
          public int multicommentDelete(String[] seq) {
             String sql = " DELETE FROM COMMENTS WHERE SEQ=? ";
             
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
                      
                      // 뜎 눖 봺 눧  榮먥뫀紐    솊 釉   釉녘린 뜆肉  力μ꼶 봺
                      psmt.addBatch();
                   }
                   System.out.println("3/6multiDelete success");
                   
                   count = psmt.executeBatch();
                   System.out.println("4/6multiDelete success");
                   
                   // 뜎 눖 봺 苑     : -2
                   for(int i=0; i<count.length; i++) {
                      if(count[i] == -2) {
                         res++;
                      }
                   }
                   System.out.println("5/6multiDelete success");
                   //榮먥뫁釉  紐   뜎 눖 봺   뼄 六   嫄  援밭∥   뚣끇而 
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
          // 0630 은희 내 댓글 리스트 불러오기
          public List<CommentsDto> getMyCommentsPagingList(String choice, String search, int pageNumber,String nickname) {
              
             System.out.println("nickname:" + nickname);
             System.out.println("search:" + search);
             System.out.println("pageNumber:" + pageNumber);
             
              String sql =  " SELECT RENUMBER, NICKNAME, WDATE, SEQ, CONTENT "
                        + " FROM ";
              
              sql += " (SELECT ROW_NUMBER()OVER(ORDER BY RENUMBER DESC) AS RNUM, RENUMBER, NICKNAME, "
                      + " WDATE, SEQ, CONTENT FROM COMMENTS WHERE NICKNAME=? ";
                
              String sWord = "";
              
              if(choice.equals("content")) {
                 sWord = " AND CONTENT LIKE '%" + search + "%' ";
              }
              sql = sql + sWord;      
              
              sql = sql + " ORDER BY SEQ DESC) ";
              
              sql = sql + " WHERE RNUM >= ? AND RNUM <= ? ";
              
              int start, end;
            
              
              start = 1 + 10 * pageNumber;   // 0 -> 1 ~ 10   1 -> 11 ~ 20
              end = 10 + 10 * pageNumber;      
              
              Connection conn = null;         // DB     
              PreparedStatement psmt = null;   // Query         
              ResultSet rs = null;         //        
              
              List<CommentsDto> list = new ArrayList<CommentsDto>();

              try {
                 conn = DBConnection.getConnection();
                 System.out.println("1/4 getMyCommentsPagingList success");
                 
                 psmt = conn.prepareStatement(sql);
                 psmt.setString(1, nickname);
                 psmt.setInt(2, start);
                 psmt.setInt(3, end);
                 
                 System.out.println("2/4 getMyCommentsPagingList success");
                 
                 rs = psmt.executeQuery();
                 System.out.println("3/4 getMyCommentsPagingList success");
                 
                 while(rs.next()) {
                    int i=1;
                    CommentsDto dto = new CommentsDto(rs.getInt(i++), 
                                              rs.getString(i++),
                                              rs.getString(i++), 
                                              rs.getInt(i++),
                                              rs.getString(i++));
                    System.out.println("----------------------");
                    System.out.println(dto.toString());
                    System.out.println("----------------------");
                    list.add(dto);
                 }
                 System.out.println("4/4 getMyCommentsPagingList success");
                 
              } catch (SQLException e) {
                 System.out.println("getMyCommentsPagingList fail");
                 e.printStackTrace();
              } finally {
                 DBClose.close(conn, psmt, rs);
              }
              
              return list;      
           }
          /////////// 0630 은희 내 댓글 수 가져오기  
          
          public int MycommentsCount(String nickname) {
          
          String sql = " SELECT COUNT(*) FROM COMMENTS WHERE NICKNAME=? ";
          
          Connection conn = null; // DB  뿰寃  
          PreparedStatement psmt = null; // Query臾몄쓣
          ResultSet rs = null; // 寃곌낵 痍⑤뱷
          
          int count = 0;
          
          try { conn = DBConnection.getConnection();
          System.out.println("1/3 commentsCount success"); 
          psmt =conn.prepareStatement(sql); 
          psmt.setString(1, nickname);
          System.out.println("2/3 commentsCount success"); 
          rs = psmt.executeQuery();
          if(rs.next()) { 
             count = rs.getInt(1); 
             }
          System.out.println("3/3 commentsCount success");
          } 
          catch (SQLException e) {
          System.out.println(" commentsCount fail"); 
          e.printStackTrace();
          } 
          finally {
          DBClose.close(conn, psmt, rs); } return count; }
        //0630 은지 모든 댓글 불러오기(관리자페이지에 쓸것)
          public int getAllCommentsList(String choice, String search) {
             
             String sql = " SELECT COUNT(*) FROM COMMENTS ";
             
             String sWord = "";
             if(choice.equals("content")) {
                sWord = " WHERE CONTENT LIKE '%" + search.trim() + "%' ";
             }else if(choice.equals("nickname")) {
                sWord = " WHERE NICKNAME='" + search.trim() + "' ";
             }
             
             sql = sql + sWord;
             sql = sql + " ORDER BY WDATE ASC ";
             int len = 0;
             
             Connection conn = null;         // DB 연결
             PreparedStatement psmt = null;   // Query문을 실행
             ResultSet rs = null;         // 결과 취득

             try {
                conn = DBConnection.getConnection();
                System.out.println("1/3 getAllCommentsList success");
                
                psmt = conn.prepareStatement(sql);
                System.out.println("2/3 getAllCommentsList success");
                
                rs = psmt.executeQuery();
                if(rs.next()) {
                   len = rs.getInt(1);
                }
                System.out.println("3/3 getAllCommentsList success");
                
             } catch (SQLException e) {
                System.out.println("getAllCommentsList fail");
                e.printStackTrace();
             } finally {
                DBClose.close(conn, psmt, rs);
             }
             
             return len;      
          }          
          
}
