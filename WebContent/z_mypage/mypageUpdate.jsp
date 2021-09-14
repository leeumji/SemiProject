<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.security.Timestamp"%>
<%@page import="dao.MemberDao"%>
<%@page import="dto.MemberDto"%>


<%
   String content = request.getParameter("content");
   if(content == null){
      content = "./z_signUp/signUp";
   }
%> 


          <%
MemberDto mem = (MemberDto)session.getAttribute("login");
        if(mem == null){
           
           %>  
              <script>
              alert("로그인 해 주십시오");
              location.href = "login.jsp";
              </script>   
           <%
           }
/* String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq.trim()); */
%>    
    <%
request.setCharacterEncoding("utf-8");

%>
<%!
public static String two(String msg){
   return msg.trim().length()<2?"0"+msg.trim():msg.trim();
}
public String toOne(String msg){   // 08 -> 8
   return msg.charAt(0)=='0'?msg.charAt(1) + "": msg.trim();
}
String year;
String month;
String day;
%>
<%
 
String id =mem.getId();
MemberDao dao = MemberDao.getInstance();
MemberDto dto = dao.getMember(id);
System.out.println("id:" + id);
System.out.println(dto.toString());

if(dto.getBirth()==null||dto.getBirth().length()!=8){

   dto.setBirth("");
   year=dto.getBirth();
   month= dto.getBirth();
   day= dto.getBirth();
   
}else{

year= dto.getBirth().substring(0,4);
month= toOne(dto.getBirth().substring(4,6));
day= two(dto.getBirth().substring(6,8));

String birth = year+month+day;

}
if(dto.getGender()==null){
   dto.setGender("");
}
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
</head>
<body>


<div style="height: 50px"></div><br><br>

<!-- 메인 바로가기 -->
<div align="center">


<h1 align="center">회원가입</h1><br>
<form id="frm" method="post">

<table>
<col width="310px">
<tr><th>아이디<p></p></th></tr>
<tr><td>
   <input type="text" id="id" name="id" class="form-control" maxlength="15" value="<%=mem.getId() %>" readonly ><p></p>
  
</td></tr>

<!-- 비밀번호는 다시 입력(초기화)해줘야한다  -->
<tr><th><p></p>비밀번호<p></p></th></tr>
<tr><td>
   <input type="password" id="pwd" name="pwd" class="form-control" placeholder="필수입력 (8자리 이상)" maxlength="20"><p></p>
   <p id="pwd_check" class="sign_p"></p>
</td></tr>

<tr><th><p></p>비밀번호 재확인<p></p></th></tr>
<tr><td>
   <input type="password" id="pwd_checking" class="form-control" placeholder="필수입력" maxlength="20"><p></p>
   <p id="pwd_double_check" class="sign_p"></p>
</td></tr>

<tr><th><p></p>닉네임<p></p></th></tr>
<tr><td>
   <input type="text" id="nickname" name="nickname" class="form-control" maxlength="15" value="<%=dto.getNickname() %>" readonly ><p></p>
  

</td></tr>
<tr><th><p></p>생년월일<p></p></th></tr>
<tr><td>
  <div class="input-group mb-3">
    <input type="text" id="year" name="year" placeholder="생년월일(4자)"class="form-control" maxlength="4"
         style="width: 50px; font-size:15px;" value="<%=year %>" >&nbsp;

    <select id="month" name="month" class="form-control"style="width: 30px; ">
    <%
      for(int i=1;i<=12;i++){    
    %>
        <option <%=month.equals(i+"")?"selected='selected'":""%> value="<%=i%>"><%=i%></option>
        <%
        }
       %>
   
   </select>&nbsp;
    <input type="text" id="day" name="day" class="form-control" placeholder="일" maxlength="2"
         style="width: 30px;  font-size:15px;" value="<%=day%>"><p></p>
   <p id="birth_check" class="sign_p"></p>
  </div>
</td></tr>


<tr><td>성별<p></p></td></tr>
<tr><td>
<select   name="gender" class="form-control">
<!-- 0628 성별나타내기  -->

<option value="남자">남자</option>
<option value="여자">여자</option>
<option value="">선택안함</option>
</select><p></p>
</td></tr>


<tr><td><p></p>이메일<p></p></td></tr>
<tr><td>
<input type="text" id="email" name="email" class="form-control" placeholder="필수입력 (@를 포함하여 주십시오.)" value="<%=dto.getEmail() %>">
<p id="email_check" class="sign_p"></p><p></p>
</td></tr>


<tr><td>
<input type="button" id="send" class="btn btn-secondary" style="width: 300px; height: 50px;" value="수정하기" >
</td></tr>
</table>

</form>
</div>

<script type="text/javascript">
let id = false;
let pwd = false;
let pwd_check = false;
let nickname = false;
let email = false; 

$(document).ready(function() {
  
   
    /////////////////////// pwd ///////////////////////
   $("#pwd").blur(function() {
     let pwdCheck = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,20}$/;
     
      if ($("#pwd").val() == "") {
         $("#pwd_check").css("color", "red");
         $("#pwd_check").text("필수정보예요.");
         pwd = false;
      }   
      else if (!pwdCheck.test($("#pwd").val())) {
         $("#pwd_check").css("color", "red");
        $("#pwd_check").text("비밀번호는 영문자+숫자+특수문자 조합으로 8~20자리를 사용해야 합니다");
        pwd = false;
     }
        else{
          if($("#pwd_checking").val().length == 0){
            $("#pwd_check").css("color", "blue");
            $("#pwd_check").text("완벽한 비밀번호네요!");
            pwd = true;
         }else if($("#pwd_checking").val().length > 0 && $("#pwd").val() != $("#pwd_checking").val()){
            $("#pwd_double_check").css("color", "red");
            $("#pwd_double_check").text("비밀번호가 일치하지 않습니다.");
            pwd_check = false;
         }else if($("#pwd_checking").val().length > 0 && $("#pwd").val() == $("#pwd_checking").val()){
            $("#pwd_double_check").css("color", "blue");
            $("#pwd_double_check").text("비밀번호가 일치합니다.");
            $("#pwd_check").css("color", "blue");
            $("#pwd_check").text("완벽한 비밀번호네요!");
            pwd = true;
            pwd_check = true;
         }   
        }
      console.log($("#pwd").val());
   });
   
   
   
   
    /////////////////////// pwd_check ///////////////////////
    
   $("#pwd_checking").blur(function() {
      if ($("#pwd_checking").val() == "") {
            $("#pwd_double_check").css("color", "red");
            $("#pwd_double_check").text("필수정보예요.");
            pwd = false;
      }else if($("#pwd").val() != $("#pwd_checking").val()){
         $("#pwd_double_check").css("color", "red");
         $("#pwd_double_check").text("비밀번호가 일치하지 않습니다.");
         pwd_check = false;
       }else if($("#pwd").val() == $("#pwd_checking").val()){
         $("#pwd_double_check").css("color", "blue");
         $("#pwd_double_check").text("비밀번호가 일치합니다.");
         pwd_check = true;
       }
      
      console.log($("#pwd_checking").val());
      
   });
    
   /////////////////////// name ///////////////////////
   //nickname 수정불가 !!!
    
<%--   $("select[name=gender]").change(function(){
  console.log($(this).val()); //value값 가져오기
  console.log($("select[name=gender] option:selected").text()); //text값 가져오기
});
   
   
  $("#nickname").blur(function() {
      if ($("#nickname").val() == "") {
         $("#name_double_check").css("color", "red");
         $("#name_double_check").text("필수정보예요.");
         nickname = false;
      } else {
         $.ajax({
            url  : "<%=request.getContextPath()%>/z_signUp/checkName.jsp",
            type : "post", 
            data : { "nickname" : $("#nickname").val() }, 
            success : function(data) {
               console.log(data.trim()); 
               if (data.trim() == "YES"||data.trim().equals("<%=dto.getNickname()%>")) {
                  $("#name_double_check").css("color", "blue");
                  $("#name_double_check").text("사용할 수 있는 닉네임입니다.");
                  nickname = true;
               } else {
                  $("#name_double_check").css("color", "red");
                  $("#name_double_check").text("이미 존재하거나 탈퇴한 닉네임입니다.");
                  nickname = false;
               }
            },
            error : function() {
               alert('error');
            }
         });
      }
   });    --%>
   
   
   
   
   
   
   
   
   
   ///////////// birth ///////////// 6-26추가
   let reg = /^[0-9]+/g; // 숫자만 입력하는 정규식
   
   $("#year").blur(function() {
      if(!reg.test( $("#year").val())) {
         $("#birth_check").css("color", "red");
          $("#birth_check").text("숫자만 입력해주세요! 형식과 맞지 않을 시 미입력으로 처리됩니다.");
      }else if($("#year").val().length < 4){
         $("#birth_check").css("color", "red");
          $("#birth_check").text("4자리수로 입력해주세요! 형식과 맞지 않을 시 미입력으로 처리됩니다. ");
      }else{
         $("#birth_check").text(""); 
      }
      
   });
 
   $("#day").blur(function() {
      if(!reg.test( $("#day").val())) {
         $("#birth_check").css("color", "red");
          $("#birth_check").text("숫자만 입력해주세요! 형식과 맞지 않을 시 미입력으로 처리됩니다.");
      }else{
         $("#birth_check").text(""); 
      }
   });   
   
   
   //0628 gender값 그대로 가져오기 
   ////////////////////////gender///////////////////////
   
    $("select[name=gender]").change(function(){
  console.log($(this).val()); //value값 가져오기
  console.log($("select[name=gender] option:selected").text()); //text값 가져오기
});
   
   
   /////////////////////// email ///////////////////////
    $("#email").blur(function() {
     let re = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
     
     if ($("#email").val() == "") {
         $("#email_check").css("color", "red");
         $("#email_check").text("필수정보예요.");
         email = false;
      }
      else if(!re.test( $("#email").val())) {
         $("#email_check").css("color", "red");
         $("#email_check").text("이메일 형식이 맞지 않습니다.");
         email = false;
      }else{
         $.ajax({
            url  : "<%=request.getContextPath()%>/z_signUp/checkEmail.jsp", // 이 파일에
            type : "post", // post방식으로
            data : { "email" : $("#email").val() }, // id값을 넘겨라
            success : function(data) {
               console.log(data.trim()); // data == 해당 jsp의 html부분의 전체를 가져온다.(scriptlet 제외)
               if (data.trim() == "YES" ||data.trim().equals("<%=dto.getEmail()%>")) {
                  $("#email_check").css("color", "blue");
                  $("#email_check").text("사용할 수 있는 이메일입니다.");
                  email = true;
               } else {
                  $("#email_check").css("color", "red");
                  $("#email_check").text("사용할 수 없는 이메일입니다.");
                  email = false;
               }
            },
            error : function() {
               alert('error');
            }
         });
      }
   });
 
   
   
   $("#send").click(function(){
      if(pwd == true && pwd_check == true && email == true ){
         $("#frm").attr("action", "<%=request.getContextPath()%>/z_mypage/mypageUpdateAf.jsp"); 
         $("#frm").submit();
      }else{
         alert("입력값을 잘 확인해 주십시오.");
         return;
      }
   }); 
   
   
});
</script>
</body>
</html>