package com.barunsw.simple.user;

public class UserVo {
	
	private String userId;
	private String name;
	private String birth;
	private String gender;
	private String createDate;
	
	public UserVo() {}

	public UserVo(String userId, String name, String birth, String gender) {
		this.userId = userId;
		this.name = name;
		this.birth = birth;
		this.gender = gender;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	@Override
	public String toString() {
		return "UserVo [userId=" + userId + ", name=" + name + ", birth=" + birth + ", gender=" + gender
				+ ", createDate=" + createDate + "]";
	}
}
