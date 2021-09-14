<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/style.css">
</head>
<body>
<br><br><br><br><br><br><br><br><br><br><br>
<hr>
<div>
<table>
<col width="600px"><col width="600px"><col width="600px">
<tr align="center">
	<td style="font-size: 20px">
	<input type="button" id="serv" onclick="serv1()" value="서비스이용안내" style="border: 0; outline: 0; background-color: white;">
	</td>
	<td style="font-size: 20px">
	<input type="button" id="serv" onclick="serv2()" value="처리방침" style="border: 0; outline: 0; background-color: white;">
	</td>
	<td style="font-size: 20px">
	<input type="button" id="serv" onclick="serv3()" value="참고사이트" style="border: 0; outline: 0; background-color: white;">
	</td>
</tr>
</table>
</div>


<a style="display:scroll;position:fixed;bottom:10px;right:10px;" href="#" ><img src="./image/up2.png" width="40%" ></a>


<script type="text/javascript">
function serv1() {
	   window. open("<%=request.getContextPath()%>/z_footer/footer1.jsp", "popup01", "width=500, height=500");
	}
function serv2() {
	   window. open("<%=request.getContextPath()%>/z_footer/footer2.jsp", "popup01", "width=500, height=500");
	}	
function serv3() {
	   window. open("<%=request.getContextPath()%>/z_footer/footer3.jsp", "popup01", "width=1000, height=1000");
	}	
</script>
<hr>


<div style="background-color: #787878; width: auto; height: 200px; color: white; padding-left: 20%; padding-top: 30px" > 
 <!-- <img alt="" src="./image/123123.png"  width="100%" height="250px">  -->

(주) 고백 <br>
공동 대표 : 강은지 · 고은희 · 김계림 · 이엄지 · 이초희 · 한효경<br>
전화번호 : 011-123-4567 <br>
주소 : 서울시 강남구 도곡동 TP <br>
email : goback@goback.com <br>
ⓒ 2021. GOBACK All rights reserved. <br>

</div>

</body>
</html>