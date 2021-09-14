<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="javax.xml.crypto.Data"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="java.io.File"%>
<%@page import="java.io.IOException"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="dto.NoticeDto"%>
<%@page import="dao.NoticeDao"%>
<%@page import="dto.QnaDto"%>
<%@page import="dao.QnaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<% 
request.setCharacterEncoding("utf-8");
/*
String nickname = request.getParameter("nickname");
System.out.println("nickname: " + nickname);
String title = request.getParameter("title");
System.out.println("title: " + title);
String content = request.getParameter("content");
System.out.println("content: " + content);
*/
%>

<%!//실제 업로드가 이뤄지는 함수
public String processUploadFile(FileItem fileItem, String newFilename, String dir) throws IOException{	
	
	String f = fileItem.getName();
	long sizeInBytes = fileItem.getSize();
	
	String fileName = "";
	String fpost = "";
	
	//업로드한 파일이 정상일 경우에
	if(sizeInBytes>0){ //      d:\\tmp\\abc.txt     d:/tmp/abc.txt
		int idx = f.lastIndexOf("\\");
	if(idx == -1){
		idx = f.lastIndexOf("/");
	}
	fileName = f.substring(idx+1); // 슬러쉬 다음의 본연의 파일 이름만 따온다 
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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/all.css">
<title>자료 업로드</title>
</head>
<body>

<%

/*

한글 파일의 경우 파일이 깨지는 경우가 있음 , 파일명 손실
	ex. 내파일.txt -> 235344.txt
	실제 파일명 : 내파일.txt
	변환 파일명 : 235344.txt //다운로드, 업로드 자체는 이 파일이 됨
	두 가지를 db에 다 올려줘야함
*/

//tomcat에 배포(주의. 서버 껐다가 켰다가 하면서 파일 날라갈 수 있음)
String fupload = application.getRealPath("/upload");
	//지정 폴더에 저장함
//String fupload = "d:\\tmp"; //우리가 tmp폴더 가서 직접 지우지 않는한 지워지지 않음 

System.out.println("파일 업로드:" + fupload);
String yourTempDir = fupload;

int yourMaxRequestSize = 100*1024*1024; //1메가바이트 1M
int yourMaxMemorySize = 100*1024;//1키로바이트 1K

//form field에 데이터(String) 

String nickname = "";
String title = "";
String content = "";

//file data
String filename = "";
String newfilename = "";

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
		if(item.isFormField()){ //nickname, title, content
			if(item.getFieldName().equals("nickname")){
				nickname = item.getString("utf-8");
			}else if(item.getFieldName().equals("title")){
				title = item.getString("utf-8");
			}else if(item.getFieldName().equals("content")){
				content = item.getString("utf-8");
			}
		}else{//file
			try{
				if(item.getFieldName().equals("fileload")){
					
					//확장자명
					String fileName = item.getName(); //abc.txt
					int lastInNum = fileName.lastIndexOf(".");
					String exName = fileName.substring(lastInNum); 
					
					//새로운 파일명 세팅
					newfilename = (new Date().getTime()) + ""; //ex. 523543243 알아볼 수 없는 무작위 숫자 시간이 계속 흐르기때문에 충돌 가능성은 사실상 제로
					System.out.println(newfilename);
					newfilename += exName;
					System.out.println(newfilename);
					filename = processUploadFile(item, newfilename, fupload);
				
				}		
			}catch(StringIndexOutOfBoundsException sobe){
					//newfilename = "";
					//filename = "";
					sobe.printStackTrace();
			}
		}
	}			
}else{
	System.out.println("Multipart가 아님");			
}

%>

<%
System.out.println("newfilename-->" + newfilename);

NoticeDao dao = NoticeDao.getInstance();
boolean result = dao.writeNotice(new NoticeDto(nickname, title, content, filename, newfilename));

if(result==true){
%>
	<script type="text/javascript">
		alert("작성이 완료되었습니다.");
		location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_notice/noticelist";
		</script>
	<%
	}else{
	%>
		<script type="text/javascript">
		alert("다시 확인해주세요.");
		location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_notice/writenotice";
		</script>
	<%
	}
	%>

</body>
</html>