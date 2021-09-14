<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1"> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/find.css">
</head>
<body>
<form action="findPwdAf.jsp" method="post">
<div class="form-group" align="center" style="width:100%; height: 280px; border: 1px solid #808080; ">
<br>
<h3 align="center">비밀번호 찾기</h3><br>
<table>
<tr>
	<th><label>아이디&nbsp;</label></th>
	<td><input type="text" id="id" name="id" class="form-control" size="15"><p></p></td>
</tr>
<tr>
	<th><label>닉네임</label></th>
	<td><input type="text" id="nickname" name="nickname" class="form-control" size="15"><p></p></td>
</tr>
<tr>
	<th><label>이메일</label></th>
	<td><input type="text" id="email" name="email" class="form-control" size="15"><p></p></td>	
</tr>
<tr>
	<td colspan="2" align="right">
	<input type="submit" class="btn btn-secondary" style='width:70px; font-size: 13px; padding: 3px 3px 3px 3px;' value="찾기"></td>
</tr>
</table>
</div>
<br>
</form>
</body>
</html>