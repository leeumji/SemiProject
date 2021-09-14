<%@page import="java.util.List"%>
<%@page import="dto.CommentsDto"%>
<%@page import="dao.CommentsDao"%>
<%@page import="dto.MemberDto"%>
<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
MemberDto mem = (MemberDto)session.getAttribute("login");
if(mem == null){
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
%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/all.css">
<title>Insert title here</title>
</head>
<body>
<h4>게시글 상세보기</h4>

<div align="center">

<table border="1">
<col width="200"><col width="500"> 
<tr>
	<th>카테고리</th>
	<td><%=dto.getCago() %>
	</td>
</tr>
<tr>
	<th>닉네임</th>
	<td><%=dto.getNickname() %></td>
</tr>
<tr>
	<th>조회수</th>
	<td><%=dto.getReadcount()%></td>
</tr>
<tr>
	<th>제목</th>
	<td><%=dto.getTitle() %></td>
</tr>
<tr>
	<th>내용</th>
	<td><textarea rows="10" cols="60" readonly="readonly"><%=dto.getContent() %></textarea></td>
</tr>
<tr>
	<th>작성일</th>
	<td><%=dto.getWdate() %></td>
</tr>

</table>
</div>
<br>

<div align="right" style="padding-right: 50px; padding-bottom: 10px">
<button type="button" onclick="location.href='<%=request.getContextPath() %>/index.jsp?toss=z_admin/adminpage&tap=adminbbslist'">글목록</button>


<button type="button" onclick="location.href='<%=request.getContextPath() %>/index.jsp?toss=z_admin/adminpage&tap=adminbbsdelete_each&seq=<%=dto.getSeq() %>'">삭제</button>
</div>






<div class="input-group" role="group" aria-label="..." style="margin-top: 10px; width: 100%;">
    <textarea class="form-control" rows="3" id="reContent" placeholder="댓글을 입력하세요." style="width: 100%; border-color: orange;" ></textarea> </div><br>
    <div class="btn-group btn-group-sm" role="group" aria-label="..." align="right" >
        <% if(mem.getNickname() != null){ %>
            <button type="button" class="btn btn-outline-secondary" id="commentWrite" style="padding: 5px"  >댓글쓰기</button>
        <% } %>
</div>
                                                       




<!--  댓글 -->
<hr>


<table id="comm_table">
<col width="300px"><col width="800px"><col width="200px">
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
	 $('#reContent').val(' ');
});

// 댓글삭제	    
$("#comDelete").click(function() {
	 comDelete(renumber);
});
// 댓글수정
$("#comUpdateComplete").click(function() {
	 comUpdate(renumber);
});


// 댓글불러오기
function getCommentsList() {
	 $.ajax({
	    	url:"<%=request.getContextPath()%>/z_comment/commentAf.jsp",
	    	data: { seq:<%=seq%> },
	    	type:"get",
	    	success:function(str){
	    		let json = JSON.parse(str);
	    	
		    	let data = "";
	    		$.each(json, function(index, item) {
	    			if(item.nickname == "<%=mem.getNickname()%>"){
					data += "<tr>";    			
	    			data += "<td style='font-size: 11px;'>" + item.nickname + "</td>";
	    			data += "<td style='font-size: 11px;'>" + item.wdate + "</td>";
	    			data += "<td align='right'>";
	    			
	    			data += "<input type='button' id='comUpdate' onclick='comUpdate("+item.renumber+")' style='width:70px; font-size: 11px; padding: 3px 1px 3px 1px;' class='btn btn-secondary' value='수정'>&nbsp;";
	    			data += "<input type='button' id='comDelete' onclick='comDelete("+item.renumber+")' style='width:70px; font-size: 11px; padding: 3px 1px 3px 1px;' class='btn btn-outline-secondary' value='삭제'>&nbsp;";
	    			data += "<input type='button' id='reComment' onclick='reComment("+item.renumber+")' style='width:70px; font-size: 11px; padding: 3px 1px 3px 1px;' class='btn btn-secondary' value='댓글쓰기'>&nbsp; ";
	    			data += "<input type='button' id='reCommentView' onclick='reCommentView("+item.renumber+")' style='width:70px; font-size: 11px; padding: 3px 1px 3px 1px;' class='btn btn-outline-secondary' value='댓글보기'></td>";
	    			data += "</tr>";
	    			data += "<tr>";
	    			data += "<td></td>";
	    			data += "<td style='font-size: 15px;' colspan='2'>" + item.content + "</td>";
	    			data += "</tr><tr id='comm"+item.renumber+"' colspan='3'></tr>";
	    		
	    			} else if(item.nickname != "<%=mem.getNickname()%>"){
	    			data += "<tr>";    			
	    			data += "<td style='font-size: 11px;'>" + item.nickname + "</td>";
	    			data += "<td style='font-size: 11px;'>" + item.wdate + "</td>";
	    			data += "<td align='right'>";
	    			data += "<input type='button' id='reComment' onclick='reComment("+item.renumber+")' style='width:70px; font-size: 11px; padding: 3px 1px 3px 1px' class='btn btn-secondary' value='댓글쓰기'>&nbsp;";
	    			data += "<input type='button' id='reCommentView' onclick='reCommentView("+item.renumber+")' style='width:70px; font-size: 11px; padding: 3px 1px 3px 1px;' class='btn btn-outline-secondary' value='댓글보기'></td>";
	    			data += "</tr>";
	    			data += "<tr>";
	    			data += "<td></td>";
	    			data += "<td style='font-size: 15px;' colspan='2'>" + item.content + "</td>";
	    			data += "</tr><tr id='comm"+item.renumber+"' colspan='3'></tr>";
	    			}
	    			
	    			
	    			$("#comm_table").html(""); // 초기화
	    			$("#comm_table").append(data);
	    		});	    		   		
	    	},
	    	error : function() {
	    		 alert(' getCommentsList error');
	    	}
	});	
}
	// 수정할 댓글 불러오기
function comUpdate(renumber) {
	$.ajax({
        url  : "<%=request.getContextPath()%>/z_comment/commentSelect.jsp",
        type : "post", // post방식으로
        data : {renumber: renumber },
        success : function(data) {
         // alert('success');
        //  alert(data);	
         	let json = JSON.parse(data);
	    	
		   	let datas = "";
	    	$.each(json, function(index, item) {
	    		
	    			
	    		datas += "<td colspan='2'><textarea class='form-control' id='content' rows='3'  style='width: 100%;' >"+item.content+"</textarea>";
	    		datas += "<input type='button' id='comUpdateComplete' onclick='comUpdateComplete("+item.renumber+")' style='width:70px; font-size: 11px;' class='btn btn-secondary' value='수정'></td>"
	    
	    		
	    		// $("#comm_table").append(datas);	
	    		
	    		
	    	//	$('#comm_table > tbody > "'#comm" + item.renumber +"'"').after(datas);
	    		$("#comm" + item.renumber).append(datas);
	    
	    	});	 
        },
        error : function() {
           alert('comDelete error');
        }
    }); 
}
 	
	// 댓글 수정 완료
function comUpdateComplete(renumber) {
	$.ajax({
    	url:"<%=request.getContextPath()%>/z_comment/commentUp.jsp",
    	data: { renumber: renumber, content: $("#content").val() },
    	type:"get",
	   	success : function(data) {
	         console.log(data.trim()); // data == 해당 jsp의 html부분의 전체를 가져온다.(scriptlet 제외)
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
	$.ajax({
        url  : "<%=request.getContextPath()%>/z_comment/commentDel.jsp", // 이 파일에
        type : "post", // post방식으로
        data : {renumber: renumber },
        success : function(data) {
           console.log(data.trim()); // data == 해당 jsp의 html부분의 전체를 가져온다.(scriptlet 제외)
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
}
</body>
</html>