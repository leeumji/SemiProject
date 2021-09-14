<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
BbsDao dao = BbsDao.getInstance();
String[] sseq = request.getParameterValues("cheack_each");
/*확인용 System.out.println(seq[0]);
System.out.println(seq[1]); */

try{
	int[] seq = new int[sseq.length];
		for(int i=0; i < seq.length; i++) {
			seq[i] = Integer.parseInt(sseq[i]);
			dao.deleteBbsAdmin(seq[i]); //관리자에 의한 삭제
		}	
%>			
	<script>
		alert("게시글이 삭제되었습니다.");
		location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_admin/adminpage&tap=adminbbslist";
	</script>
<%	
}catch(NullPointerException npe) {
%>
	<script>
		alert("삭제할 게시글을 선택하세요");
		location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_admin/adminpage&tap=adminbbslist";
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