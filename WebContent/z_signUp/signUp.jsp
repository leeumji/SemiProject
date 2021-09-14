<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
   String content = request.getParameter("content");
   if(content == null){
      content = "./z_signUp/signUp";
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
<link rel="stylesheet" href="../css/style.css">
</head>
<body>


<div style="height: 50px"></div><br><br>

<!-- 메인 바로가기 -->
<div align="center">
<a href="<%=request.getContextPath()%>/index.html" >
<img src="<%=request.getContextPath() %>/image/login.png"></a>
<br><br>

<div align="center" style="width:30%; height: 1500px; border: 1px solid #DCDCDC;">
<br>
<h1>회원가입</h1><br>
<hr align="center" width="80%">
<form id="frm" method="post">
<table>
<col width="310px">
<tr><th>아이디<p></p></th></tr>
<tr><td>
   <input type="text" id="id" name="id" class="form-control" placeholder="필수입력 (5자리 이상)" maxlength="15" ><p></p>
   <p id="id_double_check" class="sign_p"></p>
</td></tr>

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
   <input type="text" id="nickname" name="nickname" class="form-control" placeholder="필수입력" maxlength="15" ><p></p>
   <p id="name_double_check" class="sign_p"></p>
</td></tr>
<tr><th><p></p>생년월일<p></p></th></tr>
<tr><td>
  <div class="input-group mb-3">
    <input type="text" id="year" name="year" placeholder="생년월일(4자)"class="form-control" maxlength="4"
         style="width: 50px; font-size:15px;">&nbsp;

    <select id="month" name="month" class="form-control"style="width: 30px; height: 37px; ">
      <option value="">월</option>
      <option value="01">1</option>
      <option value="02">2</option>
      <option value="03">3</option>
      <option value="04">4</option>
      <option value="05">5</option>
      <option value="06">6</option>
      <option value="07">7</option>
      <option value="08">8</option>
      <option value="09">9</option>
      <option value="10">10</option>
      <option value="11">11</option>
      <option value="12">12</option>
   </select>&nbsp;
    <input type="text" id="day" name="day" class="form-control" placeholder="일" maxlength="2"
         style="width: 30px;  font-size:15px; border-top-right-radius: 4px; border-bottom-right-radius: 4px;"><p></p>
   <p id="year_check" class="sign_p"></p>
   <p id="day_check" class="sign_p"></p>
  </div>
</td></tr>


<tr><td>성별<p></p></td></tr>
<tr><td>
<select name="gender" class="form-control">
<option value="">성별</option>
<option value="남자">남자🧑</option>
<option value="여자">여자👧</option>
<option value="">선택안함🐣</option>
</select><p></p>
</td></tr>


<tr><td><p></p>이메일<p></p></td></tr>
<tr><td>
<input type="text" id="email" name="email" class="form-control" placeholder="필수입력 (@를 포함하여 주십시오.)">
<p id="email_check" class="sign_p"></p><p></p>
</td></tr>

<tr><td>

<br>
<input type="button" id="send" class="btn btn-secondary" style="width: 300px; height: 50px;" value="가입하기" >
</td></tr>
</table>
</form>
</div>
</div>

<br>

<script type="text/javascript">
let id = false;
let pwd = false;
let pwd_check = false;
let nickname = false;
let email = false; 

$(document).ready(function() {
	
	
   /////////////////////// id ///////////////////////
   
   $("#id").blur(function() {
	  let idCheck = /^[a-zA-Z0-9]{5,15}$/;
	  
      if ($("#id").val() == "") {
         $("#id_double_check").css("color", "red");
         $("#id_double_check").text("필수정보예요 📝");
         id = false;
      } else if(!idCheck.test($("#id").val())) {
         $("#id_double_check").css("color", "red");
         $("#id_double_check").text("아이디는 영문과 숫자만 가능합니다.(5글자 이상) 🌱");
         id = false;
      } else {
         $.ajax({
            url  : "checkId.jsp", // 이 파일에
            type : "post", // post방식으로
            data : { "id" : $("#id").val() }, // id값을 넘겨라
            success : function(data) {
               console.log(data.trim()); // data == 해당 jsp의 html부분의 전체를 가져온다.(scriptlet 제외)
               if (data.trim() == "YES") {
                  $("#id_double_check").css("color", "blue");
                  $("#id_double_check").text("사용가능한 아이디입니다 👌");
                  id = true;
               } else {
                  $("#id_double_check").css("color", "red");
                  $("#id_double_check").text("이미 존재하거나 탈퇴한 아이디입니다 😔");
                  id = false;
               }
            },
            error : function() {
               alert('error');
            }
         });
      }
   });
   
   
    /////////////////////// pwd ///////////////////////
    
   $("#pwd").blur(function() {
	  let pwdCheck = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,20}$/;
	  
      if ($("#pwd").val() == "") {
         $("#pwd_check").css("color", "red");
         $("#pwd_check").text("필수정보예요 📝");
         pwd = false;
      }	
      else if (!pwdCheck.test($("#pwd").val())) {
	  	 $("#pwd_check").css("color", "red");
	     $("#pwd_check").text("비밀번호는 영문자+숫자+특수문자 조합으로 8~20자리를 사용해야 합니다 💬");
	     pwd = false;
	  }
   	  else{
          if($("#pwd_checking").val().length == 0){
            $("#pwd_check").css("color", "blue");
            $("#pwd_check").text("완벽한 비밀번호 입니다 🔐");
            pwd = true;
         }else if($("#pwd_checking").val().length > 0 && $("#pwd").val() != $("#pwd_checking").val()){
            $("#pwd_double_check").css("color", "red");
            $("#pwd_double_check").text("비밀번호가 일치하지 않습니다 🙁");
            pwd_check = false;
         }else if($("#pwd_checking").val().length > 0 && $("#pwd").val() == $("#pwd_checking").val()){
            $("#pwd_double_check").css("color", "blue");
            $("#pwd_double_check").text("비밀번호가 일치합니다 🙂");
            $("#pwd_check").css("color", "blue");
            $("#pwd_check").text("완벽한 비밀번호네요 🔐");
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
	         $("#pwd_double_check").text("필수정보예요 📝");
	         pwd = false;
	   }else if($("#pwd").val() != $("#pwd_checking").val()){
         $("#pwd_double_check").css("color", "red");
         $("#pwd_double_check").text("비밀번호가 일치하지 않습니다 🙁");
         pwd_check = false;
       }else if($("#pwd").val() == $("#pwd_checking").val()){
         $("#pwd_double_check").css("color", "blue");
         $("#pwd_double_check").text("비밀번호가 일치합니다 🙂");
         pwd_check = true;
       }
      
      console.log($("#pwd_checking").val());
      
   });
    
    
   /////////////////////// name ///////////////////////
    
   $("#nickname").blur(function() {
      if ($("#nickname").val() == "") {
         $("#name_double_check").css("color", "red");
         $("#name_double_check").text("필수정보예요 📝");
         nickname = false;
      } else {
         $.ajax({
            url  : "checkName.jsp",
            type : "post", 
            data : { "nickname" : $("#nickname").val() }, 
            success : function(data) {
               console.log(data.trim()); 
               if (data.trim() == "YES") {
                  $("#name_double_check").css("color", "blue");
                  $("#name_double_check").text("정말 멋진 닉네임이네요 😎");
                  nickname = true;
               } else {
                  $("#name_double_check").css("color", "red");
                  $("#name_double_check").text("이미 존재하거나 탈퇴한 닉네임입니다 😔");
                  nickname = false;
               }
            },
            error : function() {
               alert('error');
            }
         });
      }
   });   

   
   ///////////// birth ///////////// 6-26추가
   let reg = /^[0-9]*$/; // 숫자만 입력하는 정규식
   
   $("#year").blur(function() {
	   if(!reg.test( $("#year").val())) {
		   $("#year_check").css("color", "red");
	       $("#year_check").text("년도는 숫자만 입력해주세요! 형식과 맞지 않을 시 미입력으로 처리됩니다 📆");
	   }else if($("#year").val().length < 4){
		   $("#year_check").css("color", "red");
	       $("#year_check").text("년도는 4자리수로 입력해주세요! 형식과 맞지 않을 시 미입력으로 처리됩니다 📆");
	   }else{
		   $("#year_check").css("color", "blue");
	       $("#year_check").text("");
	   }
   });
   
   $("#day").blur(function() {
	   if(!reg.test( $("#day").val())) {
		   $("#day_check").css("color", "red");
	       $("#day_check").text("일은 숫자만 입력해주세요! 형식과 맞지 않을 시 미입력으로 처리됩니다 📆");
	   }else{
		   $("#day_check").css("color", "blue");
	       $("#day_check").text("");
	   }
   });   
   
   
   /////////////////////// email ///////////////////////

   $("#email").blur(function() {
	  let re = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
     
	  if ($("#email").val() == "") {
         $("#email_check").css("color", "red");
         $("#email_check").text("필수정보예요 📝");
         email = false;
      }
      else if(!re.test( $("#email").val())) {
         $("#email_check").css("color", "red");
         $("#email_check").text("이메일 형식이 맞지 않습니다 📧");
         email = false;
      }else{
         $.ajax({
            url  : "checkEmail.jsp", // 이 파일에
            type : "post", // post방식으로
            data : { "email" : $("#email").val() }, // id값을 넘겨라
            success : function(data) {
               console.log(data.trim()); // data == 해당 jsp의 html부분의 전체를 가져온다.(scriptlet 제외)
               if (data.trim() == "YES") {
                  $("#email_check").css("color", "blue");
                  $("#email_check").text("사용할 수 있는 이메일입니다 💌");
                  email = true;
               } else {
                  $("#email_check").css("color", "red");
                  $("#email_check").text("사용할 수 없는 이메일입니다 🚫");
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
		if(id == true && pwd == true && pwd_check == true && nickname == true && email == true ){
			$("#frm").attr("action", "signUpAf.jsp"); 
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