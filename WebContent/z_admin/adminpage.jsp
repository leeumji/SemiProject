<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%
	String toss = request.getParameter("toss");
	if(toss == null){
		toss = request.getContextPath() + "/z_admin/adminpage";
	}
%>   --%>  
<%
String tap = request.getParameter("tap");
 if(tap == null) {
	tap = "blank";
} 
System.out.println("tap"+tap);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/all.css">
<style type="text/css">
#admin-005 {
	height: 70px;
	width: 200px;
	padding-right: 40px;
}


</style>
<title>Insert title here</title>
</head>
<body>


<!-- <h4>관리자 페이지</h4> -->
<div align="center">

<table>
<col width="200px"><col width="800px">
<tr height="600px">

	<td>
		<img id="admin-005" src="image/admin-005.jpg">
		<jsp:include page="admintap.jsp" flush="false"/>
	</td>
	
	<td>
		<jsp:include page='<%=tap + ".jsp" %>' flush="false"/> 
	</td>
</tr>
	
</table>

</div>

</body>
</html>