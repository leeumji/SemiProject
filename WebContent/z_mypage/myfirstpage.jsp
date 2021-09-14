<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<%
String tap = request.getParameter("tap");
 if(tap == null) {
	tap = "mypageImg";
} 
System.out.println("tap"+tap);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/all.css">
<style type="text/css">
/* #mypageimg {
	height: 70px;
	width: 200px;
	padding-right: 40px;
} */

</style>
<title>Insert title here</title>
</head>
<body>



<div align="center">

<table>
<col width="200px"><col width="800px">
<tr height="600px">

	<td>
<!-- 	<img id="mypageimg" src="image/mypage1.png"> -->
	
		<jsp:include page="mypagetap.jsp" flush="false"/>
	</td>
	
	<td>
		<jsp:include page='<%=tap + ".jsp" %>' flush="false"/> 
	</td>
</tr>
	
</table>

</div>

</body>
</html>