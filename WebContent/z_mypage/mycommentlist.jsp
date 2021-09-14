<%@page import="dto.CommentsDto"%>
<%@page import="dao.CommentsDao"%>
<%@page import="dao.BbsDao"%>
<%@page import="dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.MemberDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
Object objLogin = session.getAttribute("login");
MemberDto mem = null;
if(objLogin == null){
   %>
   <script>
   alert("로그인 해 주십시오");
   location.href = "login.jsp";
   </script>   
   <%
}
mem = (MemberDto)objLogin;
String id = mem.getId();
MemberDao mdao = MemberDao.getInstance();
MemberDto dto = mdao.getMember(id);



%>

<%

CommentsDao dao = CommentsDao.getInstance();
String nickname = request.getParameter("nickname");
String choice = request.getParameter("choice");
String search = request.getParameter("search");

if(choice == null){
   choice = "";
}
if(search == null){
   search = "";
}



// 페이지 번호
String sPageNumber = request.getParameter("pageNumber");
int pageNumber = 0;
if(sPageNumber != null && !sPageNumber.equals("")){
   pageNumber = Integer.parseInt(sPageNumber);
}

System.out.println("sPageNumber:" + sPageNumber);

System.out.println("nickname:" + nickname);
System.out.println("search:" + search);
System.out.println("pageNumber:" + pageNumber);

//한쪽당 글 수 
List<CommentsDto> list = dao.getMyCommentsPagingList(choice, search, pageNumber, nickname);
System.out.print(list.size());
System.out.print(list.toString());

for(CommentsDto c : list){
	System.out.print(c.toString());
}

//글의 총수
int count = dao.MycommentsCount(nickname);
System.out.println("총 글의 수:" +count);
//System.out.println("sPageNumber:" + nickname);
//페이지 수
int bbsPage = 0;
// 페이지 수
/* bbsPage = len / 10;
if((len % 10) > 0){
	bbsPage = bbsPage + 1;
} */

if(list.size() < 10) {
   bbsPage = list.size() / 10;
   if((count % 10) > 0){
   bbsPage = bbsPage + 1;
   }
}else {
   bbsPage = count / 10;
   if((count % 10) > 0){
      bbsPage = bbsPage + 1;
   }
}




%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/all.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {

        $(".all").click(function() {
           //alert("확인용");
           $(".chk").prop("checked", this.checked)
        });
        
     

   
   //처음 들어왔을 때 보이는 검색창
   $(".selectbox").show(function() {
      let state = $(".selectbox option:selected").val();
      if(state == "") {
         $(".textbox").show();
        
         $(".searchbtn2").hide();
      }
   });
   
   //셀렉트 변경했을 때 보이는 검색창
   $(".selectbox").change(function() {
      let state = $(".selectbox option:selected").val();
      if(state == "cago") {
         $(".textbox").hide(); //카테고리 선택시 검색어입력창 숨기기
       
         $(".searchbtn1").hide();
         $(".searchbtn2").show();
      }else {
         $(".textbox").show();
       
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

   
});
</script>
<body>

<br><br>
<form action="<%=request.getContextPath() %>/index.jsp?toss=z_mypage/multidelComment"  method="post" id="multicommentdelete">

<div align="center">
<img alt="" src="./image/admin-004.png" >
</div>
<br><br>
<div align="center" >
<div align="right" >
<input type="submit" value="삭제" >
</div>

      <div class="card-header"
         style="background-color: white; padding-bottom: 0;">
        
         <div class="card-header-right" align="center">
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
      <table class="table table-hover">
<col width="10"><col width="70"><col width="450"><col width="150">
<thead>
<tr style = "background-color:hsl(36, 87%, 64%) !important">

   <th><input type="checkbox" name="all" class="all" onclick="allChk(this.checked);" ></th><th>번호</th><th>댓글내용</th><th>등록일</th>
</tr>
 </thead>
    <tbody>
<%
if(list == null || list.size() == 0){
   %>
      <tr>
         
         <td colspan="5">작성된 글이 없습니다</td>
      </tr>
   <%
}else{
   for(int i = 0;i < list.size(); i++){
     CommentsDto comm = list.get(i);
    // if(mem.getNickname().equals(bbs.getNickname())){
    	
    
         
   %>
      <tr>
         <th><input type="checkbox" name="chk" class="chk"  value="<%=comm.getRenumber()%>"></th>
         <th><%=i+1 %></th>
        
         <td>
            <%
            if(comm.getRenumber() != 0){
               %>

               <a href="<%=request.getContextPath() %>/index.jsp?toss=z_bbs/bbsdetail&seq=<%=comm.getSeq() %>">
                  <%=comm.getContent() %>
               </a>                     
               <%
            }else{
               %>      
               <font color="#ff0000">※ 이 글은 작성자에 의해서 삭제되었습니다</font> 
               <%
            }
            %>
         </td>         
       
         <td><%=comm.getWdate() %></td>
         
      </tr>
   <%
   }
   }
//}

%>
 </tbody>
</table>

   
    <!--   </table> -->
   </div>
</div>



<%
for(int i = 0;i <bbsPage; i++){
   if(pageNumber == i){   
      %>
      <span style="font-size: 15pt; color: #0000ff; font-weight: bold;">
         <%=i + 1 %>
      </span>&nbsp;
      <%      
   }else{               
      %>
      <a href="#none" title="<%=i+1 %>페이지" onclick="goPage(<%=i %>)"
         style="font-size: 15pt;color: #000;font-weight: bold;text-decoration: none;">
         [<%=i + 1 %>]
      </a>&nbsp;
      <%
   }
}
%>
</div>
</form>
<br>
<div align="center">
<select id="choice" class="selectbox">
   <option value="">--선택--</option>
   <option value="content">내용</option>
</select>


<input type="text" id="search" placeholder="검색어를 입력하세요." class="textbox" value="<%=search %>">

<input type="button" value="검색" class="searchbtn1" onclick="searchBtn(1)">  <!-- 검색어 입력시 -->
<input type="button" value="검색" class="searchbtn2" onclick="searchBtn(2)">   <!-- 카테고리 선택시 -->

</div>


<script type="text/javascript">
function searchBtn(n) {
   
   let choice = document.getElementById("choice").value;
   let search = document.getElementById("search").value;
   
   if( n == 1) { //키워드로 검색 시
      if(search.trim() == ""){
         alert("검색어 입력이 필요합니다");
         return;
      }else if(choice.trim() == ""){
         alert("검색할 항목을 선택해주세요");
         return;
      }
      location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_mypage/myfirstpage&tap=mylist&nickname=<%=dto.getNickname()%>&choice=" + choice + "&search=" + search;
   
   }
} 

function goPage( pageNum ) {
	alert(pageNum);
   let choice = document.getElementById("choice").value;
   let search = document.getElementById("search").value;

   location.href =  "<%=request.getContextPath() %>/index.jsp?toss=z_mypage/myfirstpage&tap=mycommentlist&nickname=<%=dto.getNickname()%>&choice="  + choice + "&search=" + search + "&pageNumber=" + pageNum;
}

</script>








</body>
</html>