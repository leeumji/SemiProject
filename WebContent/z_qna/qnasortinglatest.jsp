<%@page import="dto.MemberDto"%>
<%@page import="dto.QnaDto"%>
<%@page import="dao.QnaDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">


<!DOCTYPE html>
<html>
<head>
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
<meta charset="UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/all.css">
<title>Insert title here</title>
</head>

<%
QnaDao dao = QnaDao.getInstance();
List<QnaDto> list = dao.getSortingLatestList();
int count = 1;
%>

<body>
<br><br>

<div align = "center">

<a
				href="<%=request.getContextPath()%>/index.jsp?toss=z_qna/qnasortinglatest">
				<img alt="" src="<%=request.getContextPath()%>/image/latest.JPG">
			</a>
<div id = "sorting_list" align = "right">
<button type = "button" class = "button" id = "qnalist" onclick = "location.href = '<%=request.getContextPath()%>/index.jsp?toss=z_qna/qnalist'"><-목록</button>&nbsp;
<button type = "button" class = "button" id = "sortinglatest" onclick = "locaion.href = '<%=request.getContextPath()%>/index.jsp?toss=z_qna/qnasortinglatest'">최신순</button>&nbsp;
<button type = "button" class = "button" id = "sortingread" onclick = "location.href = '<%=request.getContextPath()%>/index.jsp?toss=z_qna/qnasortingread'">조회순</button>&nbsp;
</div>
<br>
<table class = "table table-hover">
<col width = "100"><col width = "500"><col width = "200"><col width = "120">

<tr style = "background-color:#F99C41">
	<th>순위</th><th>제목</th><th>글쓴이</th><th>게시일</th>
</tr>

<%
if(list==null||list.size()==0){
%>

	<tr>
		<td colspan = "3">작성된 글이 없습니다</td>
	</tr>
<% 
}else{
	for(int i = 0;i<list.size();i++){
		QnaDto qna = list.get(i);
		if(qna.getDel()==0&&qna.getStep()==0){%>
		<th><%=count++%></th>
		<td>
		<a href = "<%=request.getContextPath() %>/index.jsp?toss=z_qna/qnadetail&seq=<%=qna.getSeq()%>">
		<%if(qna.getTitle().length()>=15){%>
			<%=qna.getTitle().substring(0,15)+"..."%>
			<%}else{ %>
			<%=qna.getTitle().trim() %>
			<%} %>
		</a>
		</td>
		<td>
		<%=qna.getNickname() %>
		</td>
		<td><%=qna.getWdate().substring(0,10) %></td>
		</tr>
	<% 
		}
	}
}
	%>
</table>
<br><br>
</div>
<br/><br/>
</body>
</html>