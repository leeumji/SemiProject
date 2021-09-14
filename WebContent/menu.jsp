<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% // 6/26 수정본 - 메뉴 조건 수정함.. %>    
    

<%
request.setCharacterEncoding("utf-8");

// session에 저장해 놓은 login정보를 가져온다. (자료형이 Object)
MemberDto mem = (MemberDto)session.getAttribute("login");

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="./css/style.css">
<style type="text/css">
.container { margin-bottom: 1rem; }
</style>
</head>
<body>

<div class="container" >

<header>
<div align="center">
   <a href="<%=request.getContextPath() %>/index.html">
   <img alt="" src="<%=request.getContextPath() %>/image/goback.png" width="100%" height="auto"></a>
</div>
</header>


<%
if (mem == null){ %>
<br>
<div align="right" class="container">
	<button type="button" class="btn btn-secondary" onclick="location.href='<%=request.getContextPath()%>/z_login/login.jsp'">로그인</button>
	&nbsp;&nbsp;
	<button type="button" class="btn btn-outline-secondary" onclick="location.href='<%=request.getContextPath()%>/z_signUp/signUp.jsp'">회원가입</button>
</div>
<hr>
<br>

<!-- 로그인 전 네비게이션 -->

<div class="container" style="width: auto;">
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand">메뉴</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#naviChange" aria-controls="naviChange" aria-expanded="false" aria-label="네비게이션 전환">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="naviChange">
      <ul class="navbar-nav mr-auto">
        <li class="nav-item active">
          <a class="nav-link" href="<%=request.getContextPath()%>/index.jsp?toss=z_bbs/bbslist">고민상담</a>
        </li>
        <li class="nav-item active">
          <a class="nav-link" href="<%=request.getContextPath()%>/index.jsp?toss=z_qna/qnalist">Q & A</a>
        </li>
        <li class="nav-item active">
          <a class="nav-link" href="<%=request.getContextPath()%>/index.jsp?toss=z_notice/noticelist">공지사항</a>
        </li>
      </ul>
    </div>
  </nav>
</div>

<br>
<% } else if(mem != null){
	if (mem.getAuth() == 3) { %>
<div align="right" class="container">
	<h4 align="right">반갑습니다 <%=mem.getNickname()%>님!</h4>
	<button type="button" class="btn btn-secondary" onclick="location.href='<%=request.getContextPath()%>/index.jsp?toss=z_mypage/myfirstpage&auth=<%=mem.getAuth()%>'">마이페이지</button>
   &nbsp;&nbsp;
	<button type="button" class="btn btn-outline-secondary" name="logout" onclick="location.href = 'logout.jsp'">로그아웃</button>
	
	
</div>
<% } else if (mem.getAuth() == 1) { %>
<div align="right" class="container">
	<h4 align="right"><%=mem.getNickname()%>님 일 시작하시죠!</h4>
	<button type="button" class="btn btn-secondary" onclick="location.href='<%=request.getContextPath()%>/index.jsp?toss=z_admin/adminpage&auth=<%=mem.getAuth()%>'">관리자페이지</button>
	
	&nbsp;&nbsp;
	<button type="button" class="btn btn-outline-secondary" name="logout" onclick="location.href = 'logout.jsp'">로그아웃</button>
</div>	
<% } %>
<hr><br>	


<!-- 로그인 후 네비게이션 -->

<div class="container">
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand">메뉴</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#naviChange" aria-controls="naviChange" aria-expanded="false" aria-label="네비게이션 전환">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="naviChange">
      <ul class="navbar-nav mr-auto">
        <li class="nav-item active">
          <a class="nav-link" href="<%=request.getContextPath()%>/index.jsp?toss=z_bbs/bbslist">고민상담</a>
        </li>
        <li class="nav-item active">
          <a class="nav-link" href="<%=request.getContextPath()%>/index.jsp?toss=z_qna/qnalist">Q & A</a>
        </li>
        <li class="nav-item active">
          <a class="nav-link" href="<%=request.getContextPath()%>/index.jsp?toss=z_notice/noticelist">공지사항</a>
        </li>
      </ul>
    </div>
  </nav>
</div>


<% } %>	
</div>
</body>
</html>