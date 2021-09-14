<%@page import="dao.CommentsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int renumber = Integer.parseInt(request.getParameter("renumber"));
String content = request.getParameter("content");
CommentsDao dao = CommentsDao.getInstance();
boolean isS = dao.updateComments(renumber, content);
if(isS){    
	out.println("yes");    
}else{
	out.println("no");  	   
}
%>  