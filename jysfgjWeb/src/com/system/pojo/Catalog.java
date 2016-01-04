package com.system.pojo;

public class Catalog {
    private Integer theID;
    private String parentID;
    private String title;
    private String status;
    private Integer sort;
    private String catalogType;
    private String url;
    private String isFirstCatalog;
    private String isUploadPic;
    private String topNum;

    private String statusName;
    private String catalogTypeName;
    private String desId;

    //角色表[t_role]字段
    private Integer roleId;

    public Integer getTheID() {
        return theID;
    }

    public void setTheID(Integer theID) {
        this.theID = theID;
    }

    public String getParentID() {
        return parentID;
    }

    public void setParentID(String parentID) {
        this.parentID = parentID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
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

    public String getCatalogType() {
        return catalogType;
    }

    public void setCatalogType(String catalogType) {
        this.catalogType = catalogType;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getIsFirstCatalog() {
        return isFirstCatalog;
    }

    public void setIsFirstCatalog(String isFirstCatalog) {
        this.isFirstCatalog = isFirstCatalog;
    }

    public String getIsUploadPic() {
        return isUploadPic;
    }

    public void setIsUploadPic(String isUploadPic) {
        this.isUploadPic = isUploadPic;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

    public String getCatalogTypeName() {
        return catalogTypeName;
    }

    public void setCatalogTypeName(String catalogTypeName) {
        this.catalogTypeName = catalogTypeName;
    }

    public String getTopNum() {
        return topNum;
    }

    public void setTopNum(String topNum) {
        this.topNum = topNum;
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

	public String getDesId() {
		return desId;
	}

	public void setDesId(String desId) {
		this.desId = desId;
	}
}
