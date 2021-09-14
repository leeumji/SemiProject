<%@page import="dto.QnaDto"%>
<%@page import="dao.QnaDao"%>
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
} else {
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QNA 작성</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
</head>


<body>
<% if (mem.getAuth() == 3) { %>
<a href="<%=request.getContextPath()%>/index.jsp?toss=z_qna/qnalist"><img alt="" src="<%=request.getContextPath()%>/image/qnalogo.png"></a><br><br>		
<div align="left" class="container" style="width: 1000px" >
<form id="frm1" method="post">
<input type="hidden" name="nickname" value="<%=mem.getNickname()%>">
   <br>
    <textarea rows="1" cols="70" id="title" name="title" style=" margin: 0px; border-color: white; font-size: 25px" placeholder="제목을 입력하세요."></textarea><hr>
      <textarea rows="10" cols="85" id="content" name="content" style=" margin: 0px; border-color: white; font-size: 20px" placeholder="내용을 입력하세요."></textarea><hr>
      <table>
      <col width="1000px">
      <tr><td>
      비밀번호 설정 : <input type="password" name="pwd" style="width: 100px" placeholder="선택사항">
   </td></tr>
   <tr align="right"><td>
   <input type="button" class="btn btn-secondary" id="write1" value="작성하기" style='width:70px; font-size: 13px; padding: 3px 3px 3px 3px;'>
   </td></tr></table>
</form>
</div>		
<%	} else if (mem.getAuth() == 1) { %>
<a href="/a_GoBack_JJIN/index.jsp?toss=z_qna/qnalist"><img alt="" src="<%=request.getContextPath()%>/image/qnalogo.png"></a><br><br>		
<div align="left" class="container" style="width: 1000px" >
<form id="frm2" method="post">
<input type="hidden" name="nickname" value="<%=mem.getNickname()%>">
   <br>
    <textarea rows="1" cols="70" id="title" name="title" style=" margin: 0px; border-color: white; font-size: 25px" placeholder="제목을 입력하세요."></textarea><hr>
      <textarea rows="10" cols="85" id="content" name="content" style=" margin: 0px; border-color: white; font-size: 20px" placeholder="내용을 입력하세요."></textarea><hr>
      <table>
      <col width="1000px">
   	  <tr align="right"><td>
      <input type="button" class="btn btn-secondary" id="write2" value="공지작성" style='width:70px; font-size: 13px; padding: 3px 3px 3px 3px;'>
      </td></tr></table>
</form>
</div>
<%	}
}%>
	
<script type="text/javascript">
$("#write1").click(function() {
	console.log($("#nickname").val());
	console.log($("#title").val());
	console.log($("#content").val());
	if($("#title").val() == ""){
		alert('제목을 입력해주세요.');
	}
	else if($("#content").val() == ""){
		alert('내용을 입력해주세요.');
	}
	else{
		$("#frm1").attr("action", "<%=request.getContextPath()%>/index.jsp?toss=z_qna/writeqnaAf"); 
		$("#frm1").submit();
	}
});
$("#write2").click(function() {
	console.log($("#nickname").val());
	console.log($("#title").val());
	console.log($("#content").val());
	if($("#title").val() == ""){
		alert('제목을 입력해주세요.');
	}
	else if($("#content").val() == ""){
		alert('내용을 입력해주세요.');
	}
	else{
		$("#frm2").attr("action", "<%=request.getContextPath()%>/index.jsp?toss=z_qna/toplist"); 
		$("#frm2").submit();
	}
});


</script>	
	
	
	
	
</body>
</html>