<%@page import="dao.CommentsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
int renumber = Integer.parseInt(request.getParameter("renumber"));
CommentsDao dao = CommentsDao.getInstance();
boolean isS = dao.deleteComments(renumber);
if(isS){    
	out.println("yes");    
}else{
	out.println("no");  	   
}
%>     
