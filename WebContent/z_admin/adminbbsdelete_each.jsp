<%@page import="dao.BbsDao"%>
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
	BbsDao dao = BbsDao.getInstance();
	boolean result = dao.deleteBbsAdmin(seq);
	
	if (result == true) {
	%>
	<script type="text/javascript">
		alert("게시글이 삭제되었습니다.");
		location.href = "<%=request.getContextPath()%>/index.jsp?toss=z_admin/adminpage&tap=adminbbslist";
	</script>
	<%
	} else {
	%>
	<script type="text/javascript">
		alert("다시 확인하세요");
		location.href = "<%=request.getContextPath()%>/index.jsp?toss=z_admin/adminpage&tap=adminbbsdetail";
	</script>
	<%
	}
	%>
</body>
</html>


</body>
</html>