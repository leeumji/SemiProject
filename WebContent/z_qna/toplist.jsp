<%@page import="java.net.URLEncoder"%>
<%@page import="dto.QnaDto"%>
<%@page import="dao.QnaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/all.css">
<title>Insert title here</title>
</head>
<body>

<% 
request.setCharacterEncoding("utf-8");

String nickname = request.getParameter("nickname");
System.out.println("nickname: " + nickname);
String title = request.getParameter("title");
System.out.println("title: " + title);
String content = request.getParameter("content");
System.out.println("content: " + content);
%>

	<%
QnaDao dao = QnaDao.getInstance();
boolean result = dao.notice(new QnaDto(nickname, title, content));
if(result==true){
	%>
	<script type="text/javascript">
		alert("작성이 완료되었습니다");
		location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_qna/qnalist";
		</script>
	<%
	}else{
	%>
	<script type="text/javascript">
		alert("다시 작성해주세요");
		location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_qna/writeqna";
		</script>
	<%
	}
	%>
</body>
</html>