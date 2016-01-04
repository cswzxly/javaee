package com.system.pojo;

//网上调查结果信息-实体类 
public class SurveyInfo {

	private Integer theID;
	private String pID; //父ID
	private String content; //选项内容
	private String count; //点击率
	private String status; //状态  1-启用/2-禁用
	private String theDate; //创建时间
	private Integer userID; //创建人ID
	
	public Integer getTheID() {
		return theID;
	}
	public void setTheID(Integer theID) {
		this.theID = theID;
	}
	public String getpID() {
		return pID;
	}
	public void setpID(String pID) {
		this.pID = pID;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCount() {
		return count;
	}
	public void setCount(String count) {
		this.count = count;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
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
	
}
