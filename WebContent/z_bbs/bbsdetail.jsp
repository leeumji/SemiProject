<%@page import="dto.CommentsDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.CommentsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="dto.MemberDto"%>
<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>

<%
MemberDto mem = (MemberDto)session.getAttribute("login");
if(mem == null || mem.getNickname()== null || mem.getNickname().equals("")){
%>  
   <script>
   alert("로그인 해 주십시오");
   location.href = "<%=request.getContextPath()%>/z_login/login.jsp";
   </script>   
<%
}
%> 
<%
String content = request.getParameter("content");
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq);

BbsDao dao = BbsDao.getInstance();
dao.readcount(seq);

BbsDto bbs=dao.getBbs(seq);
request.setAttribute("_bbs", bbs);
BbsDto dto = dao.getBbs(seq);
System.out.println(dto.toString()); 
%> 
<% 
CommentsDao comDao = CommentsDao.getInstance();
List<CommentsDto> list = comDao.getCommentsList(seq);
CommentsDto comDto = new CommentsDto();

String date = dto.getWdate().substring(0, 16);
%>
<%// 글 작성자 닉네임 받아오기
String writer = dao.getWriter(seq);
%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
  
  table {
    width: 100%;

  }
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
</head>
<body>

<div class="container">
<table ><tr align="right"><td>
	<button type="button" class="btn btn-outline-secondary" style='width:70px; font-size: 13px; padding: 3px 3px 3px 3px;' onclick=location.href="<%=request.getContextPath() %>/index.jsp?toss=z_bbs/bbslist">글목록</button>
<% if(mem != null && (mem.getAuth()==1 || ( mem.getNickname().equals(dto.getNickname() )))){ %>
	<button type="button" class="btn btn-secondary" style='width:70px; font-size: 13px; padding: 3px 3px 3px 3px;' onclick="updateBbs(<%=dto.getSeq() %>)">수정</button>
	<button type="button" class="btn btn-outline-secondary" style='width:70px; font-size: 13px; padding: 3px 3px 3px 3px;' onclick="deleteBbs(<%=dto.getSeq() %>)" >삭제</button>
<%
}
%>
</td></tr></table><br>
<table border="1" style="text-align: center" class = "table table-striped">
   <col style="width: 1000px">


<tr>
   <td align="left">
   <p style="font-size: 12px; color: #6B8E23;">[ <%=dto.getCago() %> ]</p>
   <p style="font-size: 25px"><%=dto.getTitle() %></p>
   <p style="font-size: 15px; color: #808080;"></p><%=dto.getNickname() %><br>
   <p style="font-size: 12px; color: #808080;"><%=date %>　　조회&nbsp; <%=dto.getReadcount()%></p>
   </td>
</tr>
<% if(dto.getNewfilename() != null ) { %>
<tr height="500px">
   <td  align="left"  style="padding: 10px 10px 10px 10px;"><img src="upload\<%=bbs.getNewfilename() %>" width="50%"><br><br><%=dto.getContent() %></td>
</tr>
<% }else{ %>

<tr height="500px">
   <td  align="left"  style="padding: 10px 10px 10px 10px;"><%=dto.getContent() %></td>
</tr>
<%} %>

</table>



<br><br>

<div class="input-group" role="group">
    <textarea class="form-control" rows="3" id="reContent" placeholder="댓글을 입력하세요." style="width: 100%; border-color: #A9A9A9;" ></textarea> </div><br>
	<div class="container">
<%try{ 
    if(mem.getNickname() != null){ %>
    <table><tr align="right"><td>
    	<button type="button" class="btn btn-outline-secondary" id="commentWrite" style='width:70px; font-size: 13px; padding: 3px 3px 3px 3px;'>댓글쓰기</button>
    </td></tr></table>	
    <% } %>
	</div>
</div>

<!--  댓글 -->
<hr>
<div align="center">
<table id="comm_table" >
<colgroup >
	<col style="width: 50px">
    <col style="width: 200px">
    <col style="width: 200px">
    <col style="width: 200px">
    <col style="width: 200px">
</colgroup>    
</table>
</div>
<br>

          
             
<script type="text/javascript">
function updateBbs( seq ) {   
   location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_bbs/bbsupdate&seq=<%=seq %>" 
}
function deleteBbs( seq ) {
   location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_bbs/bbsdelete&seq=<%=seq %>" 
}
</script>
 
<script>
$(document).ready(function() {   
   getCommentsList();
});   

// 댓글작성
$("#commentWrite").click(function() {
    writeComments();
});
// 댓글삭제       
$("#comDelete").click(function() {
    comDelete(renumber);
});
// 댓글수정
$("#comUpdateComplete").click(function() {
    comUpdate(renumber);
});
// 수정취소
$("#comUpdateBack").click(function() {
	comUpdateBack(renumber);
});

// 댓글불러오기
function getCommentsList() {
    $.ajax({
          url:"<%=request.getContextPath()%>/z_comment/commentAf.jsp",
          data: { seq:<%=seq%> },
          type:"get",
          success:function(str){
        	  data = "";
        	  if(str.trim() == "[]"){
              	data += "<tr>";             
              	data += "<th colspan='4' style='font-size: 15px;'>";
              	data += "<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;첫 댓글을 작성해보아요!</th>";
              	data += "</tr>";
              	$("#comm_table").html(""); // 초기화
                $("#comm_table").append(data);
              }else{
	              let json = JSON.parse(str);
	              data = "";
	              $("#comm_table").html(""); // 초기화
	             
	              $.each(json, function(index, item) {
	            	  
	            	let wdate = item.wdate.substr(0, 16);
	            	data += "<tr><th colspan='4' style='font-size: 12px;'>";
	            	data +=  item.nickname + "</th>";
	                data += "<td style='font-size: 11px;' align='right'>" + '🕗 ' + wdate + "</td></tr>";
	                data += "<tr><td></td>"; 
	                data += "<td style='font-size: 16px;' colspan='3'>" + item.content + "</td></tr>";
	            	if(<%=mem.getAuth() %> == 1 || item.nickname == "<%=mem.getNickname()%>"){
		                data += "<tr><td colspan='4'></td>";
		                data += "<td  align='right'>";
		                data += "<input type='button' id='comUpdate"+item.renumber+"' onclick='comUpdate("+item.renumber+")' style='width:50px; font-size: 11px; padding: 3px 1px 3px 1px;' class='btn btn-secondary' value='수정'>&nbsp;";
		                data += "<input type='button' id='comDelete"+item.renumber+"' onclick='comDelete("+item.renumber+")' style='width:50px; font-size: 11px; padding: 3px 1px 3px 1px;' class='btn btn-outline-secondary' value='삭제'></td>";
	                }
	            	else if("<%=writer%>" == "<%=mem.getNickname()%>"){
	                	data += "<tr><td colspan='4'></td>";
		                data += "<td  align='right'>";
		                data += "<input type='button' id='comDelete"+item.renumber+"' onclick='comDelete("+item.renumber+")' style='width:50px; font-size: 11px; padding: 3px 1px 3px 1px;' class='btn btn-outline-secondary' value='삭제'></td>";
	                }
	            	else if(item.nickname != "<%=mem.getNickname()%>"){
		                data += "<tr><td colspan='5'></td>";
	                }
	            	data += "</tr><tr><td colspan='5'><hr></td></tr>";
	            	data += "<tr id='comm"+item.renumber+"'></tr>";
	             });   
	             $("#comm_table").append(data);    
              }
          },
          error : function() {}
    });   
}

// 수정할 댓글 불러오기
function comUpdate(renumber) {
   $.ajax({
        url  : "<%=request.getContextPath()%>/z_comment/commentSelect.jsp",
        type : "post",
        data : {renumber: renumber },
        success : function(data) {
            let json = JSON.parse(data);
            let datas = "";
            $.each(json, function(index, item) {
        	datas += $('#comUpdate' + item.renumber).hide();
           	datas += $('#comDelete' + item.renumber).hide();
            datas += "<td colspan='4'><textarea class='form-control' id='content' rows='3'  style='width: 100%;' >"+item.content.replaceAll('<br>', '\n')+"</textarea>";
            datas += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
            datas += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
            datas += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
            datas += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
            datas += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
            datas += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
            datas += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		    datas += "<input type='button' id='comUpdateComplete' onclick='comUpdateComplete("+item.renumber+")' style='width:50px; font-size: 11px; padding: 3px 1px 3px 1px;' class='btn btn-secondary' value='완료'>&nbsp;";
            datas += "<input type='button' id='comUpdateBack' onclick='comUpdateBack()' style='width:50px; font-size: 11px; padding: 3px 1px 3px 1px;' class='btn btn-outline-secondary' value='취소'><hr></td>";
             
            $("#comm" + item.renumber).append(datas); 
          });    
        },
        error : function() {
           alert('comDelete error');
        }
    }); 
}

// 댓글 수정 닫기 
function comUpdateBack() { 
	getCommentsList();
}
   
// 댓글 수정 완료
function comUpdateComplete(renumber) {
   $.ajax({
       url:"<%=request.getContextPath()%>/z_comment/commentUp.jsp",
       data: { renumber: renumber, content: $("#content").val() },
       type:"get",
         success : function(data) {
            console.log(data.trim()); 
            if (data.trim() == "yes") {
               alert("댓글이 수정되었습니다.");
            } else {
                alert("댓글수정이 실패되었습니다..");
            }
            getCommentsList();
        },
        error : function() {
            alert('comUpdateComplete error');
        }
   });
}

// 댓글 삭제
function comDelete(renumber) {
	// 삭제 선택
    if(confirm("삭제하시겠습니까 ?") == true){
   	$.ajax({
        url  : "<%=request.getContextPath()%>/z_comment/commentDel.jsp", // 이 파일에
        type : "post", 
        data : {renumber: renumber },
        success : function(data) {
           console.log(data.trim()); 
           if (data.trim() == "yes") {
              alert("댓글이 삭제되었습니다.");
           } else {
              alert("댓글삭제가 실패되었습니다..");
           }
           getCommentsList();
        },
        error : function() {
           alert('comDelete error');
        }
     });
    }else{
        return ;
    }
}


// 댓글 쓰기
function writeComments() {
    $.ajax({
          url:"<%=request.getContextPath()%>/z_comment/commentWrite.jsp",
          type:"get",
          data : {nickname:"<%=mem.getNickname()%>", seq:<%=seq%> , content:$("#reContent").val()},
          success:function(str){ 
             if (str.trim() == "yes") {
                } else {
                   alert("댓글내용을 작성해 주세요.");
                }
              getCommentsList();  
              document.getElementById("reContent").value='';
          },
          error : function() {
              alert('writeComments error');
          }
     });   
} 
</script> 
<%}catch(NullPointerException ne){ %>
   <script>
   alert("로그인 해 주십시오");
   location.href = "<%=request.getContextPath()%>/z_login/login.jsp";
   </script>   

<%} %>  
</body>
</html>