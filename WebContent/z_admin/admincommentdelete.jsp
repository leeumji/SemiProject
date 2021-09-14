<%@page import="dao.CommentsDao"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
CommentsDao dao = CommentsDao.getInstance();
String[] srenumber = request.getParameterValues("cheack_each");


try{
   int[] renumber = new int[srenumber.length];
      for(int i=0; i < renumber.length; i++) {
         renumber[i] = Integer.parseInt(srenumber[i]);
         dao.deleteComments(renumber[i]); //관리자에 의한 삭제
      }   
%>         
   <script>
      alert("선택한 댓글을 삭제했습니다");
      location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_admin/adminpage&tap=admincommentlist";
   </script>
<%   
}catch(NullPointerException npe) {
%>
   <script>
      alert("삭제할 댓글을 선택하세요");
      location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_admin/adminpage&tap=admincommentlist";
   </script>
<%       
   npe.printStackTrace();
}
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/all.css">
<title>Insert title here</title>
</head>
<body>



</body>
</html>