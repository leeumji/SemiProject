<%@page import="dto.CommentsDto"%>
<%@page import="dao.CommentsDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%


int seq = Integer.parseInt(request.getParameter("seq"));

// DB 

CommentsDao dao = CommentsDao.getInstance();
List<CommentsDto> list = dao.getCommentsList(seq);

//json
String json = "[";
for(int i = 0; i<list.size(); i++){

	  json += "{ \"renumber\":" + list.get(i).getRenumber() + ", "
	        +    " \"nickname\":\"" + list.get(i).getNickname() + "\", " 
	        +    " \"wdate\":\"" + list.get(i).getWdate()+ "\","  
	        +    " \"seq\":" + list.get(i).getSeq() + ", ";
	  if(list.get(i).getContent().contains("\n")){
		  json +=    " \"content\":\"" + list.get(i).getContent().replace("\n", "<br>") + "\"";
	  }else{
		  json +=    " \"content\":\"" + list.get(i).getContent() + "\"";
	  }	  
	  
	  if(i == list.size() -1){
	      json += " }"; 
	  }else{
		  json += " },"; 
	  }
}

json += "]";


out.println(json);
%>








