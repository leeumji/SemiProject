<%@page import="dto.CommentsDto"%>
<%@page import="dao.CommentsDao"%>
<%@page import="dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    


<%
String choice = request.getParameter("choice");
String search = request.getParameter("search");
if(choice == null){
   choice = "";
}
if(search == null){
   search = "";
}

%>


<%
CommentsDao dao = CommentsDao.getInstance();
BbsDao bbsdao = BbsDao.getInstance();
List<BbsDto> bbslist = bbsdao.getBbsList();

//페이지 번호
String sPageNumber = request.getParameter("pageNumber");
int pageNumber = 0;
if(sPageNumber != null && !sPageNumber.equals("")){
   pageNumber = Integer.parseInt(sPageNumber);
}
//List<CommentsDto> list = dao.getAllCommentsList();
List<CommentsDto> list = dao.getCommentsPagingList(choice, search, pageNumber);
System.out.println("한페이지의 글 수 : " + list.size());

//글의 총수
int len = dao.getAllCommentsList(choice, search);
System.out.println("총 글의 수:" + len);

//페이지 수
int bbsPage = len / 10;      // 24 / 10 -> 2
if((len % 10) > 0){
   bbsPage = bbsPage + 1;
}
%>    
    
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1"> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> 
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/all.css">
<link rel="stylesheet" href="./css/main.css">

<link rel="canonical" href="">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>

<title>admincommentlist.jsp</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script type="text/javascript">
$(document).ready(function() {

   $(".checkbox_parent").click(function() {
      //alert("확인용");
      $(".checkbox_child").prop("checked", this.checked)
   });

   
});
</script>
</head>
<script type="text/javascript">
$(document).ready(function() {   
   let search = "<%=search %>";
   if(search == "") return;
   
   let obj = document.getElementById("choice"); 
   obj.value = "<%=choice %>";
   obj.setAttribute("selected", "selected");

   
});
</script>

<body>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
    


<div class="card-header" style="background-color: white; padding-bottom: 0;">
   <img alt="" src="./image/admin-004.png" >
   <div class="card-header-right">
      <ul class="list-unstyled card-option">
         <li><i class="icofont icofont-simple-left "></i></li>
         <li><i class="icofont icofont-maximize full-card"></i></li>
         <li><i class="icofont icofont-minus minimize-card"></i></li>
         <li><i class="icofont icofont-refresh reload-card"></i></li>
         <li><i class="icofont icofont-error close-card"></i></li>
      </ul>
   </div>
</div>
<div class="card-block table-border-style">
   <div class="table-responsive">

<br><br>
<form action="<%=request.getContextPath() %>/index.jsp?toss=z_admin/adminpage&tap=admincommentdelete" method="post">
<div align="right" >
<input type="submit" value="삭제" >
</div><br>

<div align="center">
<table class="table table-hover">
<col width="50"><col width="100"><col width="500"><col width="120"><col width="150">
<tr style = "background-color:hsl(36, 87%, 64%) !important">
   <th><input type="checkbox" class="checkbox_parent"></th><th>번호</th><th>댓글내용</th><th>글쓴이</th><th>등록일</th>
</tr>

<%
if(list == null || list.size() == 0){
   %>
      <tr>
         <th><input type="checkbox" class="checkbox_child"></th>
         <td colspan="4">작성된 댓글이 없습니다</td>
      </tr>
   <%
}else{
   for(int i = 0;i < list.size(); i++){
      CommentsDto comm = list.get(i);
      BbsDto bbsli = bbslist.get(i); //관리자에 의해 삭제된 글 확인하기 위해~
   %>
      <tr>
         <th><input type="checkbox" class="checkbox_child" name="cheack_each" value="<%=comm.getRenumber() %>"></th>
         <th><%=i + 1 %></th>
         <td>
            <%
            if(comm.getRenumber() != 0){
               if(bbsli.getDel() == 0) { //del이 0이면 부모글 삭제 안된 것
               %>
               <a href="<%=request.getContextPath() %>/index.jsp?toss=z_bbs/bbsdetail&seq=<%=comm.getSeq() %>">
                  <%=comm.getContent() %>
               </a>                     
               <%
               }else {
               %>
               <font color="#ff0000">※ 원본글이 관리자에 의해서 삭제되었습니다</font> 
               <%   
               }
            }else{
               %>      
               <font color="#ff0000">※ 이 댓글은 관리자에 의해서 삭제되었습니다</font> 
               <%
            }
            %>
         </td>         
         <td><%=comm.getNickname() %></td>
         <td><%=comm.getWdate().substring(0, 16) %></td>
         
      </tr>
   <%
   }
}
%>
</table>
</form>

<%
for(int i = 0;i < bbsPage; i++){  
   if(pageNumber == i){   
      %>
      <span style="font-size: 15pt; color: orange; font-weight: bold;">
         <%=i + 1 %>
      </span>&nbsp;
      <%      
   }else{               
      %>
      <a href="#none" title="<%=i+1 %>페이지" onclick="goPage(<%=i %>)"
         style="font-size: 15pt; color: #d2d2d2; font-weight: bold;text-decoration: none;">
         [<%=i + 1 %>]
      </a>&nbsp;
      <%
   }
}
%> 

<br>
<select id="choice" class="selectbox">
   <option value="">--선택--</option>
   <option value="nickname">글쓴이</option>
   <option value="content">내용</option>
</select>

<input type="text" id="search" placeholder="검색어를 입력해주세요." class="textbox" value="<%=search %>">

<input type="button" value="검색" class="searchbtn" onclick="searchBtn()">  <!-- 검색어 입력시 -->




<script type="text/javascript">
function searchBtn() {
   
   let choice = document.getElementById("choice").value;
   let search = document.getElementById("search").value;
   
      if(search.trim() == ""){
         alert("검색어를 입력해주세요.");
         return;
      }else if(choice.trim() == ""){
         alert("검색할 항목을 선택해주세요");
         return;
      }
      location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_admin/adminpage&tap=admincommentlist&choice=" + choice + "&search=" + search;

   
}
function goPage( pageNum ) {
   let choice = document.getElementById("choice").value;
   let search = document.getElementById("search").value;

   location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_admin/adminpage&tap=admincommentlist&choice=" + choice + "&search=" + search + "&pageNumber=" + pageNum;
}

</script>

</body>
</html>