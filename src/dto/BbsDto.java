package dto;

public class BbsDto {
	private int seq;
	private String nickname;
	
	private String title;
	private String content;
	private String cago;
	private String filename;
	private String newfilename;
	private String wdate;
	
	private int del;		// �궘�젣
	private int readcount;	// 議고쉶�닔
	private int downcount;
	
	public BbsDto() {
	}

	public BbsDto(int seq, String nickname, String title, String content, String cago, String filename,
			String newfilename, String wdate, int del, int downcount, int readcount) {
		super();
		this.seq = seq;
		this.nickname = nickname;
		this.title = title;
		this.content = content;
		this.cago = cago;
		this.filename = filename;
		this.newfilename = newfilename;
		this.wdate = wdate;
		this.del = del;
		this.downcount = downcount;
		this.readcount = readcount;
	}

	public BbsDto(String nickname, String title, String content, String cago, String filename, String newfilename) {
		super();
		this.nickname = nickname;
		this.title = title;
		this.content = content;
		this.cago = cago;
		this.filename = filename;
		this.newfilename = newfilename;
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

	public String getCago() {
		return cago;
	}

	public void setCago(String cago) {
		this.cago = cago;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getNewfilename() {
		return newfilename;
	}

	public void setNewfilename(String newfilename) {
		this.newfilename = newfilename;
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
		return "BbsDto [seq=" + seq + ", nickname=" + nickname + ", title=" + title + ", content=" + content + ", cago="
				+ cago + ", filename=" + filename + ", newfilename=" + newfilename + ", wdate=" + wdate + ", del=" + del
				+ ", readcount=" + readcount + ", downcount=" + downcount + "]";
	}

	

	
}
