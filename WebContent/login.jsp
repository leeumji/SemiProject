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
<link rel="stylesheet" href="../css/style.css">
<title>login</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
<script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript" ></script>
</head>
<body>

<div style="height: 50px"></div><br><br>

<!-- 메인 바로가기 -->
<div align="center" class="form-group">
<a href="<%=request.getContextPath()%>/index.html" >
<img src="<%=request.getContextPath() %>/image/login.png"></a>
<br><br>
<div align="center" style="width:22%; height: 550px; border: 1px solid #DCDCDC; ">
<br>
<h1>로그인</h1><br>
<hr align="center" width="80%">
<form action="loginAf.jsp" method="post">
<table>
<col width="300px">
<tr><td><p>아이디</p></td></tr>
<tr><td>
   <input type="text" id="id" name="id" class="form-control"><p></p>
   <input type="checkbox" id="save_id">id 저장<p></p><p></p>
</td></tr>

<tr><td><p>비밀번호</p></td></tr>
<tr><td>
<input type="password" name="pwd" class="form-control"><p></p>
</td></tr>
<tr><td><br>
<input type="submit" class="btn btn-secondary" style="width: 146px; height: 50px;" value="로그인">
<input type="button" class="btn btn-outline-secondary" style="width: 146px; height: 50px;" value="회원가입" onclick="location.href='<%=request.getContextPath() %>/z_signUp/signUp.jsp'">
</td></tr>

</table>
</form><br>
<table>
<col width="300px">
<tr align="center">
   <td>
      <input type="button" id="idPop"  value="아이디" style="border: 0; outline: 0; background-color: white;"> /   
      <input type="button" id="pwdPop"   value="비밀번호찾기" style="border: 0; outline: 0; background-color: white;">
   </td>
</tr>   
</table>
</div>
</div>

<script type="text/javascript">
let user_id = $.cookie("user_id"); // cookie key 지정
if(user_id != null ){   // cookie가 null이 아니면
   $("#id").val(user_id);   // 쿠키값을 id value에 넣고
   // 한번 체크되어 있으면 쿠키값이 사라질 때까지 계속 체크됨
   $("#save_id").prop("checked", true); // 체크박스를 체크해라.
}
$("#save_id").click(function() {
   if($("#save_id").is(":checked")){ // 체크박스가 체크되어 있을 경우
      console.log($("#id").val());
      if($("#id").val().trim() == ""){ // id값이 ""이면
         alert("id를 입력해주십시오");
         $("#save_id").prop("checked", false); // 체크박스 풀기
      }else{ 
         // 공백의 제거한 id의 값을 쿠키에 저장해라 7일간 모든경로에
         $.cookie("user_id", $("#id").val().trim(), { expires:7, path: '/' });
      }
   }
   else{
      // 모든경로에 있는 쿠키를 지워라
      $.removeCookie("user_id", {path:'/'});
   }
});

$("#idPop").click(function() {
    window. open("findId.jsp", "popup01", "width=300, height=240");
}); 


$("#pwdPop").click(function() {
   window. open("findPwd.jsp", "popup02", "width=300, height=290");
      
}); 


</script>


</body>
</html>