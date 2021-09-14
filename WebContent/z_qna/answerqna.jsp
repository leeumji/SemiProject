<%@page import="dto.MemberDto"%>
<%@page import="dto.QnaDto"%>
<%@page import="dao.QnaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type = "text/css">
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
    <script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  
    <%
    int seq = Integer.parseInt(request.getParameter("seq"));
    QnaDto qna = QnaDao.getInstance().getQnaInfo(seq);
    System.out.println(qna);
    MemberDto mem = (MemberDto)session.getAttribute("login");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/all.css">
<title>Insert title here</title>
</head>
<body>
<br><br>
<div align = "center">
<table border = "2" align = "center" class = "table table-hover">
<col width = "200"><col width = "500">
<tr>
<td>작성자</td>
<td><%=qna.getNickname() %></td>
</tr>
<tr>
<td>제목</td>
<td><%=qna.getTitle()%></td>
</tr>
<tr>
<td>작성일</td>
<td><%=qna.getWdate() %></td>
</tr>
<tr>
<td>내용</td>
<td>
<textarea rows = "10" cols ="50" readonly = "readonly"><%=qna.getContent() %></textarea>
</td>
</tr>
</table>
</div>
<br>
<h3 align = "center">답글을 달아주세요</h3>
<form action = "<%=request.getContextPath()%>/index.jsp?toss=z_qna/answerqnaAf" method = "post">
<input type = "hidden" name = "seq" value ="<%=qna.getSeq() %>">
<br>
<table border = "1" align = "center" class = "table table-hover">
<col width = "200"><col width = "500">

<tr>
	<th>작성자</th><td><input type = "hidden" name = "nickname" <%if(mem!=null){ %>value = <%=mem.getNickname() %>><%=mem.getNickname() %><%} %></td>
</tr>
<tr>
	<th>제목</th><td><input name="title" type = "text" ; style = "width : 490px" placeholder = "제목을 입력해주세요"></td>
</tr>
<tr>
	<th>내용</th>
	<td>
		<textarea name="content" placeholder="내용을 입력해주세요" style=:"overflow-y:hidden" rows = "10", cols ="50";></textarea></td>
</tr>
<tr align = "center"> 
	<td colspan = "2">
<input type = "submit" class = "button" value = "답글쓰기">
	</td>
</tr>
</table>

</form>

</body>
</html>