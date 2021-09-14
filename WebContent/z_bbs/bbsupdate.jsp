<%@page import="dao.MemberDao"%>
<%@page import="dto.MemberDto"%>
<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<style type="text/css">
.button {
  width: 140px;
  height: 45px;
  font-family: 'Roboto', sans-serif;
  font-size: 13px;
  text-transform: uppercase;
  letter-spacing: 2.5px;
  font-weight: 500;
  color: #000;
  background-color: dark;
  border: none;
  border-radius: 45px;
  box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease 0s;
  cursor: pointer;
  outline: none;
  }

.button:hover {
  background-color: orange;
  box-shadow: orange;
  color: #fff;
  transform: translateY(-7px);
}

</style>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>bbsupdate</title>

</head>
<body>
<div align="left">
<a href="<%=request.getContextPath()%>/index.jsp?toss=z_bbs/bbslist"><img alt="" src="./image/worry.png"></a>
</div>
<%
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq.trim());

BbsDao dao = BbsDao.getInstance();
BbsDto bbs = dao.getBbs(seq);
%>

<%
Object ologin = session.getAttribute("login");
MemberDto mem = null;
mem = (MemberDto)ologin;
%>
<div align="right" class="container" style="width: 1000px" >
<button type="button" class="btn btn-outline-secondary" style='width:70px; font-size: 13px; padding: 3px 3px 3px 3px;' onclick='location.href="<%=request.getContextPath() %>/index.jsp?toss=z_bbs/bbslist"'>글목록</button>
</div>
<div align="left" class="container" style="width: 1000px" >


<form action="<%=request.getContextPath() %>/index.jsp?toss=z_bbs/bbsupdateAf" method="post" enctype="multipart/form-data">
<input type="hidden" name="seq" value="<%=seq %>">

	<select name="cago" class="form-control" style="width: 100px; height: 30px; font-size: 13px;">
		<option value="학업·진로">학업·진로</option>
		<option value="연애·가족">연애·가족</option>
		<option value="대인관계">대인관계</option>
		<option value="심리·정서">심리·정서</option>
		<option value="금전">금전</option>
		<option value="기타">기타</option>
	</select><br>

    <textarea rows="1" cols="70" name="title" style=" margin: 0px; border-color: white; font-size: 25px"><%=bbs.getTitle() %></textarea><hr>
   	<textarea rows="15" cols="85" name="content"style=" margin: 0px; border-color: white; font-size: 20px"><%=bbs.getContent().replace("<br>", "\n") %></textarea><hr>
   	<table>
   	<col width="1000px">
   	<tr><td>
	<%
	String filename = bbs.getFilename();
		if(filename == null){
			filename="등록된 파일이 없습니다.";
		}
	%>
	<p><input type = "file" name = "fileload"  style = "width : 500px" ><input type = "checkbox" name = "deletefile" >&nbsp;파일제거</p>	
	<p><input type = "text" class='form-control' name = "oldfile"  style = "width : 500px; height: 30px;" value="<%=filename %>"></p>
	
	</td></tr>
	<tr align="right"><td>
	<input type="submit" class="btn btn-secondary" id="commentWrite" value="update" style='width:70px; font-size: 13px; padding: 3px 3px 3px 3px;'>
	</td></tr></table>
</form>
<br>

</div>
</body>
</html>