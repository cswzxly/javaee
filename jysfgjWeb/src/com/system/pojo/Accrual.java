package com.system.pojo;

import java.util.List;

/**
 * 权责清单
 * @author hchch
 * 2015年6月17日
 */
public class Accrual {

	private Integer theID;
	
	private Integer pid;//
	
	private Integer catalogID;//栏目id
	private String create_date;//创建时间
	private Integer creater_pid;//创建人
	private String update_date;//修改时间
	private Integer update_pid;//修改人
	private String status;//状态
	private Integer sort;//排序
	private String releaseDate;//发布日期
	private String accrualType;//权责种类
	
	private String title;//项目名称
//	private String secTitle;//子项目名称
	private String remark;//备注
	private String contents;//实施依据
	
	private String approvalObject;//审批对象
	private String approvalDept;//审批部门
	
//	private String illegalAct;//违法行为
	private String punishType;//处罚种类
	
//	private String compulsoryObject;//强制对象
	private String compulsoryMeasures;//强制措施

//	private String levyItem;//征收项目
	private String levyStandard;//征收标准
	
	//非数据库字段
	private List<Accrual> childList;
	public Integer getTheID() {
		return theID;
	}
	public void setTheID(Integer theID) {
		this.theID = theID;
	}
	public String getCreate_date() {
		return create_date;
	}
	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}
	public String getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
	}
	public String getAccrualType() {
		return accrualType;
	}
	public void setAccrualType(String accrualType) {
		this.accrualType = accrualType;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getApprovalObject() {
		return approvalObject;
	}
	public void setApprovalObject(String approvalObject) {
		this.approvalObject = approvalObject;
	}
	public String getApprovalDept() {
		return approvalDept;
	}
	public void setApprovalDept(String approvalDept) {
		this.approvalDept = approvalDept;
	}
	public String getPunishType() {
		return punishType;
	}
	public void setPunishType(String punishType) {
		this.punishType = punishType;
	}
	public String getCompulsoryMeasures() {
		return compulsoryMeasures;
	}
	public void setCompulsoryMeasures(String compulsoryMeasures) {
		this.compulsoryMeasures = compulsoryMeasures;
	}
	public String getLevyStandard() {
		return levyStandard;
	}
	public void setLevyStandard(String levyStandard) {
		this.levyStandard = levyStandard;
	}
	public Integer getCreater_pid() {
		return creater_pid;
	}
	public void setCreater_pid(Integer creater_pid) {
		this.creater_pid = creater_pid;
	}
	public Integer getUpdate_pid() {
		return update_pid;
	}
	public void setUpdate_pid(Integer update_pid) {
		this.update_pid = update_pid;
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
	public Integer getCatalogID() {
		return catalogID;
	}
	public void setCatalogID(Integer catalogID) {
		this.catalogID = catalogID;
	}
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	public List<Accrual> getChildList() {
		return childList;
	}
	public void setChildList(List<Accrual> childList) {
		this.childList = childList;
	}
	
}
