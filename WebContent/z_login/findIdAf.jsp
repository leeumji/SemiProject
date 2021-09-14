
<%@page import="dto.MemberDto"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String nickname = request.getParameter("nickname");
String email = request.getParameter("email");
System.out.println("nickname :  "+ nickname);
System.out.println("email :  "+ email);

MemberDao dao = MemberDao.getInstance();
MemberDto dto = dao.findId(nickname, email);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>
<div align="center" class="container" style="width:100%; height: 60px; border: 1px solid #808080;">
<%try{
	if(dto.getId() == null){ %>
}
<%} else {%>
	<h5>당신의 아이디는 '<%=dto.getId() %>' 입니다.</h5>
	<%} 
}catch (NullPointerException ne){	%>
	<h5>아이디가 존재하지 않습니다.</h5>
<%} %>
<br><br>
<input type="button" class="btn btn-secondary" style='width:70px; font-size: 13px; padding: 3px 3px 3px 3px;' value="닫기" onclick="window.close()">
</div>
</body>
</html>