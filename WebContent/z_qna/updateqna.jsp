<%@page import="dto.QnaDto"%>
<%@page import="dao.QnaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
th {
	background-color: #FCB24D;
	text-align: center;
}

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
<meta charset="UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/all.css">
<title>Insert title here</title>
</head>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<%
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq.trim());

QnaDao dao = QnaDao.getInstance();
QnaDto qna = dao.getQnaInfo(seq);
%>
<body>
	<br>
	<br>
	<div align="center">
		<form
			action="<%=request.getContextPath()%>/index.jsp?toss=z_qna/updateqnaAf"
			method="post" accept-charset="utf-8">
			<input type="hidden" name="seq" value="<%=seq%>">
			<!--  <input type="hidden" name="content" value="z_qna/updateqnaAf">-->
			<table border="2" class="table table-hover">
				<col width="200">
				<col width="500">
				<h1>
					<img src="<%=request.getContextPath()%>/image/qnalogo.png">
				</h1>
				<tr>
					<th>글쓴이</th>
					<td><%=qna.getNickname()%></td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input name="title" type="text" placeholder = "제목을 입력해주세요" style = "width : 600px" value=<%=qna.getTitle()%>></td>

				</tr>
				<tr>
					<th>내용</th>
					<td><textarea name="content"
							style="width: 600px; height: 500px; overflow-y: hidden"><%=qna.getContent()%>
	</textarea></td>
				</tr>


				<tr>
					<td align = "center" colspan = "2"><input type="submit"
						class="button" value="수정 하기">
						<button type="button" class="button"
							onclick="location.href = '<%=request.getContextPath()%>/index.jsp?toss=z_qna/qnalist'">글목록</button>
					</td>
				</tr>
				<tr>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>