<%@page import="dao.MemberDao"%>
<%@page import="dto.MemberDto"%>
<%@page import="dao.CommentsDao"%>
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
<% 
MemberDto mem = (MemberDto)session.getAttribute("login");
String id = mem.getId();
MemberDao mdao = MemberDao.getInstance();
MemberDto dto = mdao.getMember(id);
%>
</head>
<body>
<!-- 게시판리스트에서 선택된 글 삭제  -->
<%
	String[] seq = request.getParameterValues("chk");
	
	CommentsDao dao = CommentsDao.getInstance();
	
	try{
		int[]renumber = new int[seq.length];
		for(int i=0;i<renumber.length;i++){
			renumber[i]=Integer.parseInt(seq[i]);
			dao.deleteComments(renumber[i]);
		}
			
%>
	<script type="text/javascript">
		alert("댓글을 삭제했습니다. ");
		 location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_mypage/myfirstpage&tap=mycommentlist&nickname=<%=dto.getNickname()%>";
	</script>
<%
	}catch(NullPointerException npe){
%>
	<script type="text/javascript">
		alert("댓글을 선택하세요. ");
		 location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_mypage/myfirstpage&tap=mycommentlist&nickname=<%=dto.getNickname()%>";
	</script>
<%
	npe.printStackTrace();
}
%>
</body>
</html>