<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = request.getParameter("id");
MemberDao dao = MemberDao.getInstance();
boolean flag = dao.getId(id);
if(flag == true){
	out.println("NO");	// 사용할 수 없음 (NO == data)
}else{
	out.println("YES");	// 사용할 수 있음
}
%> 