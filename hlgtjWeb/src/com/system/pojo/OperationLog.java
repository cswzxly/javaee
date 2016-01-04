package com.system.pojo;

public class OperationLog {

	private Integer theID;
	private String createDate;//创建时间
	private String operatorID;//登陆账号
	private String operatorName;//登陆用户名
	private String ipAddress;//ip地址
	private String details;//操作细节
	private String catalogID;//栏目id
	private String catalogName;//栏目名称
	public Integer getTheID() {
		return theID;
	}
	public void setTheID(Integer theID) {
		this.theID = theID;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getOperatorID() {
		return operatorID;
	}
	public void setOperatorID(String operatorID) {
		this.operatorID = operatorID;
	}
	public String getOperatorName() {
		return operatorName;
	}
	public void setOperatorName(String operatorName) {
		this.operatorName = operatorName;
	}
	public String getIpAddress() {
		return ipAddress;
	}
	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}
	public String getDetails() {
		return details;
	}
	public void setDetails(String details) {
		this.details = details;
	}
	public String getCatalogID() {
		return catalogID;
	}
	public void setCatalogID(String catalogID) {
		this.catalogID = catalogID;
	}
	public String getCatalogName() {
		return catalogName;
	}
	public void setCatalogName(String catalogName) {
		this.catalogName = catalogName;
	}
	
}
