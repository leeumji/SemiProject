<%@page import="dto.QnaDto"%>
<%@page import="dao.QnaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>    

<%
int seq = Integer.parseInt(request.getParameter("seq"));
String nickname = request.getParameter("nickname");
String title = request.getParameter("title");
String content = request.getParameter("content");
%>
       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/all.css">
<title>Insert title here</title>
</head>
<body>

<%
QnaDao dao = QnaDao.getInstance();
boolean isSuccess = dao.qnaAnswer(seq, new QnaDto(nickname, title, content));
if(isSuccess){
%>
<script type="text/javascript">
alert("작성이 완료되었습니다.");
location.href ="<%=request.getContextPath()%>/index.jsp?toss=z_qna/qnalist";
</script>
<%
}else{
%>
<script type="text/javascript">
alert("다시 작성해주세요.");
location.href = "<%=request.getContextPath()%>/index.jsp?toss=z_qna/qnalist";
</script>
<%
}
%>