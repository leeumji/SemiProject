<%@page import="dto.MemberDto"%>
<%@page import="dto.QnaDto"%>
<%@page import="dao.QnaDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="//code.jquery.com/jquery-1.12.0.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">

<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.etc {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	float: center;
}

html, body {
	height: 100%;
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

.title{
text-align:left;
}
.deleted{
text-align:left;
}
</style>

<meta charset="UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/all.css">
<title>Q&A</title>
</head>

<%
String category = request.getParameter("category");
String keyword = request.getParameter("keyword");
	if (category == null) {
		category = "";
	}
	if (keyword == null) {
		keyword = "";
	}

//현재 페이지 번호 불러오기
String sPageNumber = request.getParameter("pageNumber");
int pageNumber = 0;
	if (sPageNumber != null && !sPageNumber.equals("")) {
		pageNumber = Integer.parseInt(sPageNumber);
	}
//System.out.println("pageNumber : " + pageNumber);
%>

<%
QnaDao dao = QnaDao.getInstance();
//List<QnaDto> list = dao.getQnaList();
//List<QnaDto> list = dao.getSearchlist(category, keyword);
List<QnaDto> list = dao.getPagingList(category, keyword, pageNumber);
%>


<%
//글의 총 수 불러오기
int len = dao.getAllQna(category, keyword);
//System.out.println("총 글의 수 : " + len);

// 페이지수 넣어주기
int qnaPage = len / 10;
	if ((len % 10) > 0) {
		qnaPage = qnaPage + 1;
	}
	
int n = 1;
%>


<script type="text/javascript">
	$(document).ready(function() {
		let keyword = "<%=keyword%>";
			if(keyword == "")return;
	
		let obj = document.getElementById("category");
			obj.value = "<%=category%>";
				obj.setAttribute("selected", "selected");
	});
</script>

<body>

	<div align="left">


		<div class="card-header"
			style="background-color: white; padding-bottom: 0;">
			<a
				href="<%=request.getContextPath()%>/index.jsp?toss=z_qna/qnalist">
				<img alt="" src="<%=request.getContextPath()%>/image/qnalogo.png">
			</a>
			<div id="sorting_list" align="right">
				<button type="button" class="button" onclick="writeButton()">글쓰기</button>
				&nbsp;
				<button type="button" class="button" onclick="sortlatestButton()">최신순</button>
				&nbsp;
				<button type="button" class="button" onclick="sortreadButton()">조회순</button>
				&nbsp;
			</div>
			<div class="card-header-right">
				<ul class="list-unstyled card-option">
					<li><i class="icofont icofont-simple-left "></i></li>
					<li><i class="icofont icofont-maximize full-card"></i></li>
					<li><i class="icofont icofont-minus minimize-card"></i></li>
					<li><i class="icofont icofont-refresh reload-card"></i></li>
					<li><i class="icofont icofont-error close-card"></i></li>
				</ul>
			</div>

			<div class="card-block table-border-style">
				<div class="table-responsive">
					<table class="table table-hover">
						<col width="100px">
						<col width="500px">
						<col width="100px">
						<col width="150px">
						<col width="150px">
						<thead>
							<tr align="center" style = "background-color : #dcdcdc">
								<th>번호</th>
								<th>제목</th>
								<th>조회수</th>
								<th>글쓴이</th>
								<th>등록일</th>
							</tr>
						</thead>
						<tbody>

							<%
							if (list == null || list.size() == 0) { //작성된 글이 없을 때
							%>

							<tr>
								<th scope="row" colspan="3">작성된 글이 없습니다
							</tr>
							<%
							} else { //작성된 글이 있을 때
							for (int i = 0; i < list.size(); i++) {
								QnaDto qna = list.get(i);
								if (qna.getDel() == 0) { //삭제된 글이 아닐때--------------------
									if (qna.getStep() >= 1) { //답글--------------------
							%>
							<tr>
								<th></th>
								<td class = "title"><a
									href="<%=request.getContextPath()%>/index.jsp?toss=z_qna/qnadetail&seq='<%=qna.getSeq()%>'&pwd='<%=qna.getPwd()%>'">
										<%
										if (qna.getTitle().length() >= 15) {
										%> <!-- 만약 제목이 15글자가 넘어가면  --> ↘ <%=qna.getTitle().substring(0, 15) + "..."%>
										<%
							 } else {
							 %><!-- 제목이 15글자 아래이면 --> ↘ <%=qna.getTitle().trim()%> <%
							 }
							 %>
								</a>
								<td><%=qna.getReadcount() %></td>
								<td align="center"><%=qna.getNickname()%></td>
								<td><%=qna.getWdate().substring(0,10)%></td>
							</tr>
							<%
							} else {
							%>
							<!--본글인경우  -->
							<tr>
								<%if (qna.getNotice() == 0) {%>
								<!-- 공지가 아닐 경우 -->
								<th style="text-align: center"><%=n++%></th>
								<%
								} else {
								%><!-- 공지일경우 -->
								<th style="color: orange; text-align: center">📌</th>
								<%
								}
								%>
								<td class = "title"><a
									href="<%=request.getContextPath()%>/index.jsp?toss=z_qna/qnadetail&seq=<%=qna.getSeq()%>">
										<%
										if (qna.getTitle().length() >= 15) {
										%> <%=qna.getTitle().substring(0, 15) + "..."%> <%
										if ((dao.getReQna(qna.getRef(), qna.getSeq()) - 1) >= 1) {
										%> <font color="gray">[<%=dao.getReQna(qna.getRef(), qna.getSeq()) - 1%>]
									</font> <% } %> <%
 										} else {
										 %> <!-- 공지가 아닐 경우 --> <%=qna.getTitle().trim()%> <% if ((dao.getReQna(qna.getRef(), qna.getSeq()) - 1) >= 1) { %>
										<font color="gray">[<%=dao.getReQna(qna.getRef(), qna.getSeq()) - 1%>]
									</font> <%
											}
										}
										%>
								</a>
								<td><%=qna.getReadcount() %></td></td>
								<td align="center"><%=qna.getNickname()%></td>
								<td><%=qna.getWdate().substring(0,10) %></td>
							</tr>
							<%
							}
							} else if (qna.getDel() == 1) { //삭제된 글일 경우
							if (qna.getStep() == 1) { //답글일 때
							%>
							<tr>
								<th></th>
								<td colspan = "4" class ="deleted"><font color=<%if (qna.getDelby() == 3) {%>
									"blue"<%} else {%>"red"<%}%>> ↘ <%=qna.getTitle()%></font></td>
									
							</tr>
							<%
							} else {
							%><!-- 답글이 아닐때 -->
							<tr>
								<td colspan="5" class = "deleted"><font color=<%if (qna.getDelby() == 3) {%>
									"blue"<%} else {%>"red"<%}%>> <%=qna.getTitle()%></font></td>
								
							</tr>
							<%
										}
									}
								}
							}
							%>

						</tbody>
					</table>
				</div>
			</div>
		</div>

		<br>
		<div align="center">
			<table>
				<tr>
					<%
					for (int i = 0; i < qnaPage; i++) {
						if (pageNumber == i) { //i는 현재페이지를 뜻함, 2페이지라 하면 [1] 2 [3] 이런식으로, 2는 클릭이 안 먹힘
					%>
					<span
						style="font-size: 15pt; color: orange; font-weight: bold; padding: 0 5px">
						<%=i + 1%>
					</span>
					<%
					} else { //그 밖의 페이지
					%>

					<a href="#none" title="<%=i + 1%>페이지" onclick="goPage(<%=i%>)"
						style="font-size: 15pt; color: #d2d2d2; font-weight: bold; text-decoration: none; padding: 0 5px">
						[<%=i + 1%>]
					</a>
					<%
						}
					}
					%>
				</tr>
				
				<br><br>
				
				<tr colspan="3">
					<select id="category" style = "height : 30px">
						<option>--선택--</option>
						<option value="nickname">글쓴이</option>
						<option value="title">제목</option>
						<option value="content">내용</option>
						<option value="titleandcontent">제목&내용</option>
					</select> &nbsp;
					<input type="text" width="200" id="keyword"
						placeholder="검색어를 입력해주세요" value="<%=keyword%>">&nbsp;

					<button type="button" class="" style="border: 0; background-color: white;"  onclick="searchButton()">
					<img alt="" src="<%=request.getContextPath()%>/image/closer.png"></button>
					
					&nbsp;
				</tr>
			</table>
		</div>

<script type="text/javascript">
	function searchButton(){
	
		let category = document.getElementById("category").value;
		let keyword = document.getElementById("keyword").value;
		if(keyword.trim()==''){
			alert("검색어를 입력해주세요");
			return;
		}
		location.href = 
			"<%=request.getContextPath()%>/index.jsp?toss=z_qna/qnalist&category=" + category + "&keyword=" + keyword;
	}
	function writeButton(){
		<%
		MemberDto mem = (MemberDto) session.getAttribute("login");

		if (mem == null) {
		%>
			alert("로그인 해 주십시오.");
			location.href = "<%=request.getContextPath()%>/z_login/login.jsp";
		<%
		} else {
		%>
		location.href = "<%=request.getContextPath()%>/index.jsp?toss=z_qna/writeqna";
		<%}%>
		}
	function sortlatestButton(){
		location.href = "<%=request.getContextPath()%>/index.jsp?toss=z_qna/qnasortinglatest";
	}
	function sortreadButton(){
		location.href = "<%=request.getContextPath()%>/index.jsp?toss=z_qna/qnasortingread";
	}

</script>
<script type="text/javascript">
	function goPage(pageNum){
		let category = document.getElementById("category").value;
		let keyword = document.getElementById("keyword").value;
		
	location.href = 
		"<%=request.getContextPath()%>/index.jsp?toss=z_qna/qnalist&category=" + category + "&keyword=" + keyword + "&pageNumber=" + pageNum;
	}

</script>
</body>
</html>