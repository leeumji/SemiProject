<%@page import="dto.NoticeDto"%>
<%@page import="dao.NoticeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/all.css">
<title>Insert title here</title>
</head>
<style type="text/css">
body {
	font-family: sans-serif;
}

th {
	align: center;
	background-color: #FCB24D;
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

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<%
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq.trim());

NoticeDao dao = NoticeDao.getInstance();
NoticeDto not = dao.getNoticeInfo(seq);
%>
<body>
	<br>
	<br>

	<div align="center">
		<form
			action="<%=request.getContextPath()%>/index.jsp?toss=z_notice/updatenoticeAf"
			method="post" accept-charset="utf-8" enctype="multipart/form-data">
			<input type="hidden" name="seq" value="<%=not.getSeq()%>">
			<!--  <input type="hidden" name="content" value="z_qna/updateqnaAf">-->
			<table border="2" class="table table-hover">
				<col width="200">
				<col width="500">
				<h1>
					<img src="<%=request.getContextPath()%>/image/noticelogo.png">
				</h1>
				<tr>
					<th>작성자</th>
					<td name="nickname" value="<%=not.getNickname()%>" size="71px"><%=not.getNickname()%></td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input name="title" type="text"
						value="<%=not.getTitle()%>" size="71px"></td>

				</tr>
				<tr>
					<th>공지사항</th>
					<td><textarea name="content" placeholder="내용을 입력해주세요"
							rows="11" cols="72" style="overflow-y: hidden"><%=not.getContent()%>
	</textarea></td>
				</tr>
				<tr>
					<th>파일 업로드</th>
					<td><input type="text" name="oldfile" title="" size="71px"
						<%if (not.getFilename() != null) {%> value="<%=not.getFilename()%>"
						<%}%>> <input type="file" name="fileload" title=""
						style="width: 500px"> <br> <input type="checkbox"
						name="deletefile" title="">파일 제거</td>
				</tr>

				<tr>
					<td colspan="2" align="center">
						<button type="submit" class="button">수정하기</button>
						<button type="button" class="button"
							onclick="location.href = '<%=request.getContextPath()%>/index.jsp?toss=z_notice/noticelist'">글
							목록</button>
					</td>
				</tr>

			</table>
		</form>
	</div>
</body>
</html>