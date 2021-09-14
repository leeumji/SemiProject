<%@page import="dao.MemberDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
MemberDto mem = (MemberDto)session.getAttribute("login");
String id = mem.getId();
MemberDao dao = MemberDao.getInstance();
MemberDto dto = dao.getMember(id);
System.out.println(dto.getNickname());
System.out.println(dto.getId());
%>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/all.css">
<title>Insert title here</title>
<script type="text/javascript">
$(function() {
     var Accordion = function(el, multiple) {
       this.el = el || {};
       // more then one submenu open?
       this.multiple = multiple || false;
       
       var dropdownlink = this.el.find('.dropdownlink');
       dropdownlink.on('click',
                       { el: this.el, multiple: this.multiple },
                       this.dropdown);
     };
     
     Accordion.prototype.dropdown = function(e) {
       var $el = e.data.el,
           $this = $(this),
           //this is the ul.submenuItems
           $next = $this.next();
       
       $next.slideToggle();
       $this.parent().toggleClass('open');
       
       if(!e.data.multiple) {
         //show only one menu at the same time
         $el.find('.submenuItems').not($next).slideUp().parent().removeClass('open');
       }
     }
     
     var accordion = new Accordion($('.accordion-menu'), false);
   })
</script>
<style type="text/css">

* {
  margin: 0;
  padding: 0;
}

body {
  font-family: 'Montserrat', sans-serif;
 
}

ul {
  list-style: none;
}

a {
  text-decoration: none;
}



.accordion-menu {
  width: 100%;
  max-width: 350px;
  margin: 60px auto 20px;
  background: #fff;
  border-radius: 4px;
}
.accordion-menu li.open .dropdownlink {
  color: orange;
  .fa-chevron-down {
    transform: rotate(180deg);
  }
}
.accordion-menu li:last-child .dropdownlink {
  border-bottom: 0;
}
.dropdownlink {
  cursor: pointer;
  display: block;
  padding: 15px 15px 15px 45px;
  font-size: 18px;
  border-bottom: 1px solid #ccc;
  color: #212121;
  position: relative;
  transition: all 0.4s ease-out;
  i {
    position: absolute;
    top: 17px;
    left: 16px;
  }
  .fa-chevron-down {
    right: 12px;
    left: auto;
  }
}

.submenuItems {
  display: none;
  background: hsl(36, 87%, 64%);
  li {
    border-bottom: 1px solid #B6B6B6;
  }
}

.submenuItems a {
  display: block;
  color: #727272;
  padding: 12px 12px 12px 45px;
  transition: all 0.4s ease-out;
  &:hover {
    background-color: #CDDC39;
    color: #fff;
     opacity: 0.9;
  }
}
</style>
</head>
<body>

<ul class="accordion-menu">
  <li>
    <div class="dropdownlink"></i>회원관리
     </i>
    </div>
    <ul class="submenuItems">
      <li><a href="<%=request.getContextPath() %>/index.jsp?toss=z_admin/adminpage&tap=adminmemberlist">회원 조회</a></li>
   
    </ul>
  </li>
  <li>
    <div class="dropdownlink"></i> 커뮤니티 관리
      </i>
    </div>
    <ul class="submenuItems">
      <li><a href="<%=request.getContextPath() %>/index.jsp?toss=z_admin/adminpage&tap=adminbbslist">게시글 관리</a></li>
      <li><a href="<%=request.getContextPath() %>/index.jsp?toss=z_admin/adminpage&tap=admincommentlist">댓글 관리</a></li>
     
    </ul>
  </li>
  <li>
    <div class="dropdownlink"></i> 관리자 게시판
      </i>
    </div>
    <ul class="submenuItems">
      <li><a href="<%=request.getContextPath() %>/index.jsp?toss=z_qna/qnalist">Q&A 게시판</a></li>
      <li><a href="<%=request.getContextPath() %>/index.jsp?toss=z_notice/noticelist">공지사항 게시판</a></li>
    </ul>
  </li>
 
</ul>
</body>
</html>