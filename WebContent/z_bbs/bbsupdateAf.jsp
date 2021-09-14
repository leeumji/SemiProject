<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="dto.BbsDto"%>
<%@page import="java.io.IOException"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("utf-8");
%>    
<%!//실제 업로드가 이뤄지는 함수
public String processUploadFile(FileItem fileItem, String newFilename, String dir) throws IOException{   
   
   String f = fileItem.getName();
   long sizeInBytes = fileItem.getSize();
   
   String fileName = "";
   String fpost = "";
   
   //업로드한 파일이 정상일 경우에
   if(sizeInBytes>0){ 
      int idx = f.lastIndexOf("\\");
   if(idx == -1){
      idx = f.lastIndexOf("/");
   }
   fileName = f.substring(idx+1); 
   try{
   File uploadFile = new File(dir, newFilename);
   fileItem.write(uploadFile);//실제로 업로드하는 부분
   }catch(Exception e){
      e.printStackTrace();
      };
   }
   return fileName;
   
}
%>
    
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>bbsupdateAf.jsp</title>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<div class="container">
<%
String fupload = application.getRealPath("/upload");
  
System.out.println("파일 업로드:" + fupload);
String yourTempDir = fupload;

int yourMaxRequestSize = 100*1024*1024; 
int yourMaxMemorySize = 100*1024;


String nickname = "";
String title = "";
String content = "";
String cago ="";
String seq = "";
String oldfile = "";

String filename="";
String newfilename="";

boolean isMultipart = ServletFileUpload.isMultipartContent(request);
if(isMultipart){
   ///////////////////////////file
   
   //FileItem 오브젝트를 생성하는 클래스 
   
   DiskFileItemFactory factory = new DiskFileItemFactory();
   
   factory.setSizeThreshold(yourMaxMemorySize);
   factory.setRepository(new File(yourTempDir));
   
   ServletFileUpload upload = new ServletFileUpload(factory);
   upload.setSizeMax(yourMaxRequestSize);
   
   List<FileItem> items = upload.parseRequest(request);
   Iterator<FileItem> it = items.iterator();
   
   while(it.hasNext()){
      FileItem item = it.next();
      if(item.isFormField()){ //nickname, title, content, seq
         if(item.getFieldName().equals("nickname")){
            nickname = item.getString("utf-8");
         }else if(item.getFieldName().equals("title")){
            title = item.getString("utf-8");
         }else if(item.getFieldName().equals("content")){
            content = item.getString("utf-8").replace("\n", "<br>");
         }else if(item.getFieldName().equals("cago")){
            cago = item.getString("utf-8");
         }else if(item.getFieldName().equals("seq")){
            seq = item.getString("utf-8");
            System.out.println("seq:" + seq);
         }else if(item.getFieldName().equals("oldfile")){
            filename = item.getString("utf-8");
         }else if(item.getFieldName().equals("deletefile")){
        	 filename = "";
         }
      
      }else{//file
         try{
            if(item.getFieldName().equals("fileload")){
               //확장자명
               String fileName = item.getName(); 
               if(fileName != null){
                  int lastInNum = fileName.lastIndexOf(".");
                  String exName = fileName.substring(lastInNum); 
                  
                  //새로운 파일명 세팅
                  newfilename = (new Date().getTime()) + "";
                  System.out.println(newfilename);
                  newfilename += exName;
                  System.out.println(newfilename);
                  filename = processUploadFile(item, newfilename, fupload);
               }
            }
         }catch(StringIndexOutOfBoundsException sobe){
               sobe.printStackTrace();
         }
      }
   }         
}else{
   System.out.println("Multipart가 아님");         
}

%>
<%
BbsDao dao = BbsDao.getInstance();
int iseq =Integer.parseInt(seq);
BbsDto bbs=dao.getBbs(iseq);
boolean result =dao.updateBbs(title, content, cago, newfilename, filename, iseq);
if(result == true){
	%>
	<div class="alert alert-light">
	<script type="text/javascript">
	alert("수정이 완료되었습니다.");
	location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_bbs/bbslist";
	</script>
	</div>
	<%
}else{	
	%>
	<div class="alert alert-light">
	<script type="text/javascript">
	alert("글 수정 실패");
	location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_bbs/bbslist";
	</script>
	</div>
	<%
}	
%>
</div>
</body>
</html>





