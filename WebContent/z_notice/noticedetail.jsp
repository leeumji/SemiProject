<%@page import="dto.MemberDto"%>
<%@page import="dto.NoticeDto"%>
<%@page import="dao.NoticeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
MemberDto mem = (MemberDto)session.getAttribute("login");
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq);
%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/all.css">
<title>QNA 상세화면</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/style.css">

<style type="text/css">
.wrap {
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.button {
  width: 80px;
  height: 35px;
  font-family: 'Roboto', sans-serif;
  font-size: 13px;
  text-transform: uppercase;
  letter-spacing: 2.5px;
  font-weight: 500;
  color: #000;
  background-color: dark;
  border: none;
  border-radius: 45px;
  box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease 0s;
  cursor: pointer;
  outline: none;
  }

.button:hover {
  background-color: orange;
  box-shadow: orange;
  color: #fff;
  transform: translateY(-7px);
}
</style>
</head>

<%
NoticeDao dao = NoticeDao.getInstance();
dao.readcount(seq);
NoticeDto dto = dao.getNoticeInfo(seq);

%>

<br>
<br>
<body>
	<div align="center" class="list">
		<table class = "table table-hover">
		<input type="hidden" name="seq" value="<%=dto.getSeq() %>">
			<col width="200px">
			<col width="500px">
			<tr>
				<th>작성자</th>
				<td><%=dto.getNickname()%></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><%=dto.getTitle()%></td>
			</tr>
			<%if(dto.getFilename()!=null){ %>
			<tr>
			<th>첨부파일</th>
			<td><%=dto.getFilename()%><br>
			<input type = "button" name = "btnDown" value = "다운로드" onclick = "filedownload('<%=dto.getNewFilename() %>', <%=dto.getSeq() %>)">
			</td>
			</tr>
			<%} %>
			<tr>
				<th>작성일</th>
				<td><%=dto.getWdate().substring(0,16)%></td>
			</tr>
			<tr>
				<th>조회수</th>
				<td><%=dto.getReadcount()%></td>
			</tr>
			<%if(dto.getFilename()!=null){ %>
			<tr>
				<th>다운로드수</th>
				<td><%=dto.getDowncount()%></td>
			</tr>
			<%} %>
			<tr>
				<th>내용</th>
				<td><%=dto.getContent()%></td>
			</tr>
		</table>
	</div>
	<br>
	<br>
	<div class="buttons" align="center">
		<table>
			<tr colspan="2">

				<button type="button" class="button"
					onclick="location.href='<%=request.getContextPath()%>/index.jsp?toss=z_notice/noticelist'">글목록</button>
				&nbsp;
				<%if(mem!=null&&mem.getAuth()==1){ %>
				<button type="button" class="button"
					onclick="updatenotice(<%=dto.getSeq()%>)">수정</button>
				&nbsp;
				<button type="button" class="button" id = "deletebutton"
					onclick="deletenotice(<%=dto.getSeq()%>)">삭제</button>
				&nbsp;
				<%} %>
		</table>
	</div>
	<br>
	<br>


	<br />
	<br />
	<script type="text/javascript">
function updatenotice(seq){
	location.href = "<%=request.getContextPath()%>/index.jsp?toss=z_notice/updatenotice&seq=<%=dto.getSeq()%>";
}
function deletenotice(seq) {
	location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_notice/deletenotice&seq=<%=dto.getSeq()%>";
}
</script>

<script type="text/javascript"> //서블릿을 활용합니다 web.xml servlet-name : Nfiledown
function filedownload(newfilename,seq){
	location.href = "Nfiledown?newfilename=<%=dto.getNewFilename()%>&seq=<%=dto.getSeq()%>"; 
}
</script>

</body>
</html>