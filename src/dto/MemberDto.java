package dto;

import java.io.Serializable;

public class MemberDto implements Serializable{
	private String id;
	private String pwd;
	private String nickname;
	private String birth;
	private String gender;
	private String email;
	private int auth;
	
	public MemberDto() {}

	public MemberDto(String id, String pwd, String nickname, String birth, String gender, String email, int auth) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.nickname = nickname;
		this.birth = birth;
		this.gender = gender;
		this.email = email;
		this.auth = auth;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getAuth() {
		return auth;
	}

	public void setAuth(int auth) {
		this.auth = auth;
	}

	@Override
	public String toString() {
		return "MemberDto [id=" + id + ", pwd=" + pwd + ", nickname=" + nickname + ", birth=" + birth + ", gender="
				+ gender + ", email=" + email + ", auth=" + auth + "]";
	}


	
	
	
	
}
