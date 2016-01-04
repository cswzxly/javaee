package com.system.pojo;

public class Video {
	private Integer theID;
	private Integer catalogID;
	private String title;
	private String creater_pid;
	private String creater_name;
	private String create_date;
	private String update_pid;
	private String update_name;
	private String update_date;
	private String source;
	private String status;
	private Integer sort;
	private String releaseDate;
	private String url;
	private String topNum;
	private String isindex;
	
	//非数据库字段
	private String catalogName;//栏目名称
	private String statusName;
	private String desId;
	
	public Integer getTheID() {
		return theID;
	}

	public void setTheID(Integer theID) {
		this.theID = theID;
	}

	public Integer getCatalogID() {
		return catalogID;
	}

	public void setCatalogID(Integer catalogID) {
		this.catalogID = catalogID;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getCreater_pid() {
		return creater_pid;
	}

	public void setCreater_pid(String creater_pid) {
		this.creater_pid = creater_pid;
	}

	public String getCreater_name() {
		return creater_name;
	}

	public void setCreater_name(String creater_name) {
		this.creater_name = creater_name;
	}

	public String getCreate_date() {
		return create_date;
	}

	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}

	public String getUpdate_pid() {
		return update_pid;
	}

	public void setUpdate_pid(String update_pid) {
		this.update_pid = update_pid;
	}

	public String getUpdate_name() {
		return update_name;
	}

	public void setUpdate_name(String update_name) {
		this.update_name = update_name;
	}

	public String getUpdate_date() {
		return update_date;
	}

	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public String getCatalogName() {
		return catalogName;
	}

	public void setCatalogName(String catalogName) {
		this.catalogName = catalogName;
	}

	public String getReleaseDate() {
		return releaseDate;
	}

	public void setReleaseDate(String releaseDate) {
		this.releaseDate = releaseDate;
	}

	public String getStatusName() {
		return statusName;
	}

	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getTopNum() {
		return topNum;
	}

	public void setTopNum(String topNum) {
		this.topNum = topNum;
	}

	public String getIsindex() {
		return isindex;
	}

	public void setIsindex(String isindex) {
		this.isindex = isindex;
	}

	public String getDesId() {
		return desId;
	}

	public void setDesId(String desId) {
		this.desId = desId;
	}
	
}
