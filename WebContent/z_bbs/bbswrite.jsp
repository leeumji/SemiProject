.<%@page import="dao.MemberDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
MemberDto mem = (MemberDto)session.getAttribute("login");
if(mem == null || mem.getNickname()== null || mem.getNickname().equals("")){
%>  
   <script>
   alert("로그인 해 주십시오");
   location.href = "<%=request.getContextPath()%>/z_login/login.jsp";
   </script>   
<%
}
%>     
<!DOCTYPE html>

<html>
<head>
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/all.css">
</head>
<body>
<%try {%>
<a href="/a_GoBack_JJIN/index.jsp?toss=z_bbs/bbslist"><img alt="" src="./image/worry.png"></a><br><br>
<div align="left" class="container" style="width: 1000px" >
<form id="frm" method="post" enctype="multipart/form-data">
<input type="hidden" name="nickname" value="<%=mem.getNickname()%>">
   <select id="cago" name="cago" class="form-control" style="width: 200px; height: 30px; font-size: 13px;">
      <option value="" class="disabled">- 카테고리를 선택하세요 -</option>
      <option value="학업·진로">학업·진로</option>
      <option value="연애·가족">연애·가족</option>
      <option value="대인관계">대인관계</option>
      <option value="심리·정서">심리·정서</option>
      <option value="금전">금전</option>
      <option value="기타">기타</option>
   </select>
   <br>
    <textarea rows="1" cols="70" id="title" name="title" style=" margin: 0px; border-color: white; font-size: 25px" placeholder="제목을 입력하세요."></textarea><hr>
      <textarea rows="10" cols="85" id="content" name="content"style=" margin: 0px; border-color: white; font-size: 20px" placeholder="내용을 입력하세요."></textarea><hr>
      <table>
      <col width="1000px">
      <tr><td>
      <input type="file" name="fileload" style="width: 500px">
   </td></tr>
   <tr align="right"><td>
   <input type="button" class="btn btn-secondary" id="commentWrite" value="작성하기" style='width:70px; font-size: 13px; padding: 3px 3px 3px 3px;'>
   </td></tr></table>
</form>
</div>
<%}catch(Exception e){ %>
   <script>
   alert("로그인 해 주십시오");
   location.href = "<%=request.getContextPath()%>/z_login/login.jsp";
   </script>   
<%
}
%> 
<script type="text/javascript">
$("#commentWrite").click(function() {
	if($("#cago").val() == ""){
		alert('카테고리를 선택해 주세요.');
	}
	else if($("#title").val() == ""){
		alert('제목을 입력해주세요.');
	}
	else if($("#content").val() == ""){
		alert('내용을 입력해주세요.');
	}
	else{
		$("#frm").attr("action", "<%=request.getContextPath() %>/index.jsp?toss=z_bbs/bbswriteAf"); 
		$("#frm").submit();
	}
});

</script>
</body>
</html>