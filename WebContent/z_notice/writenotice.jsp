<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
MemberDto mem = (MemberDto) session.getAttribute("login");
if (mem == null) {
%>
<script>
   alert("로그인 해 주십시오");
   location.href = "<%=request.getContextPath()%>
	/z_login/login.jsp";
</script>
<%
}
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/all.css">
<title>공지사항 작성</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<style type="text/css">
body {
	font-family: sans-serif
}

th {
	background-color: #FCB24D
}

.wrap {
	height: 100%;
	display: flex;
	align-items: center;
	justify-content: center;
}

.button {
	width: 120px;
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
<body>
	<div align="center">

		<br>
		<form method="post"
			action="<%=request.getContextPath()%>/index.jsp?toss=z_notice/writenoticeAf"
			enctype="multipart/form-data">
			<table class="table table-hover">
				<h1>
					<img src="<%=request.getContextPath()%>/image/noticelogo.png">
				</h1>
				<col width="200"><col width="500">
				<tr>
					<th>닉네임</th>
					<td><input name="nickname" type="text"
						value=<%if (mem != null) {%> "<%=mem.getNickname()%>" <%}%> readonly
						size="71px"></td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input name="title" type="text" placeholder="제목을 입력해주세요"
						size="71px"></td>
				</tr>
				<tr>
					<th>공지사항</th>
					<td><textarea name="content" placeholder="내용을 입력해주세요"
							rows="11" cols="72" style="overflow-y: hidden"></textarea></td>
				</tr>
				<tr>
					<th>파일 업로드</th>
					<td><input type="file" name="fileload" style="width: 500px"></td>
				</tr>
				<tr align="center">
					<td colspan="2"><input type="submit"
						
						value="공지사항 등록" class="button"> 
						<a href="<%=request.getContextPath()%>/index.jsp?toss=z_notice/noticelist">
						<button type="button" class="button">글목록</button></a></td>
				</tr>
			</table>
			</form>
	</div>
</body>
</html>