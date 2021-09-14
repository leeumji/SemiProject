<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String toss = request.getParameter("toss");
	if(toss == null){
		toss = request.getContextPath() + "/z_login/login";
	}
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1"> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/all.css">
<title>login</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
<script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript" ></script>
</head>
<body>

<div style="height: 50px"></div><br><br>

<!-- 메인 바로가기 -->
<div align="center">

<br><br><br>
<h1>정말 탈퇴하시겠습니까?</h1><br>
<h3>다시한번 입력해주세요</h3><br>
<form action="<%=request.getContextPath()%>/z_mypage/deleteMyaccountAf.jsp" method="post">
<div class="form-group">
<table>
<col width="300px">
<tr><td><p>아이디</p></td></tr>
<tr><td>
	<input type="text" id="id" name="id" class="form-control"><p></p>
	
</td></tr>

<tr><td><p>비밀번호</p></td></tr>
<tr><td>
<input type="password" name="pwd" class="form-control"><p></p>
</td></tr>

<tr><td><br>
<input type="submit" class="btn btn-secondary" style="width: 300px; height: 50px;" value="탈퇴하기">

</td></tr>

</table>
</div>
</form><br>

</div>



</body>
</html>