<%@page import="dao.MemberDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    MemberDto mem = (MemberDto)session.getAttribute("login");
    String id = mem.getId();
    MemberDao dao = MemberDao.getInstance();
    MemberDto dto = dao.getMember(id);
    %>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/all.css">
<meta charset="UTF-8">
<style type="text/css">
#mypage2 {
	width: 700px;
  	height: 550px;
  	padding-left: 50px;
}
h1{
color:orange;
/* font-weight:bold; */
font-family: 'Black Han Sans', sans-serif;
}

</style>
<title>Insert title here</title>
</head>
<body>
<br><br><br><br>
<h1 align="center">안녕하세요.&nbsp; <%=dto.getNickname() %>님의 페이지 입니다. </h1>
<img id="mypage2" alt="" src="image/mypage2.png">
</body>
</html>