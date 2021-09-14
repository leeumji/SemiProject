<%@page import="dao.CommentsDao"%>
<%@page import="dto.MemberDto"%>
<%@page import="dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
   String toss = request.getParameter("toss");
   if(toss == null){
      toss = "./z_bbs/bbslist";
   }
%>

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

// 페이지 번호
String sPageNumber = request.getParameter("pageNumber");
int pageNumber = 0;
if(sPageNumber != null && !sPageNumber.equals("")){
   pageNumber = Integer.parseInt(sPageNumber);
}


List<BbsDto> list = dao.getBbsPagingList(choice, search, cagoselect, pageNumber);




//글의 총수
int len = dao.getAllBbs(choice, search, cagoselect);
System.out.println("총 글의 수:" + len);

//페이지 수
   int bbsPage = len / 20;
   if((len%20)>0){
      bbsPage = bbsPage + 1;
   }

%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>당신의 고민, 함께 나누어요 ! </title>
<meta name="viewport" content="width=device-width, initial-scale=1"> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 
<script src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="./css/style.css">



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
<style type="text/css">
table td,
table tr{
padding: 0px !important;
vertical-align: middle !important;
}
</style>
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
<div>
<img align="left" alt="" src="./image/worry.png" ></div>
<div align="right">
     <br><br><br>    <button  type="button" class="btn btn-secondary" onclick=location.href="<%=request.getContextPath() %>/index.jsp?toss=z_bbs/bbswrite">글쓰기</button></div><br> 
<div align="center">
<div class="card" style="width: 100%; height: auto;">
     
   <div class="table-responsive">
      <table class="table table-hover">
      <col width="100px"><col width="500px"><col width="150px"><col width="150px"><col width="100px">
         <thead>
            <tr>
               <th colspan="2" style="text-align: center;">제목</th><th>작성자</th><th>작성일</th><th>조회</th>
            </tr>
         </thead>
         <tbody>
        
         
<% /////////// 댓글수 불러오기//////////// 시작
CommentsDao comDao = CommentsDao.getInstance();
int count;
/////////// 댓글수 불러오기/////////////// 끝


if(list == null || list.size() == 0){
   %>
      <tr>
         <td colspan="5">작성된 글이 없습니다</td>
      </tr>
   <%
}else{
   for(int i = 0;i < list.size(); i++){
	   BbsDto bbs = list.get(i);
   %>
      <tr style="padding: 0px ">
         <td style=" font-size: 13px;"><%=bbs.getCago() %></td>
         <td style=" font-size: 15px;">
            <%
            if(bbs.getDel() == 0){
               %>	<!-- /////////// 댓글수 불러오기/////////////// 시작 -->
					<% if(comDao.commentsCount(bbs.getSeq()) == 0 ){ %>
					<a href = "<%=request.getContextPath() %>/index.jsp?toss=z_bbs/bbsdetail&seq=<%=bbs.getSeq()%>"><%=bbs.getTitle() %> </a>
					<%}else{ %>
					
					<a href = "<%=request.getContextPath() %>/index.jsp?toss=z_bbs/bbsdetail&seq=<%=bbs.getSeq()%>"><%=bbs.getTitle() %> [<%=count = comDao.commentsCount(bbs.getSeq()) %>]</a>									
					<% }     /////////// 댓글수 불러오기/////////////// 끝
            }
	   %>
            
            <% 
            String filename =bbs.getFilename();
            if(filename != null){
            %>       
             <img alt="" src="./image/fileImg.png" width="20" height="20" >                   
            <%
            }
            %>
            
         </td>   
         <td><%=bbs.getNickname() %></td>   
         <td><%=bbs.getWdate().substring(0,11) %></td>
         <td> <%=bbs.getReadcount() %></td>
      </tr>
   <%
   }
}
%>
</tbody>
</table>
   </div>
</div>
</div>

<br>
<div align="center">
<%
for(int i = 0;i < bbsPage; i++){
   if(pageNumber == i){   
      %>
      <span style="font-size: 15pt; color: orange ; font-weight: bold;">
         <%=i + 1 %>
      </span>&nbsp;
      <%      
   }else{               
      %>
      <a href="#none" title="<%=i+1 %>페이지" onclick="goPage(<%=i %>)"
         style="font-size: 15pt;color:silver ;font-weight: bold;text-decoration: none;">
         [<%=i + 1 %>]
      </a>&nbsp;
      <%
   }
}
%>


<br><br>
<select id="choice" class="selectbox" style="height: 30px">
   <option value="">--선택--</option>
   <option value="nickname">글쓴이</option>
   <option value="cago">카테고리</option>
   <option value="title">제목</option>
   <option value="content">내용</option>
</select>


<select class="cagoselect" style="height: 30px; width: 177px;">
   <option value="">--카테고리선택--</option>
   <option value="학업·진로">학업·진로</option>
   <option value="연애·가족">연애·가족</option>
   <option value="대인관계">대인관계</option>
   <option value="심리·정서">심리·정서</option>
   <option value="심리·정서">금전</option>
   <option value="기타">기타</option>
</select>

<input type="text" id="search" placeholder="검색어를 입력하세요." class="textbox" value="<%=search %>">

<button class="searchbtn1" style="border: 0; background-color: white;" onclick="searchBtn(1)"><img alt="" src="<%=request.getContextPath()%>/image/search.png"> </button>
<button class="searchbtn2" style="border: 0; background-color: white;" onclick="searchBtn(2)"><img alt="" src="<%=request.getContextPath()%>/image/search.png"> </button>


</div>


<script type="text/javascript">
function searchBtn(n) {
let choice = document.getElementById("choice").value;
let search = document.getElementById("search").value;
let cagoselect = document.getElementsByClassName("cagoselect")[0].value;

if( n == 1) { //키워드로 검색 시
   if(search.trim() == ""){
      alert("검색어 입력이 필요합니다");
      return;
   }else if(choice.trim() == ""){
      alert("검색할 항목을 선택해주세요");
      return;
   }
   location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_bbs/bbslist&choice=" + choice + "&search=" + search;
   
}else if( n == 2) { //카테고리로 검색 시
  // alert(cagoselect.trim());
   if(cagoselect.trim() == ""){
      alert("카테고리를 선택해주세요");
      return;
   }
   location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_bbs/bbslist&choice=" + choice + "&cagoselect=" + cagoselect; 
}

} 

function goPage( pageNum ) {
   let choice = document.getElementById('choice').value;
   let search = document.getElementById("search").value;
   
   location.href =  "<%=request.getContextPath() %>/index.jsp?toss=z_bbs/bbslist&choice="  + choice + "&search=" + search + "&pageNumber=" + pageNum;
}

</script>
</body>
</html>




