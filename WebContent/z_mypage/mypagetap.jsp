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
#mypageimg {
	height: 70px;
	width: 200px;
	padding-right: 40px;
	
}
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

<img id="mypageimg" src="image/mypage1 .png">
<ul class="accordion-menu">
  <li>
    <div class="dropdownlink"><i class="fa fa-road" aria-hidden="true"></i>내정보
      <i class="fa fa-chevron-down" aria-hidden="true"></i>
    </div>
    <ul class="submenuItems">
      <li><a href="<%=request.getContextPath() %>/index.jsp?toss=z_mypage/myfirstpage&tap=mypage">내정보 확인</a></li>
   
    </ul>
  </li>
  <li>
    <div class="dropdownlink"><i class="fa fa-paper-plane" aria-hidden="true"></i> 내 게시글
      <i class="fa fa-chevron-down" aria-hidden="true"></i>
    </div>
    <ul class="submenuItems">
      <li><a href="<%=request.getContextPath() %>/index.jsp?toss=z_mypage/myfirstpage&tap=mylist&nickname=<%=dto.getNickname()%>">게시글 확인</a></li>
      <li><a href="<%=request.getContextPath() %>/index.jsp?toss=z_mypage/myfirstpage&tap=mycommentlist&nickname=<%=dto.getNickname()%>">내 댓글확인하기 </a></li>
     
    </ul>
  </li>
  <li>
    <div class="dropdownlink"><i class="fa fa-quote-left" aria-hidden="true"></i> 계정삭제
      <i class="fa fa-chevron-down" aria-hidden="true"></i>
    </div>
    <ul class="submenuItems">
      <li><a href="<%=request.getContextPath() %>/index.jsp?toss=z_mypage/myfirstpage&tap=deleteMyaccount">탈퇴하기</a></li>
    
    </ul>
  </li>
 
</ul>
</body>
</html>