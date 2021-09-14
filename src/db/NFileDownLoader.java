package db;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.NoticeDao;

public class NFileDownLoader extends HttpServlet{
	
	ServletConfig mConfig = null;
	final int BUFFER_SIZE = 8192;
		
	
	@Override //왜 필요한가? 경로를 얻어오기 위함 
	public void init(ServletConfig config) throws ServletException {
		mConfig = config; //업로드한 경로 취득을 위해서 

	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("FileDownLoader doGet 여기까지는 옵니다");
		
		String newfilename = req.getParameter("newfilename");
		int seq = Integer.parseInt(req.getParameter("seq"));
		
		//download 카운트 증가
		NoticeDao dao = NoticeDao.getInstance();
		dao.downcount(seq);	
		
		String filename = dao.getNoticeInfo(seq).getFilename(); //원본 파일 이름을 가져온 것
		BufferedOutputStream out = new BufferedOutputStream(resp.getOutputStream());
		
		//path(경로)
		//tomcat(server)
		String filepath = mConfig.getServletContext().getRealPath("/upload");
		//폴더
		//String filepath = "d:\\tmp";
		
		filepath += "\\" + newfilename;
		System.out.println("파일다운로더에서의 파일경로, 다운 받았을때 어디서 가져오는지 : " + filepath);
		
		File f = new File(filepath);
		
		//크롬 브라우저의 설정(한글명 파일 깨짐)
		String fileNameOrg = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
		
		if(f.exists()&&f.canRead()) {
			resp.setHeader("Content-Disposition", "attachment; filename=\"" + fileNameOrg + "\";");
			resp.setHeader("Content-Transfer-Encoding", "binary;");
			resp.setHeader("Content-Length", "" + f.length());
			resp.setHeader("Pragma", "no-cache;");
			resp.setHeader("Expires", "-1;");
		
		
			//파일 생성, 기입 가능함 
			
			BufferedInputStream fileInput = new BufferedInputStream(new FileInputStream(f));
			byte buffer[] = new byte [BUFFER_SIZE];
			int read = 0;
			
			while((read=fileInput.read(buffer))!=-1) {
				out.write(buffer, 0, read); //실제로 다운로드되는 부분은 이 곳				
			}	
			
			fileInput.close();
			out.flush(); //요게 뭐징
		}
	}
}