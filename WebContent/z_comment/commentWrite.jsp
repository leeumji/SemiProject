<%@page import="dto.CommentsDto"%>
<%@page import="dao.CommentsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
String nickname = request.getParameter("nickname");
int seq = Integer.parseInt(request.getParameter("seq"));
String content = request.getParameter("content");


CommentsDao dao = CommentsDao.getInstance();
boolean isS = dao.writeComments(new CommentsDto(nickname, seq, content));

if(isS){    
	out.println("yes");    
}else if(isS == false || content.equals("")){
	out.println("no");  	   
}

%>    
