package com.system.pojo;

/**
 * @author hchch
 *
 * 2014年11月3日
 */
public class OpinionPollInfo {

	private Integer theID;
	private Integer opinionID;
	private String name;
	private String phone;
	private String email;
	private String contents;
	private String createDate;
	private String ip;
	public Integer getTheID() {
		return theID;
	}
	public void setTheID(Integer theID) {
		this.theID = theID;
	}
	public Integer getOpinionID() {
		return opinionID;
	}
	public void setOpinionID(Integer opinionID) {
		this.opinionID = opinionID;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	
}
