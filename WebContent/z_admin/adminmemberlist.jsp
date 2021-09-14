<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
<%@page import="dto.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    


<%
String choice = request.getParameter("choice");
String search = request.getParameter("search");
if(choice == null){
   choice = "--선택--";
}
if(search == null){
   search = "";
}
%>

<%
MemberDao dao = MemberDao.getInstance();



//현재 페이지 번호 불러오기
String sPageNumber = request.getParameter("pageNumber");
int pageNumber = 0;
if(sPageNumber!=null&&!sPageNumber.equals("")){
   pageNumber = Integer.parseInt(sPageNumber);
}
System.out.println("pageNumber : " + pageNumber);

List<MemberDto> list = dao.getMemberPagingList(choice, search, pageNumber);

//글의 총 수 불러오기
int len = dao.getAllMember(choice, search);
System.out.println("총 글의 수 : " + len);

//페이지수 넣어주기
int MemberPage = len/10; 
if((len % 10)>0){
   MemberPage = MemberPage+1;
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

<title>adminmemberlist.jsp</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script type="text/javascript">

$(document).ready(function() { //검색어 부분 유지하기
   let search = "<%=search %>";     //글로벌 변수
   if(search = "") return;

   let obj = document.getElementById("choice"); //select 부분
   obj.value = "<%=choice %>";
   obj.setAttribute("selected", "selected");
});

</script>


</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
    


<div class="card-header" style="background-color: white; padding-bottom: 0;">
   <img alt="" src="./image/admin-002.png" >
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

<%-- <form action="<%=request.getContextPath() %>/index.jsp?toss=z_admin/adminpage&tap=multiResign" method="post" name="frm" > --%>
<div align="right" style="padding-right: 10px; padding-bottom: 0px">
<input type="button" id="button_resign" value="탈퇴" onclick="resign()">
</div>



<table class="table table-hover">
<col width="30"><col width="40"><col width="90"><col width="100"><col width="90"><col width="80"><col width="50"><col width="110"><col width="70">
<tr align="center" style = "background-color:hsl(36, 87%, 64%) !important">
   <th><input type="checkbox" class="checkall"></th>
   <th>번호</th><th>아이디</th><th>비밀번호</th><th>닉네임</th><th>생일</th><th>성별</th><th>Email</th><th>회원분류</th>
</tr>

   <%
   if(list == null || list.size() == 0){
      %>
         <tr align="center">
            <th><input type="checkbox" name="check_each" class="checkeach"></th>
            <th colspan="8">가입한 회원이 존재하지 않습니다.</th>
         </tr>
      <%
   }else{
      for(int i = 0;i < list.size(); i++){
         MemberDto member = list.get(i);
         
         if(member.getId().contains("강퇴")) {
         %>
         <tr>
            <td colspan="3" align="right"><%=member.getId().substring(0, member.getId().indexOf("[")) %></td>
            <td align="center" colspan="6">관리자에 의해 <font color="red">탈퇴</font> 처리된 회원입니다</td>
         </tr>
         <%   
         }else {
            
         %>   
         <tr>
            <th><input type="checkbox" name="check_each" class="checkeach" value="<%=list.get(i).getId() %>"></th>
            <td><%=i + 1 %></td>
            <td><%=member.getId() %></td>
            <td><%=member.getPwd() %></td>
            <td><%=member.getNickname() %></td>
            <td><%=member.getBirth() %></td>
            <td><%=member.getGender() %></td>
            <td><%=member.getEmail() %></td>
            <td>
               <%if(member.getAuth() == 3) {
               %>
                  일반회원
               <%    
               }
               %>
            </td>
         </tr>
   <%
         }
      }
   }
   
   %>   
</table>
<br>

<div align="center">
<%
for(int i = 0;i < MemberPage; i++){  
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
</div>
<br>

<div align="center">
<select id="choice">
   <option>--선택--</option>
   <option value="id">아이디</option>
   <option value="pwd">패스워드</option>
   <option value="nickname">닉네임</option>
   <option value="birth">생일</option>
   <option value="gender">성별</option>
   <option value="email">이메일</option>
</select>

<input type="text" id="search" placeholder="검색어를 입력해주세요." value="<%=search %>">

<input type="button" value="검색" onclick="searchBtn()">

</div>

<script type="text/javascript">
//0625 은지수정
//체크박스 설정 부분
$(document).ready(function() {
   $(".checkall").click(function() {
         //alert("확인용");
         $(".checkeach").prop("checked", this.checked);
   });
});
   
//셀렉트 검색 부분
function searchBtn() {
   let choice = document.getElementById("choice").value;
   let search = document.getElementById("search").value;
   
   /* alert(choice);
   alert(search); */
   if(search.trim() == "") {
      alert("검색어를 입력해주세요.");
      return;
   }else if(choice.trim() == "--선택--") {
      alert("검색항목을 선택해주세요");
      return;
   }
   
   location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_admin/adminpage&tap=adminmemberlist&choice=" + choice + "&search=" + search;
}

function goPage( pageNum ) {
   let choice = document.getElementById("choice").value;
   let search = document.getElementById("search").value;

   location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_admin/adminpage&tap=adminbbslist&choice=" + choice + "&search=" + search + "&pageNumber=" + pageNum;
}

//탈퇴시키는 부분
function resign() {
   
//   alert('resign');

   let pstr = '';
   
   let arrcheck = document.getElementsByClassName('checkeach')
//   alert(arrcheck[0].checked);
   for(i = 0;i < arrcheck.length; i++){
      if(arrcheck[i].checked == true){
      //   alert(arrcheck[i].value);
         pstr += "&id=" + arrcheck[i].value;
      }
   }
   
    Swal.fire({
        title: '탈퇴를 진행하시겠습니까?',
        text: "탈퇴시키면 다시 복구할 수 없습니다.",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: '탈퇴',
        cancelButtonText: '취소'
      }).then((result) => {
        if (result.value) {

            location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_admin/adminpage&tap=multiResign" + pstr;
        }
      })
} 

</script>

</body>
</html>