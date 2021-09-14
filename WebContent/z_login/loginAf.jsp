
<%@page import="dto.MemberDto"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String id = request.getParameter("id");
String pwd = request.getParameter("pwd");
System.out.println("id : " + id);
System.out.println("pwd : " + pwd);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
MemberDao dao = MemberDao.getInstance();
// 쿼리문 실행을 위해 id와 pwd로 셋팅한 Dto를 파라미터로 보낸다.
MemberDto dto = dao.login(id, pwd);


if(dto != null && !dto.getId().equals("")){
	// session에 dto를 저장한다. 
	session.setAttribute("login", dto);
%>
	<script type="text/javascript">
	location.href="../index.jsp";
	</script>
<%
}else{
%>
	<script type="text/javascript">
	alert("id나 pw를 확인해주세요");
	location.href = "login.jsp"
	</script>
<%
}
%>



</body>
</html>