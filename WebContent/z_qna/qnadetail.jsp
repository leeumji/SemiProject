<%@page import="dto.MemberDto"%>
<%@page import="dto.QnaDto"%>
<%@page import="dao.QnaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
MemberDto mem = (MemberDto)session.getAttribute("login");
if(mem == null){
%>  
	<script>
	alert("로그인 해 주십시오.");
	location.href = "<%=request.getContextPath()%>/z_login/login.jsp";
	</script>	
<%
}
%>

<%
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq);
String pwd = request.getParameter("pwd");
%>
<%
request.setCharacterEncoding("utf-8");
System.out.println("auth : " + mem.getAuth());
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>QNA 상세화면</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>

</head>

<%
QnaDao dao = QnaDao.getInstance();
dao.readcount(seq);
QnaDto dto;
if(pwd == null){
	dto = dao.getQnaInfo(seq);
}else{
dto = dao.getPwdQnaInfo(seq, pwd);
////////// 패스워드 팝업 띠어야한다..
%>
<script type="text/javascript">
window. open("pwd.jsp", "popup01", "width=300, height=240");

</script>
<% }
%>


<div class="container">
<a href="<%=request.getContextPath()%>/index.jsp?toss=z_qna/qnalist"><img alt="" src="<%=request.getContextPath() %>/image/qnalogo.png"></a>
<table ><tr align="right"><td>
	<button type="button" class="btn btn-outline-secondary" style='width:70px; font-size: 13px; padding: 3px 3px 3px 3px;' onclick="location.href='<%=request.getContextPath()%>/index.jsp?toss=z_qna/qnalist'">글목록</button>
<%if(dto.getNotice()!=1 && mem.getAuth() == 1){%>
	<button type="button" class="btn btn-secondary" style='width:70px; font-size: 13px; padding: 3px 3px 3px 3px;' onclick="answerqna(<%=dto.getSeq()%>)">답글 &nbsp;</button>
<%}else if(mem!=null&&(mem.getAuth()==1||(mem.getNickname().equals(dto.getNickname())))){ %>
	<button type="button" class="btn btn-secondary" style='width:70px; font-size: 13px; padding: 3px 3px 3px 3px;' onclick="updateqna(<%=dto.getSeq()%>)">수정</button>
	<button type="button" class="btn btn-outline-secondary" style='width:70px; font-size: 13px; padding: 3px 3px 3px 3px;' onclick="deleteBbs(<%=dto.getSeq() %>)" >삭제</button>
<%}%>
</td></tr></table><br>
<table border="1" style="text-align: center" class = "table table-striped">
   <col style="width: 1000px">
<tr>
   <td align="left">
   <p style="font-size: 25px"><%=dto.getTitle() %></p>
   <p style="font-size: 15px; color: #808080;"></p><%=dto.getNickname() %><br>
   <p style="font-size: 12px; color: #808080;"><%=dto.getWdate().substring(0,16) %>　　조회&nbsp; <%=dto.getReadcount()%></p>
   </td>
</tr>
<tr height="500px">
   <td  align="left"  style="padding: 10px 10px 10px 10px;"><%=dto.getContent() %></td>
</tr>
</table>
</div>





























	<br />
	<br />
	<script type="text/javascript">
function answerqna(seq){
	location.href = "<%=request.getContextPath()%>/index.jsp?toss=z_qna/answerqna&seq=<%=dto.getSeq()%>";
}
function updateqna(seq){
	location.href = "<%=request.getContextPath()%>/index.jsp?toss=z_qna/updateqna&seq=<%=dto.getSeq()%>";
}
function deleteqna(seq) {
	location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_qna/deleteqna&seq=<%=dto.getSeq()%>";
}
</script>

</body>
</html>