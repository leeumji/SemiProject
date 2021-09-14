<%@page import="dao.MemberDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
  
<%

String id = request.getParameter("id");
String pwd = request.getParameter("pwd");

MemberDao dao = MemberDao.getInstance();
MemberDto dto = dao.login(id, pwd);
boolean isS = dao.deleteMember(id, pwd);

if(isS==true) {
	
%>
<%
session.invalidate();

%>    
   <script>
      alert("언제든지 다시 찾아와주세요>_<");
      location.href = "<%=request.getContextPath() %>/logout.jsp";
      //탈퇴시 메인화면으로 이동 
   </script>
<% 
}else {
%>   
   <script>
   alert("실패하였습니다");
   location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_mypage/myfirstpage&tap=mypage";
   </script>
<%    
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

