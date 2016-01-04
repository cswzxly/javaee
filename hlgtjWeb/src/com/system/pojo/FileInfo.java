package com.system.pojo;

public class FileInfo {
    private Integer theID;
    private Integer contentID;
    private String fileType;
    private String title;
    private String fileUrl;
    private String isshow;
    private String source;
    private Integer sort;
    private String isindex;
    private String fileMode;// 文件模型：0、新闻模类 1、非新闻类
    private Integer catalogID;
    private String create_date;

    private String isshowName;
    private String fileTypeName;
    private String isindexName;
    
    private String desId;
    private Integer[] ids;
    private String topNum;

    public String getTopNum() {
        return topNum;
    }

    public void setTopNum(String topNum) {
        this.topNum = topNum;
    }

    public Integer getTheID() {
        return theID;
    }

    public void setTheID(Integer theID) {
        this.theID = theID;
    }

    public Integer getContentID() {
        return contentID;
    }

    public void setContentID(Integer contentID) {
        this.contentID = contentID;
    }

    public String getFileType() {
        return fileType;
    }

    public void setFileType(String fileType) {
        this.fileType = fileType;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getFileUrl() {
        return fileUrl;
    }

    public void setFileUrl(String fileUrl) {
        this.fileUrl = fileUrl;
    }

    public String getIsshow() {
        return isshow;
    }

    public void setIsshow(String isshow) {
        this.isshow = isshow;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public String getIsshowName() {
        return isshowName;
    }

    public void setIsshowName(String isshowName) {
        this.isshowName = isshowName;
    }

    public String getFileTypeName() {
        return fileTypeName;
    }

    public void setFileTypeName(String fileTypeName) {
        this.fileTypeName = fileTypeName;
    }

    public String getIsindex() {
        return isindex;
    }

    public void setIsindex(String isindex) {
        this.isindex = isindex;
    }

    public String getIsindexName() {
        return isindexName;
    }

    public void setIsindexName(String isindexName) {
        this.isindexName = isindexName;
    }

    public String getFileMode() {
        return fileMode;
    }

    public void setFileMode(String fileMode) {
        this.fileMode = fileMode;
    }

    public Integer getCatalogID() {
        return catalogID;
    }

    public void setCatalogID(Integer catalogID) {
        this.catalogID = catalogID;
    }

    public String getCreate_date() {
        return create_date;
    }

    public void setCreate_date(String create_date) {
        this.create_date = create_date;
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
