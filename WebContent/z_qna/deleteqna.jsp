<%@page import="dto.MemberDto"%>
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
MemberDto mem = (MemberDto)session.getAttribute("login");
%> 
<%
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq.trim());
System.out.println("seq: " + seq);
%>
<%
QnaDao dao = QnaDao.getInstance();
QnaDto not = dao.getQnaInfo(seq);

if(mem.getAuth()==1){
	boolean result = dao.deleteAdminQna(seq);
	if(result==true){
		%>
		<script type="text/javascript">
		alert("게시글이 삭제되었습니다.");
		location.href = "<%=request.getContextPath()%>/index.jsp?toss=z_qna/qnalist";
		</script>
		<%
		}else{
		%>
		<script type="text/javascript">
		alert("다시 작성해주세요.");
		location.href = "<%=request.getContextPath()%>/index.jsp?toss=z_qna/qnadetail&seq=<%=not.getSeq()%>";
		</script>
	<%
	}
	} else if (mem.getAuth() == 3) {
		boolean result = dao.deleteQna(seq);
		if (result == true) {
	%>
	<script type="text/javascript">
	alert("게시글이 삭제되었습니다.");
	location.href = "<%=request.getContextPath()%>/index.jsp?toss=z_qna/qnalist";
	</script>
	<%
	} else {
	%>
	<script type="text/javascript">
	alert("다시 작성해주세요.");
	location.href = "<%=request.getContextPath()%>/index.jsp?toss=z_qna/qnadetail&seq=<%=not.getSeq()%>";
			
	</script>
	
	<%
		}
	}
	%>
	
</body>
</html>