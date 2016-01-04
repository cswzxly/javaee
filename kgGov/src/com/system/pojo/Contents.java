package com.system.pojo;

public class Contents {
    private Integer theID;
    private Integer catalogID;
    private String title;
    private String contents;
    private String creater_pid;
    private String create_date;
    private String update_pid;
    private String update_date;
    private String source;
    private String status;
    private Integer sort;
    private String releaseDate;
    private String secTitle;//2级标题或副标题
    private String isTop;//是否头条新闻
    private String isFocus;//是否今日关注
    private Integer visitCount;


    private String catalogName;
    private String statusName;
    private String topNum;
    private String resultNum;
    private String userName;//发布人姓名
    private String catalogPid;
    private String desId;
    private String allTitle;
    
    private Integer[] ids;

    public Integer getVisitCount() {
        return visitCount;
    }

    public void setVisitCount(Integer visitCount) {
        this.visitCount = visitCount;
    }

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

    public String getContents() {
        return contents;
    }

    public void setContents(String contents) {
        this.contents = contents;
    }

    public String getCreater_pid() {
        return creater_pid;
    }

    public void setCreater_pid(String creater_pid) {
        this.creater_pid = creater_pid;
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

    public String getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(String releaseDate) {
        this.releaseDate = releaseDate;
    }

    public String getCatalogName() {
        return catalogName;
    }

    public void setCatalogName(String catalogName) {
        this.catalogName = catalogName;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

    public String getTopNum() {
        return topNum;
    }

    public void setTopNum(String topNum) {
        this.topNum = topNum;
    }

    public String getResultNum() {
        return resultNum;
    }

    public void setResultNum(String resultNum) {
        this.resultNum = resultNum;
    }

    public String getSecTitle() {
        return secTitle;
    }

    public void setSecTitle(String secTitle) {
        this.secTitle = secTitle;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getIsTop() {
        return isTop;
    }

    public void setIsTop(String isTop) {
        this.isTop = isTop;
    }

    public String getCatalogPid() {
        return catalogPid;
    }

    public void setCatalogPid(String catalogPid) {
        this.catalogPid = catalogPid;
    }

    public String getIsFocus() {
        return isFocus;
    }

    public String getAllTitle() {
		return allTitle;
	}

	public void setAllTitle(String allTitle) {
		this.allTitle = allTitle;
	}

	public void setIsFocus(String isFocus) {
        this.isFocus = isFocus;
    }

	public String getDesId() {
		return desId;
	}

	public void setDesId(String desId) {
		this.desId = desId;
	}

	public Integer[] getIds() {
		return ids;
	}

	public void setIds(Integer[] ids) {
		this.ids = ids;
	}
}
