package dto;
/*
 CREATE TABLE RE(
   RENUMBER NUMBER(8) PRIMARY KEY, 	-- 댓글 글번호
   NICKNAME VARCHAR2(50) NOT NULL,  -- 댓글작성자
   WDATE DATE NOT NULL,				-- 작성일
   SEQ NUMBER(8) NOT NULL, 			-- 부모글
   CONTENT VARCHAR2(5000) NOT NULL 	-- 댓글 내용
);
 */
public class CommentsDto {
	private int renumber;
	private String nickname;
	private String wdate;
	private int seq;
	private String content;
	
	public CommentsDto() {}

	public CommentsDto(int renumber, String nickname, String wdate, int seq, String content) {
		super();
		this.renumber = renumber;
		this.nickname = nickname;
		this.wdate = wdate;
		this.seq = seq;
		this.content = content;
	}
	
	


	public CommentsDto(String nickname, int seq, String content) {
		super();
		this.nickname = nickname;
		this.seq = seq;
		this.content = content;
	}

	public int getRenumber() {
		return renumber;
	}

	public void setRenumber(int renumber) {
		this.renumber = renumber;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getWdate() {
		return wdate;
	}

	public void setWdate(String wdate) {
		this.wdate = wdate;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Override
	public String toString() {
		return "CommentsDto [renumber=" + renumber + ", nickname=" + nickname + ", wdate=" + wdate + ", seq=" + seq
				+ ", content=" + content + "]";
	}
	
	
	
	
}
