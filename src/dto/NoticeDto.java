package dto;

import java.io.Serializable;

public class NoticeDto implements Serializable{
	private int seq;
	private String nickname;
	
	private String title;
	private String content;
	private String filename; //원본 파일명
	private String newFilename; //변환 파일명
	private String wdate;
	private int readcount;
	private int downcount;


	public NoticeDto() {
		
	}

	public NoticeDto(int seq, String nickname, String title, String content, String filename, String newFilename, String wdate, int readcount, int downcount) {
		super();
		this.seq = seq;
		this.nickname = nickname;
		this.title = title;
		this.content = content;
		this.filename = filename;
		this.newFilename = newFilename;
		this.wdate = wdate;
		this.readcount = readcount;
		this.downcount = downcount;
		
	}

	public NoticeDto(String nickname, String title, String content) {
		super();
		this.nickname = nickname;
		this.title = title;
		this.content = content;
	}
	
	public NoticeDto(String nickname, String title, String content, String filename, String newFilename) {
		super();
		this.nickname = nickname;
		this.title = title;
		this.content = content;
		this.filename = filename;
		this.newFilename = newFilename;
	}
	
	public NoticeDto(String title, String content, String filename, String newFilename, int seq) {
		super();
		this.title = title;
		this.content = content;
		this.filename = filename;
		this.newFilename = newFilename;
		this.seq = seq;
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

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getNewFilename() {
		return newFilename;
	}

	public void setNewFilename(String newFilename) {
		this.newFilename = newFilename;
	}

	public String getWdate() {
		return wdate;
	}

	public void setWdate(String wdate) {
		this.wdate = wdate;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	
	public int getDowncount() {
		return downcount;
	}

	public void setDowncount(int downcount) {
		this.downcount = downcount;
	}

	@Override
	public String toString() {
		return "NoticeDto [seq=" + seq + ", nickname=" + nickname + ", title=" + title + ", content=" + content
				+ ", filename=" + filename + ", newFilename=" + newFilename + ", wdate=" + wdate + ", readcount="
				+ readcount + ", downcount=" + downcount + "]";
	}
}


