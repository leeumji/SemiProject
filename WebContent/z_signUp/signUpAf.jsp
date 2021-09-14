<%@page import="dto.MemberDto"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String id = request.getParameter("id");
String pwd = request.getParameter("pwd");
String nickname = request.getParameter("nickname");

String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");
if(day.length() == 1){
	day = "0"+day;
}
String birth = year+month+day;
if(birth.length() > 9){
	birth = "";
}
try{
	int birthInt = Integer.parseInt(birth);
} catch (NumberFormatException nfe){
	birth = "";
}

String gender = request.getParameter("gender");
String email = request.getParameter("email");

System.out.println("id : " + id);
System.out.println("pwd : " + pwd);
System.out.println("nickname : " + nickname);
System.out.println("birth : " + birth);
System.out.println("gender : " + gender);
System.out.println("email : " + email);



MemberDao dao = MemberDao.getInstance();
MemberDto dto = new MemberDto(id, pwd, nickname, birth, gender, email, 0);

boolean flag = dao.addMember(dto);

if(id == null || id.length() < 5 ||  
   pwd == null || pwd.length() < 8 || 
   nickname == null || email == null || email.equals("") ){

%>
	<script>
		alert("필수 입력사항을 작성하여 주십시오.");
		location.href = "signUp.jsp";
	</script>
<%}else if(flag == true){%> 
<script>	
	alert("가입에 성공하였습니다.");
	location.href = "<%=request.getContextPath()%>/z_login/login.jsp";
</script>
   
<%} else {%>  
<script>
	alert("다시 기입해주세요.");
	location.href = "signUp.jsp";
</script>
<%} %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>