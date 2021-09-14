<%@page import="dao.CommentsDao"%>
<%@page import="dao.MemberDao"%>
<%@page import="dto.MemberDto"%>
<%@page import="dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.BbsDao"%>
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
BbsDao dao = BbsDao.getInstance();
String choice = request.getParameter("choice");
String search = request.getParameter("search");
String cagoselect = request.getParameter("cagoselect");
String nickname = request.getParameter("nickname");
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


// 현재 페이지 번호 불러오기
String sPageNumber = request.getParameter("pageNumber");
int pageNumber = 0;
if(sPageNumber != null && !sPageNumber.equals("")){
   pageNumber = Integer.parseInt(sPageNumber);
}

System.out.println("sPageNumber:" + sPageNumber);

//한페이지에 불러오는 글 수 
List<BbsDto> list = dao.getMyBbsPagingList(choice, search, cagoselect, pageNumber, nickname);
System.out.print(list.size());
System.out.print(list.toString());

//글의 총수
int len = dao.getMyBbs(choice, search, nickname);
System.out.println("총 글의 수:" + len);
//System.out.println("sPageNumber:" + nickname);

 

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
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/all.css">
<title>mypagelist.jsp</title>

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
   
   /* $("#insert_btn").click(function(){
	    if(confirm("정말 등록하시겠습니까 ?") == true){
	        alert("등록되었습니다");
	    }
	    else{
	        return ;
	    }
	}); */

});
</script>
<style type="text/css">

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



<br><br>
<form action="<%=request.getContextPath() %>/index.jsp?toss=z_mypage/multidel"  method="post" id="multidelete">


<div align="center">
<img alt="" src="./image/title.png" >
</div>
<br><br>
<div align="center">
<div align="right" >

<input type="submit" value="삭제" onclick="button_event()">
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
<!-- <table border="1"> -->
<col width="10"><col width="70"><col width="150"><col width="500"><col width="120"><col width="150"><col width="150">
<thead>
<tr style = "background-color:hsl(36, 87%, 64%) !important">
   <th><input type="checkbox" name="all" class="all" onclick="allChk(this.checked);" ></th><th>번호</th><th>카테고리</th><th>제목</th><th>조회수</th><th>작성자</th><th>등록일</th>
</tr>
  </thead>
    <tbody>
<%
/////////// 댓글수 불러오기//////////// 시작
CommentsDao comDao = CommentsDao.getInstance();
int count;

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
      <tr>
         <th><input type="checkbox" name="chk" class="chk"  value="<%=bbs.getSeq() %>"></th>
         <th><%=i+1 %></th>
         <td><%=bbs.getCago() %></td>
         <td>
   
					<% if(comDao.commentsCount(bbs.getSeq()) == 0 ){ %>
               		<a href="<%=request.getContextPath() %>/index.jsp?toss=z_bbs/bbsdetail&seq=<%=bbs.getSeq() %>">
                  <%=bbs.getTitle() %>
               </a> 
               <%}else{ %>  
               <a href = "<%=request.getContextPath() %>/index.jsp?toss=z_bbs/bbsdetail&seq=<%=bbs.getSeq()%>"><%=bbs.getTitle() %> [<%=count = comDao.commentsCount(bbs.getSeq()) %>]</a>									
					<% }     
            
               
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
         <td><%=bbs.getReadcount() %></td>        
         <td><%=dto.getNickname() %></td>
         <td><%=bbs.getWdate().substring(0,11) %></td>
         
      </tr>
   <%
   }
   }
//}

%>
 </tbody>
</table>

   
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
<input type="text" id="search" placeholder="검색어를 입력하세요." class="textbox" value="<%=search %>">

<input type="button" value="검색" class="searchbtn1" onclick="searchBtn(1)">  <!-- 검색어 입력시 -->
<input type="button" value="검색" class="searchbtn2" onclick="searchBtn(2)">   <!-- 카테고리 선택시 -->

</div>


<script type="text/javascript">
function searchBtn(n) {
   
   let choice = document.getElementById("choice").value;
   let search = document.getElementById("search").value;
   let cagoselect = document.getElementsByClassName("cagoselect")[0].value;
   <%System.out.println(cagoselect); %>
   if( n == 1) { //키워드로 검색 시
      if(search.trim() == ""){
         alert("검색어 입력이 필요합니다");
         return;
      }else if(choice.trim() == ""){
         alert("검색할 항목을 선택해주세요");
         return;
      }
      location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_mypage/myfirstpage&tap=mylist&nickname=<%=dto.getNickname()%>&choice=" + choice + "&search=" + search;
   
   }else if( n == 2) { //카테고리로 검색 시
      alert(cagoselect.trim());
      if(cagoselect.trim() == ""){
         alert("카테고리를 선택해주세요");
         return;
      }
      location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_mypage/myfirstpage&tap=mylist&nickname=<%=dto.getNickname()%>&choice=" + choice + "&cagoselect=" + cagoselect;
   }

} 

function goPage( pageNum ) {
	alert(pageNum);
   let choice = document.getElementById("choice").value;
   let search = document.getElementById("search").value;

   location.href =  "<%=request.getContextPath() %>/index.jsp?toss=z_mypage/myfirstpage&tap=mylist&nickname=<%=dto.getNickname()%>&choice="  + choice + "&search=" + search + "&pageNumber=" + pageNum;
}

</script>

</body>
</html>