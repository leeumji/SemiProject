<%@page import="dao.NoticeDao"%>
<%@page import="dto.NoticeDto"%>
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
<!DOCTYPE html>
<html>
<style type="text/css">
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

ul, li {
	list-style: none;
	margin: 0;
	padding: 0
}

.text_ul_wrap {
	margin: 0 auto;
	width: 240px;
	margin-top: 30px;
	position: relative;
	border: 1px solid #000;
	text-align: left
}

.text_ul_wrap a {
	color: #000;
	line-height: 34px;
	display: block;
	padding: 0 20px 0 10px;
	text-decoration: none
}

.select_icon {
	display: block;
	content: '';
	clear: both;
	position: absolute;
	right: 10px;
	top: 12px;
	width: 0;
	height: 0;
	border-left: 6px solid transparent;
	border-right: 6px solid transparent;
	border-top: 12px solid #000;
	border-bottom: none;
}

.select_icon.active {
	border-bottom: 12px solid #000;
	border-top: none;
}

.ul_select_style {
	position: absolute;
	width: 242px;
	left: -1px;
	display: none;
}

.ul_select_style.active {
	display: block
}

.ul_select_style li {
	line-height: 34px;
	border: 1px solid #000;
	text-align: left;
	padding-left: 10px;
	cursor: pointer;
}

.ul_select_style li+li {
	border-top: none;
}

.ul_select_style li:hover {
	background: rgba(0, 0, 0, 0.2)
}

.title{
text-align:left;
}
</style>
<%!//깊이(depth)와 image를 추가하는 함수
	public String arrow(int depth) {
		String rs = "<img src = ' request.getContextPath() + /index.jsp?toss=image/qna.png' width='20px' height='20px'>";
		String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;";

		String ts = "";
		for (int i = 0; i < depth; i++) {
			ts += nbsp;
		}
		return depth == 0 ? "" : ts + rs;
	}%>


<%
String toss = request.getParameter("toss");
if (toss == null) {
	toss = request.getContextPath() + "/index.jsp?toss=z_notice/noticelist";
}
MemberDto mem = (MemberDto) session.getAttribute("login");
%>

<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/all.css">
<title>Insert title here</title>
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
System.out.println("pageNumber : " + pageNumber);
%>

<%
NoticeDao dao = NoticeDao.getInstance();
//List<NoticeDto> list = dao.getQnaList();
//List<NoticeDto> list = dao.getSearchlist(category, keyword);
List<NoticeDto> list = dao.getPagingList(category, keyword, pageNumber);
%>


<%
//글의 총 수 불러오기
int len = dao.getAllNotice(category, keyword);
System.out.println("총 글의 수 : " + len);

//페이지수[1],[2],[3],,이런 식으로
int noticePage = len / 10; //24개의 글이 있을 때, 몫은 2개 나옴
if ((len % 10) > 0) {
	noticePage = noticePage + 1;
}
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
				href="<%=request.getContextPath()%>/index.jsp?toss=z_notice/noticelist">
				<img alt="" src="<%=request.getContextPath()%>/image/noticelogo.png">
			</a>
			<div align = "right">
					<%
					if (mem != null && mem.getAuth() == 1) {
					%>
					<button type="button" style = "align : right" onclick="writeButton()" class="button">글쓰기</button>
					<%
					}
					%>
			</div>
			<br>
	
			
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
								<th></th>
								<th>제목</th>
								<th>조회수</th>
								<th>글쓴이</th>
								<th>등록일</th>
							</tr>
						</thead>
						<tbody>
							<%
							if (list == null || list.size() == 0) {
							%>
							<tr>
								<td colspan="3">작성된 글이 없습니다</td>
							</tr>
							<%
							} else {
							for (int i = 0; i < list.size(); i++) {
								NoticeDto not = list.get(i);
							%>
							<tr>
								<th>　　💡</th>
								<td class = "title"><a
									href="<%=request.getContextPath()%>/index.jsp?toss=z_notice/noticedetail&seq=<%=not.getSeq()%>"><%=not.getTitle()%>
										<%
										if (not.getFilename() != null) {
										%><img style="width: 15px"
										src="<%=request.getContextPath()%>/image/fileicon.png">
										<%
										}
										%></a></td>
								<td><%=not.getReadcount() %></td>
								<td><%=not.getNickname()%></td>
								<td><%=not.getWdate().substring(0,10) %>
							</tr>

							<%
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
					for (int i = 0; i < noticePage; i++) {
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
						<option value="title">제목</option>
						<option value="content">내용</option>
						<option value="titleandcontent">제목&내용</option>
						<option value="nickname">글쓴이</option>
					</select> &nbsp;
					<input type="text" width="200" id="keyword"
						placeholder="검색어를 입력해주세요" value="<%=keyword%>">&nbsp;
						
					<button type="button" class="" style="border: 0; background-color: white;"  onclick="searchButton()">
					<img alt="" src="<%=request.getContextPath()%>/image/closer.png"></button>
					&nbsp;

				</tr>
				
				<br>
			</table>
		</div>

		<script type="text/javascript">
function searchButton(){
	let category = document.getElementById("category").value;
	let keyword = document.getElementById("keyword").value;
	if(keyword.trim()==''){
		alert("검색어를 입력해주세요.");
		return;
	}
	location.href = 
		"<%=request.getContextPath()%>/index.jsp?toss=z_notice/noticelist&category=" + category + "&keyword=" + keyword;
}

function writeButton(){
	location.href = "<%=request.getContextPath()%>/index.jsp?toss=z_notice/writenotice";
}
</script>
		<script type="text/javascript">
	function goPage(pageNum){
		let category = document.getElementById("category").value;
		let keyword = document.getElementById("keyword").value;
		
	location.href = 
		"<%=request.getContextPath()%>/index.jsp?toss=z_notice/noticelist&category=" + category + "&keyword=" + keyword + "&pageNumber=" + pageNum;
	}

</script>
		<br /> <br />
</body>
</html>