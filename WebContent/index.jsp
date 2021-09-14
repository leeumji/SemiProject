<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String toss = request.getParameter("toss");
	if(toss == null){
		toss = "home";
	}
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main index</title>
<meta name="viewport" content="width=device-width, initial-scale=1"> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 
<link rel="stylesheet" href="./css/style.css">
<style type="text/css">
body{ font-family: 'Sunflower', sans-serif; font-weight: 800; } 
</style>


</head>
<body>


<!-- 상단고정 -->
<header>
<div align="center"><table style="width: auto;"><tr>
	<td>
		<jsp:include page="menu.jsp" flush="false" />
	</td>
</tr></table></div>
</header>


<!-- 링크들 -->
<nav>
<div align="center"><table style="width: auto;"><tr>
	<td>
		<jsp:include page='<%=toss + ".jsp" %>' flush="false" />
	</td>
</tr></table></div>
</nav>


<footer>
<div align="center"><table style="width: 3000;"><tr>
	<td>
		<jsp:include page="bottom.jsp" flush="false" />
	</td>
</tr></table></div>
</footer>
</body>
</html>
