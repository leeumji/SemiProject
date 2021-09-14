<%@page import="dao.MemberDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.util.Arrays"%>
    <%@page import="dao.BbsDao" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/all.css">
<title>Insert title here</title>
</head>
<body>
<!-- 게시판리스트에서 선택된 글 삭제  -->
<%

MemberDto mem = (MemberDto)session.getAttribute("login");
String id = mem.getId();
MemberDao mdao = MemberDao.getInstance();
MemberDto dto = mdao.getMember(id);

   String[] sseq = request.getParameterValues("chk");
   
   BbsDao dao = BbsDao.getInstance();
   //int res = dao.multiDelete(sseq);
   
   try{
	   int[]seq = new int[sseq.length];
	   for(int i=0;i<seq.length;i++){
		   seq[i]=Integer.parseInt(sseq[i]);
		   dao.deleteBbs(seq[i]);
		   
	   }
     
%>
   <script type="text/javascript">
      alert(" 게시글을 삭제하였습니다");
       location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_mypage/myfirstpage&tap=mylist&nickname=<%=dto.getNickname()%>";
   </script>
<%
   }catch(NullPointerException npe){
%>
   <script type="text/javascript">
      alert("삭제할 게시글을 선택하세요");
       location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_mypage/myfirstpage&tap=mylist&nickname=<%=dto.getNickname()%>";
   </script>
<%
npe.printStackTrace();
}
%>
</body>
</html>