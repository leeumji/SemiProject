<%@page import="dao.MemberDao"%>
<%@page import="java.util.Arrays"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
String[] id = request.getParameterValues("id");
System.out.println(Arrays.toString(id));
try{
	MemberDao dao = MemberDao.getInstance();
	boolean s = false;
	for(int i=0; i < id.length; i++) {
		s = dao.deleteMember(id[i]); //관리자에 의한 삭제
	}	
	
	if(s == true) {%>
		<script>
			alert("체크한 회원 탈퇴 성공");
			location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_admin/adminpage&tap=adminmemberlist";
		</script>
	<% 
	}else {
	%>	
		<script>
		alert("체크한 회원 탈퇴 실패");
		location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_admin/adminpage&tap=adminmemberlist";
		</script>
	<% 	
	}
	
}catch(NullPointerException npe) {
%>
	<script>
		alert("탈퇴할 회원을 선택하세요");
		location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_admin/adminpage&tap=adminmemberlist";
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