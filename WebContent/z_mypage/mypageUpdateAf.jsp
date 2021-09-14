<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%
request.setCharacterEncoding("utf-8");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/all.css">
<title>Insert title here</title>
</head>
<body>
<%!
public String two(String msg){
   return msg.trim().length()<2?"0"+msg:msg.trim();   // 1 ~ 9 -> 01
}
%>
<% 

String pwd = request.getParameter("pwd");
String nickname = request.getParameter("nickname");


String year = request.getParameter("year");
String month = two(request.getParameter("month"));
String day = request.getParameter("day");

String birth = year+month+day;
if(birth.length() > 9||birth.length()<8){
	birth = " ";
	
}
try{
	int birthInt = Integer.parseInt(birth);
} catch (NumberFormatException nfe){
	birth = " ";
}




String gender = request.getParameter("gender");
String email = request.getParameter("email");
String id = request.getParameter("id");

MemberDao dao = MemberDao.getInstance();


if(gender==null){
	gender=" ";
}

boolean isS= dao.updateMypage(pwd, nickname, birth, gender, email, id);
System.out.println(isS);
if(isS == true){
%>
   <script type="text/javascript">
   alert('수정완료되었습니다');
   location.href ='<%=request.getContextPath() %>/index.jsp?toss=z_mypage/myfirstpage&tap=mypage&id=<%=id %>';
   </script>
   <%
}else{
%>
<script type="text/javascript">
alert('수정실패');
location.href ='<%=request.getContextPath() %>/index.jsp?toss=z_mypage/myfirstpage&tap=mypageUpdate&id=<%=id %>';
</script>
<%
}
%>
</body>
</html>