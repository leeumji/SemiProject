package dto;

import java.io.Serializable;

public class QnaDto implements Serializable {
	private int seq;
	private String nickname;
	
	private int ref;
	private int step;
	private String title;
	private String content;
	private String wdate;
	private int del;
	private int wait;
	private int readcount;
	private int notice;
	private int delby;
	private String pwd;
	public QnaDto() {
		
	}
	
	public QnaDto(int seq, String nickname, int ref, int step, String title, String content, String wdate, int del, int wait,
			int readcount, int notice, int delby) {
		super();
		this.seq = seq;
		this.nickname = nickname;
		this.ref = ref;
		this.step = step;
		this.title = title;
		this.content = content;
		this.wdate = wdate;
		this.del = del;
		this.wait = wait;
		this.readcount = readcount;
		this.notice = notice;
		this.delby = delby;
	}
	public QnaDto(String nickname, String title, String content) {
		super();
		this.nickname = nickname;
		this.title = title;
		this.content = content;
	}
	
	
	
	// 비밀글 작성
	public QnaDto(int seq, String nickname, int ref, int step, String title, String content, String wdate, int del,
			int wait, int readcount, int notice, int delby, String pwd) {
		super();
		this.seq = seq;
		this.nickname = nickname;
		this.ref = ref;
		this.step = step;
		this.title = title;
		this.content = content;
		this.wdate = wdate;
		this.del = del;
		this.wait = wait;
		this.readcount = readcount;
		this.notice = notice;
		this.delby = delby;
		this.pwd = pwd;
	}
	
	
	

	public QnaDto(String nickname, String title, String content, String pwd) {
		super();
		this.nickname = nickname;
		this.title = title;
		this.content = content;
		this.pwd = pwd;
	}

	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getStep() {
		return step;
	}
	public void setStep(int step) {
		this.step = step;
	}
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWdate() {
		return wdate;
	}
	public void setWdate(String wdate) {
		this.wdate = wdate;
	}
	public int getDel() {
		return del;
	}
	public void setDel(int del) {
		this.del = del;
	}
	public int getWait() {
		return wait;
	}
	public void setWait(int wait) {
		this.wait = wait;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public int getNotice() {
		return notice;
	}
	public void setNotice(int notice) {
		this.notice = notice;
	}
	
	public int getDelby() {
		return delby;
	}

	public void setDelby(int delby) {
		this.delby = delby;
	}
	

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	@Override
	public String toString() {
		return "QnaDto [seq=" + seq + ", nickname=" + nickname + ", ref=" + ref + ", step=" + step + ", title=" + title
				+ ", content=" + content + ", wdate=" + wdate + ", del=" + del + ", wait=" + wait + ", readcount="
				+ readcount + ", notice=" + notice + ", delby=" + delby + ", pwd=" + pwd + "]";
	}



}
