<%@page import="dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    


<%
String choice = request.getParameter("choice");
String search = request.getParameter("search");
String cagoselect = request.getParameter("cagoselect");
if(choice == null){
   choice = "";
}
if(search == null){
   search = "";
}
if(cagoselect == null){
   cagoselect = "";
}

%>

<%
BbsDao dao = BbsDao.getInstance();

//현재 페이지 번호 불러오기
String sPageNumber = request.getParameter("pageNumber");
int pageNumber = 0;
if(sPageNumber!=null&&!sPageNumber.equals("")){
   pageNumber = Integer.parseInt(sPageNumber);
}
System.out.println("pageNumber : " + pageNumber);


//한페이지에 불러오는 글 수
List<BbsDto> list = dao.getBbsPagingList(choice, search, cagoselect, pageNumber);
System.out.println("한페이지의 글 수 : " + list.size());

//글의 총 수 불러오기
int len = dao.getAllBbs(choice, search, cagoselect);
System.out.println("총 글의 수 : " + len);

//페이지수 넣어주기
int bbsPage = len/10; 
if((len % 10)>0){
   bbsPage = bbsPage+1;
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

<title>adminbbslist.jsp</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script type="text/javascript">
$(document).ready(function() {

   $(".checkbox_parent").click(function() {
      //alert("확인용");
      $(".checkbox_child").prop("checked", this.checked)
   });
   
   //처음 들어왔을 때 보이는 검색창
   $(".selectbox").show(function() {
      let state = $(".selectbox option:selected").val();
      if(state == "") {
         $(".textbox").show();
         $(".cagoselect").hide();
         $(".searchbtn2").hide();
      }
   });
   
   //셀렉트 변경했을 때 보이는 검색창
   $(".selectbox").change(function() {
      let state = $(".selectbox option:selected").val();
      if(state == "cago") {
         $(".textbox").hide(); //카테고리 선택시 검색어입력창 숨기기
         $(".cagoselect").show();
         $(".searchbtn1").hide();
         $(".searchbtn2").show();
      }else {
         $(".textbox").show();
         $(".cagoselect").hide();
         $(".searchbtn2").hide();
         $(".searchbtn1").show();
      }
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
   
   let obj2 = document.getElementsByClassName("cagoselect")[0];
   obj2.value = "<%=cagoselect %>";
   obj2.setAttribute("selected", "selected");
   
});
</script>

<body>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
    

<div class="card-header" style="background-color: white; padding-bottom: 0;">
   <img alt="" src="./image/admin-003.png" >
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
<form action="<%=request.getContextPath() %>/index.jsp?toss=z_admin/adminpage&tap=adminbbsdelete" method="post">
<div align="right" >
<input type="submit" value="삭제" onsubmit="return deletefunc()" >
</div><br>

<div align="center" >
<table class="table table-hover">
<col width="30"><col width="70"><col width="150"><col width="420"><col width="120"><col width="170">
<tr style = "background-color:hsl(36, 87%, 64%) !important">
   <th><input type="checkbox" class="checkbox_parent"></th><th>번호</th><th>카테고리</th><th>제목</th><th>글쓴이</th><th>등록일</th>
</tr>

<%
if(list == null || list.size() == 0){
   %>
      <tr>
         <th><input type="checkbox" class="checkbox_child"></th>
         <td colspan="5">작성된 글이 없습니다</td>
      </tr>
   <%
}else{
   for(int i = 0;i < list.size(); i++){
      BbsDto bbs = list.get(i);
   %>
      <tr>
         <th><input type="checkbox" class="checkbox_child" name="cheack_each" value="<%=bbs.getSeq() %>"></th>
         <th><%=i + 1 %></th>
         <td><%=bbs.getCago() %></td>
         <td>
            <%
            if(bbs.getDel() == 0){
               %>

               <a href="<%=request.getContextPath() %>/index.jsp?toss=z_bbs/bbsdetail&seq=<%=bbs.getSeq() %>">
                  <%=bbs.getTitle() %>
               </a>                     
               <%
            }else{
               %>      
               <font color="#ff0000">※ 이 글은 관리자에 의해서 삭제되었습니다</font> 
               <%
            }
            %>
         </td>         
         <td><%=bbs.getNickname() %></td>
         <td><%=bbs.getWdate().substring(0, 16) %></td>
         
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
   <option value="cago">카테고리</option>
   <option value="title">제목</option>
   <option value="content">내용</option>
</select>

<select class="cagoselect">
   <option value="">--카테고리선택--</option>
   <option value="학업·진로">학업·진로</option>
   <option value="연애·가족">연애·가족</option>
   <option value="대인관계">대인관계</option>
   <option value="심리·정서">심리·정서</option>
   <option value="금전">금전</option>
   <option value="기타">기타</option>
</select>
<input type="text" id="search" placeholder="검색어를 입력해주세요." class="textbox" value="<%=search %>">

<input type="button" value="검색" class="searchbtn1" onclick="searchBtn(1)">  <!-- 검색어 입력시 -->
<input type="button" value="검색" class="searchbtn2" onclick="searchBtn(2)">   <!-- 카테고리 선택시 -->




<script type="text/javascript">
function searchBtn(n) {
   
   let choice = document.getElementById("choice").value;
   let search = document.getElementById("search").value;
   let cagoselect = document.getElementsByClassName("cagoselect")[0].value;

   if( n == 1) { //키워드로 검색 시
      if(search.trim() == ""){
         alert("검색어를 입력해주세요.");
         return;
      }else if(choice.trim() == ""){
         alert("검색할 항목을 선택해주세요");
         return;
      }
      location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_admin/adminpage&tap=adminbbslist&choice=" + choice + "&search=" + search;
   
   }else if( n == 2) { //카테고리로 검색 시
      alert(cagoselect.trim());
      if(cagoselect.trim() == ""){
         alert("카테고리를 선택해주세요");
         return;
      }
      location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_admin/adminpage&tap=adminbbslist&choice=" + choice + "&cagoselect=" + cagoselect; 
   }

}

function deletefunc() {
	    if(confirm("삭제하시겠습니까 ?") == true){
	        return true;
	    }
	    else{
	        return false;
	    }
	});
}

function goPage( pageNum ) {
   let choice = document.getElementById("choice").value;
   let search = document.getElementById("search").value;

   location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_admin/adminpage&tap=adminbbslist&choice=" + choice + "&search=" + search + "&pageNumber=" + pageNum;
}

</script>

</body>
</html>