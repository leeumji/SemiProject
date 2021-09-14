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
%>

	<% 
String title =  request.getParameter("title");
System.out.println("title: " + title);
String content = request.getParameter("content");
System.out.println("content: " + content);
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq.trim());
System.out.println("seq: " + seq);
%>

	<%
QnaDao dao = QnaDao.getInstance();
QnaDto qna = dao.getQnaInfo(seq);
boolean result = dao.updateQna(title, content, seq);
if(result==true){
	%>
	<script type="text/javascript">
		alert("수정이 완료되었습니다");
		location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_qna/qnalist";
		</script>
	<%
	}else{
	%>
	<script type="text/javascript">
		alert("다시 작성해주세요");
		location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_qna/qnadetail&seq=<%=qna.getSeq()%>";
		</script>
	<%
	}
	%>
</body>
</html>