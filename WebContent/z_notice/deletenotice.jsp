<%@page import="dto.NoticeDto"%>
<%@page import="dao.NoticeDao"%>
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
	String sseq = request.getParameter("seq");
	int seq = Integer.parseInt(sseq.trim());
	System.out.println("seq: " + seq);
	%>
	<%
	NoticeDao dao = NoticeDao.getInstance();
	NoticeDto not = dao.getNoticeInfo(seq);
	boolean result = dao.deleteNotice(seq);
	
	if (result == true) {
	%>
	<script type="text/javascript">
		alert("게시글이 삭제되었습니다");
		location.href = "<%=request.getContextPath()%>/index.jsp?toss=z_notice/noticelist";
	</script>
	<%
	} else {
	%>
	<script type="text/javascript">
		alert("다시 작성해주세요");
		location.href = "<%=request.getContextPath()%>/index.jsp?toss=z_notice/noticedetail&seq=<%=not.getSeq()%>"
	</script>
	<%
	}
	%>
</body>
</html>