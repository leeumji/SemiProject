
<%@page import="dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String content = request.getParameter("content");
   if(content == null){
      content = "home";
   }
   
   BbsDao dao = BbsDao.getInstance();
   List<BbsDto> list = dao.getMainList();
   
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1"> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> 
<link rel="stylesheet" href="./css/style.css">
<link rel="stylesheet" href="./css/main.css">

<link rel="canonical" href="">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>




<title>메인</title>

</head>
<body>

<!-- 슬라이드 -->

<!-- 슬라이드 -->
<div id="mainCarousel" class="carousel slide" data-ride="carousel">
      <!-- Indicators -->
      <ol class="carousel-indicators">
         <li data-target="#mainCarousel" data-slide-to="0" class="active"></li>
         <li data-target="#mainCarousel" data-slide-to="1"></li>
         <li data-target="#mainCarousel" data-slide-to="2"></li>
         <li data-target="#mainCarousel" data-slide-to="3"></li>
      </ol>

      <!-- Wrapper for slides -->
      <div class="carousel-inner" role="listbox">
         <div class="item active">
            <img src="./image/bn01.png"
               alt="...">
            <div class="carousel-caption">
            </div>
         </div>
         <div class="item">
            <img
               src="./image/bn022.png"
               alt="...">
            <div class="carousel-caption">
            </div>
         </div>
         <div class="item">
            <img src="./image/bn123.png"
               alt="...">
            <div class="carousel-caption">
            </div>
         </div>
         <div class="item">
            <img src="./image/rona.png"
               alt="...">
            <div class="carousel-caption">
            </div>
         </div>
      </div>

      <!-- Controls -->
      <a class="left carousel-control" href="#mainCarousel" role="button"
         data-slide="prev"> <span class="glyphicon glyphicon-chevron-left"></span>
         <span class="sr-only">Previous</span>
      </a> <a class="right carousel-control" href="#mainCarousel" role="button"
         data-slide="next"> <span
         class="glyphicon glyphicon-chevron-right"></span> <span
         class="sr-only">Next</span>
      </a>
   </div>

<br><br>

<div align="center">
<img alt="" src="./image/home.png" width="70%" height="auto" ondragstart="return false">
</div>

<br><br><br><br>

<!-- 인기글 -->
<div align="center">
<div class="card" style="width: 70%; height: auto;">
      <div class="card-header"
         style="background-color: white; padding-bottom: 0;">
         <img alt="" src="./image/best.png">
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
      <col width="100px"><col width="150px"><col width="500px"><col width="100px">
         <thead>
            <tr>
               <th>인기순위</th><th>카테고리</th><th>제목</th><th>조회수</th>
            </tr>
         </thead>
         <tbody>
         </div>
         
<%  
      if(list == null || list.size() == 0){ %>

            <tr>
               <th scope="row"colspan="4">작성된 글이 없습니다</th>
            </tr>
       <%}else if(list.size() < 10){ 
    	   for(int i = 0;i < list.size(); i++){
               BbsDto bbs = list.get(i);
       %>     
            <tr>
               <th scope="row">　<%=i + 1 %></th>
               <td><%=bbs.getCago() %></td>
               <td><a href ="<%=request.getContextPath() %>/index.jsp?toss=z_bbs/bbsdetail&seq=<%=bbs.getSeq() %>"><%=bbs.getTitle() %></a></td>
               <td><%=bbs.getReadcount() %></td>
            </tr>
            
            
            
<%       	}
		} else {
         for(int i = 0;i < 10; i++){
               BbsDto bbs = list.get(i);
%>
            <tr>
               <th scope="row">　<%=i + 1 %></th>
               <td><%=bbs.getCago() %></td>
               <td><a href ="<%=request.getContextPath() %>/index.jsp?toss=z_bbs/bbsdetail&seq=<%=bbs.getSeq() %>"><%=bbs.getTitle() %></a></td>
               <td><%=bbs.getReadcount() %></td>
            </tr>
<%         }
        }
%>               
         </tbody>
      </table>
   </div>
</div>
</div>



</body>
</html>