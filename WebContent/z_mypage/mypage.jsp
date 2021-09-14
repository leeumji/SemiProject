<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.security.Timestamp"%>
<%@page import="dao.MemberDao"%>
<%@page import="dto.MemberDto"%>



      <%
request.setCharacterEncoding("utf-8");
%>   
    <%-- <%
   String content = request.getParameter("content");
   if(content == null){
      content = request.getContextPath()+"z_mypage/mypage";
   }
%>     --%>
            <%
MemberDto mem = (MemberDto)session.getAttribute("login");
        
/* String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq.trim()); */
%>    


<%-- <%
 String year = mem.getBirth().substring(0,4);
String month =mem.getBirth().substring(4,6);
String day = mem.getBirth().substring(6,8); 

%> --%>
<%!
String year;
String month;
String day;
%>

<% 
String id = mem.getId();
MemberDao dao = MemberDao.getInstance();
MemberDto dto = dao.getMember(id);


 
System.out.println(dto.toString()); 
 

if(dto.getBirth()==null||dto.getBirth().length()!=8){

	dto.setBirth(" ");
	year=dto.getBirth();
	month= dto.getBirth();
	day= dto.getBirth();
	
}else {
	year=dto.getBirth().substring(0,4);
	month= dto.getBirth().substring(4,6);

	day= dto.getBirth().substring(6,8);
}

if(dto.getGender()==null){
	dto.setGender(" ");
	dto.getGender();
}
System.out.println(dto.toString());

%>
   


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>signUp</title>
<meta name="viewport" content="width=device-width, initial-scale=1"> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/all.css">

<style>
body { 

    font-family: 'RIDIBatang';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_twelve@1.0/RIDIBatang.woff') format('woff');
    font-weight: normal;
    font-style: normal;
  
}
</style>
</head>
<body>


<div style="height: 50px"></div><br><br>

<!-- 메인 바로가기 -->
<div align="center">


<h1 align="center"><%=dto.getNickname() %>님의 프로필</h1>
<br>

<table>
<col width="310px">
<tr><th>아이디<p></p></th></tr>
<tr><td>
   <input type="text" id="id" name="id" class="form-control" maxlength="15" value="<%=mem.getId() %>" readonly ><p></p>
  
</td></tr>

<!-- 비밀번호는 보이지 않아도 된다!! -->

<tr><th><p></p>닉네임<p></p></th></tr>
<tr><td>
   <input type="text" id="nickname" name="nickname" class="form-control" maxlength="15" value="<%=dto.getNickname() %>" readonly ><p></p>
   


</td></tr>
<tr><th><p></p>생년월일<p></p></th></tr>
<tr><td>
  <div class="input-group mb-3">
    <input type="text" id="year" name="year" class="form-control" maxlength="4"
         style="width: 50px; font-size:15px;" value="<%=year %>" readonly >&nbsp;
         
	 <input type="text" id="month" name="month" class="form-control" maxlength="4"
         style="width: 50px; font-size:15px;" value="<%=month %>" readonly >&nbsp;
   
    <input type="text" id="day" name="day" class="form-control" 
         style="width: 30px;  font-size:15px;" value="<%=day%>" readonly ><p></p>
  
  </div>
</td></tr>


<tr><td>성별<p></p></td></tr>
<tr><td>
<input type="text" id="gender" name="gender" class="form-control" value="<%=dto.getGender() %>" readonly>

</td></tr>


<tr><td><p></p>이메일<p></p></td></tr>
<tr><td>
<input type="text" id="email" name="email" class="form-control"  value="<%=dto.getEmail() %>" readonly>
<!--  <p id="email_check" class="sign_p"></p><p></p>-->
</td></tr>


<tr><td>
<br><br>
<input type="button" id="send" class="btn btn-secondary" style="width: 300px; height: 50px;" onclick="location.href='<%=request.getContextPath() %>/index.jsp?toss=z_mypage/myfirstpage&tap=mypageUpdate&id=<%=dto.getId() %>'" value="수정하기" >
</td></tr>
</table>


</div>



</body>

</html>