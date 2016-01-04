package com.system.pojo;

public class Titlepic {

	private Integer theID; 
	private String name; //图片名称
	private String url;  //图片url
	private String theDate;  //创建时间
	private Integer userID;  //创建人ID
	private String linkUrl;
	
	public Integer getTheID() {
		return theID;
	}
	public void setTheID(Integer theID) {
		this.theID = theID;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getTheDate() {
		return theDate;
	}
	public void setTheDate(String theDate) {
		this.theDate = theDate;
	}
	public Integer getUserID() {
		return userID;
	}
	public void setUserID(Integer userID) {
		this.userID = userID;
	}
	public String getLinkUrl() {
		return linkUrl;
	}
	public void setLinkUrl(String linkUrl) {
		this.linkUrl = linkUrl;
	}
	
}
