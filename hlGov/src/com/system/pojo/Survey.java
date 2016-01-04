package com.system.pojo;

//网上调查-实体类
public class Survey {

	private Integer theID;
	private String title; //调查主题
	private String summary; //主题摘要
	private String beginDate; //开始时间
	private String endDate; //结束时间
	private String status; //状态  1启用/2禁用
	private String theDate; //创建时间
	private Integer userID; //创建人ID
	
	public Integer getTheID() {
		return theID;
	}
	public void setTheID(Integer theID) {
		this.theID = theID;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public String getBeginDate() {
		return beginDate;
	}
	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
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
