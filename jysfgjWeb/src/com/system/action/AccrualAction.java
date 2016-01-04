package com.system.action;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.fastjson.JSONObject;
import com.system.pojo.Accrual;
import com.system.pojo.Catalog;
import com.system.pojo.OperationLog;
import com.system.pojo.User;
import com.system.services.AccrualServices;
import com.system.services.CatalogServices;
import com.system.services.OperationLogServices;
import com.system.utils.DateUtils;

/**
 * @author hchch
 * 2015年6月17日
 */
public class AccrualAction extends BaseAction {

	@Autowired
	private AccrualServices accrualServices;
	@Autowired
	private CatalogServices catalogServices;
	@Autowired
    private OperationLogServices operationLogServices;
	
	private String theID;
	private String catalogID;//栏目id
	private String create_date;//创建时间
	private Integer creater_pid;//创建人
	private String update_date;//修改时间
	private Integer update_pid;//修改人
	private String status;//状态
	private Integer sort;//排序
	private String releaseDate;//发布日期
	private String accrualType;//权责种类
	
	private String title;//项目名称
	private String secTitle;//子项目名称
	private String remark;//备注
	private String contents;//实施依据
	
	private String approvalObject;//审批对象
	private String approvalDept;//审批部门
	
	private String illegalAct;//违法行为
	private String punishType;//处罚种类
	
	private String compulsoryObject;//强制对象
	private String compulsoryMeasures;//强制措施

	private String levyItem;//征收项目
	private String levyStandard;//征收标准
	
	private String theIDs;
	
	private List<Accrual> accrualList;
	
	private Accrual accrual;
	
	/**
	 * @return
	 */
	public String newAccrualPage(){
		//判断是否还有叶子节点
        Catalog c = new Catalog();
        c.setParentID(catalogID);
        List<Catalog> list = catalogServices.queryCatalogListByBean(c);
        if (list.size() > 0) {
            return "list";   //如果还有叶子节点，不让其执行添加操作，返回列表
        }

        Catalog catalogT = new Catalog();
        catalogT.setTheID(Integer.valueOf(catalogID));
        Catalog catalog = catalogServices.queryCatalogByBean(catalogT);

        this.request.setAttribute("catalog", catalog);
        this.request.setAttribute("now", DateUtils.getNowTime());
        String type = request.getParameter("type");
        if(type != null && !type.equals("")){
        	request.setAttribute("accrualType", type);
        	if(type.equals("1") || type.equals("2")){//行政许可或者非行政许可审批
        		return "newApprovalPage";
        	}else if(type.equals("3")){//行政处罚
        		return "newPunishPage";
        	}else if(type.equals("4")){//行政强制
        		return "newCompulsoryPage";
        	}else if(type.equals("5")){//行政征收
        		return "newLevyPage";
        	}else if(type.equals("6") || type.equals("7") || type.equals("8") || type.equals("9") 
        			|| type.equals("10")){//行政给付、行政检查、行政指导、行政确认、其他
        		return "newOtherPage";
        	}
        }

		return "newAccrualPage";
	}
	
	/**
	 * 
	 */
	public String saveNewAccrual(){
		User user = (User) this.getRequest().getSession().getAttribute("userInSession");
		if(accrualType != null){
			if(accrualType.equals("1") || accrualType.equals("2")){//行政许可或者非行政许可审批
        		Accrual accrual = new Accrual();
        		accrual.setAccrualType(accrualType);
    			accrual.setTitle(title);
    			accrual.setCreater_pid(user.getId());
    			accrual.setCreate_date(DateUtils.getNowTime());
    			accrual.setSort(0);
    			accrual.setReleaseDate(releaseDate);
    			accrual.setStatus("1");
    			accrual.setPid(0);
    			accrual.setCatalogID(Integer.valueOf(catalogID));
    			accrualServices.insertAccrual(accrual);
    			System.out.println(">>>>>>>>>>>>>>>>>accrualList.size:"+accrualList.size());
        		if(accrualList.size() > 0){
        			System.out.println(">>>>>>>>>>>>>>>>>>>addChild");
        			for(Accrual a : accrualList){
        				a.setAccrualType(accrualType);
        				a.setCatalogID(Integer.valueOf(catalogID));
        				a.setPid(accrual.getTheID());
        				a.setCreater_pid(user.getId());
        				a.setCreate_date(DateUtils.getNowTime());
        				accrualServices.insertAccrual(a);
        			}
        		}
        	}else if(accrualType.equals("3")){//行政处罚
        		Accrual accrual = new Accrual();
        		accrual.setAccrualType(accrualType);
    			accrual.setTitle(title);
    			accrual.setCreater_pid(user.getId());
    			accrual.setCreate_date(DateUtils.getNowTime());
    			accrual.setReleaseDate(releaseDate);
    			accrual.setSort(0);
    			accrual.setStatus(status);
    			accrual.setPid(0);
    			accrual.setCatalogID(Integer.valueOf(catalogID));
    			accrual.setPunishType(punishType);
    			accrual.setContents(contents);
    			accrual.setRemark(remark);
    			accrualServices.insertAccrual(accrual);
        	}else if(accrualType.equals("4")){//行政强制
        		Accrual accrual = new Accrual();
        		accrual.setAccrualType(accrualType);
    			accrual.setTitle(title);
    			accrual.setCreater_pid(user.getId());
    			accrual.setCreate_date(DateUtils.getNowTime());
    			accrual.setReleaseDate(releaseDate);
    			accrual.setSort(0);
    			accrual.setStatus(status);
    			accrual.setPid(0);
    			accrual.setCatalogID(Integer.valueOf(catalogID));
    			accrual.setCompulsoryMeasures(compulsoryMeasures);
    			accrual.setContents(contents);
    			accrual.setRemark(remark);
    			accrualServices.insertAccrual(accrual);
        	}else if(accrualType.equals("5")){//行政征收
        		Accrual accrual = new Accrual();
        		accrual.setAccrualType(accrualType);
    			accrual.setTitle(title);
    			accrual.setCreater_pid(user.getId());
    			accrual.setCreate_date(DateUtils.getNowTime());
    			accrual.setReleaseDate(releaseDate);
    			accrual.setSort(0);
    			accrual.setStatus(status);
    			accrual.setPid(0);
    			accrual.setCatalogID(Integer.valueOf(catalogID));
    			accrual.setLevyStandard(levyStandard);
    			accrual.setContents(contents);
    			accrual.setRemark(remark);
    			accrualServices.insertAccrual(accrual);
        	}else if(accrualType.equals("6") || accrualType.equals("7") || accrualType.equals("8") || accrualType.equals("9") 
        			|| accrualType.equals("10")){//行政给付、行政检查、行政指导、行政确认、其他
        		Accrual accrual = new Accrual();
        		accrual.setAccrualType(accrualType);
    			accrual.setTitle(title);
    			accrual.setCreater_pid(user.getId());
    			accrual.setCreate_date(DateUtils.getNowTime());
    			accrual.setReleaseDate(releaseDate);
    			accrual.setSort(0);
    			accrual.setStatus(status);
    			accrual.setPid(0);
    			accrual.setCatalogID(Integer.valueOf(catalogID));
    			accrual.setContents(contents);
    			accrual.setRemark(remark);
    			accrualServices.insertAccrual(accrual);
        	}
		}
		request.setAttribute("catalogID", catalogID);
		return "list";
//		 PrintWriter pw = null;
//	        User user = (User) this.getRequest().getSession().getAttribute("userInSession");
//	        try {
//	            this.getResponse().setCharacterEncoding("UTF-8");
//	            pw = this.getResponse().getWriter();
//	            Map<String, Object> map = new HashMap<String, Object>();
//	            String result;
//	            
//	            Accrual a = new Accrual();
//	            a.setTitle(title);
//	            a.setSecTitle(secTitle);
//	            a.setAccrualType(accrualType);
//	            a.setApprovalDept(approvalDept);
//	            a.setApprovalObject(approvalObject);
//	            a.setCatalogID(Integer.valueOf(catalogID));
//	            a.setCompulsoryMeasures(compulsoryMeasures);
//	            a.setCompulsoryObject(compulsoryObject);
//	            a.setContents(contents);
//	            a.setCreate_date(DateUtils.getNowTime());
//	            a.setCreater_pid(user.getId());
//	            a.setIllegalAct(illegalAct);
//	            a.setLevyItem(levyItem);
//	            a.setLevyStandard(levyStandard);
//	            a.setPunishType(punishType);
//	            a.setReleaseDate(releaseDate);
//	            a.setRemark(remark);
//	            a.setSort(0);
//	            a.setStatus(status);
//	            accrualServices.insertAccrual(a);
//	            
//	            logger.info(">>>>>>>>>>>>>>>>>>>>插入操作日志>>>>>>>>>>>>>>>>>>>>");
//	            Catalog catalog = new Catalog();
//	            catalog.setTheID(Integer.valueOf(catalogID));
//	            catalog = catalogServices.queryCatalogByBean(catalog);
//
//	            OperationLog ol = new OperationLog();
//	            ol.setCreateDate(DateUtils.getNowTime());
//	            ol.setOperatorID(String.valueOf(user.getUserName()));
//	            ol.setOperatorName(user.getRealName());
//	            ol.setIpAddress(request.getRemoteAddr());
//	            ol.setCatalogID(catalogID);
//	            ol.setCatalogName(catalog.getTitle());
//	            ol.setDetails("在“"+catalog.getTitle()+"”栏目下新增了一条内容："+a.getTitle());
//	            operationLogServices.insertOperationLog(ol);
//	            
//	            result = "success";
//	            map.put("result", result);
//	            map.put("contentsID", a.getTheID());//返回新建记录的id
//	            String strMap = JSONObject.toJSONString(map);
//	            pw.write(strMap);
//	        } catch (Exception e) {
//	            e.printStackTrace();
//	        }
//	        pw.flush();
//	        pw.close();
	}
	
	/**
	 * @return
	 */
	public String showAccrualEdit(){
		if(theID != null){
			Accrual a = accrualServices.queryOneAccrualById(Integer.valueOf(theID));
			if(a != null && a.getCatalogID() != null){
				Catalog catalog = new Catalog();
				catalog.setTheID(Integer.valueOf(a.getCatalogID()));
				catalog = catalogServices.queryCatalogByBean(catalog);
				request.setAttribute("catalog", catalog);
				request.setAttribute("accrual", a);
				
				if(a.getAccrualType().equals("1") || a.getAccrualType().equals("2")){
					
					accrualList = accrualServices.getAccrualListByPid(Integer.valueOf(theID));
					return "showApprovalPage";
				}else if(a.getAccrualType().equals("3")){
					return "showPunishPage";
				}else if(a.getAccrualType().equals("4")){
					return "showCompulsoryPage";
				}else if(a.getAccrualType().equals("5")){
					return "showLevyPage";
				}else if(a.getAccrualType().equals("6") || a.getAccrualType().equals("7") 
						|| a.getAccrualType().equals("8") || a.getAccrualType().equals("9")
						|| a.getAccrualType().equals("10")){
					return "showOtherPage";
				}
			}
		}
		return "showAccrualEdit";
	}
	
	/**
	 * 
	 */
	public String saveEditAccrual(){
		User user = (User) this.getRequest().getSession().getAttribute("userInSession");
		
		accrualType = accrual.getAccrualType();
		if(accrualType != null){
			if(accrualType.equals("1") || accrualType.equals("2")){//行政许可或者非行政许可审批
        		Accrual a = accrualServices.queryOneAccrualById(accrual.getTheID());
        		a.setTitle(accrual.getTitle());
    			a.setUpdate_pid(user.getId());
    			a.setUpdate_date(DateUtils.getNowTime());
    			a.setReleaseDate(accrual.getReleaseDate());
    			a.setPid(0);
    			accrualServices.updateAccrual(a);
        		if(accrualList.size() > 0){
        			for(Accrual temp : accrualList){
        				if(temp.getTheID() != null){
        					temp.setUpdate_pid(user.getId());
        					temp.setUpdate_date(DateUtils.getNowTime());
	        				accrualServices.updateAccrual(temp);
        				}else{
        					temp.setAccrualType(accrualType);
        					temp.setCatalogID(Integer.valueOf(catalogID));
        					temp.setPid(accrual.getTheID());
        					temp.setCreater_pid(user.getId());
        					temp.setCreate_date(DateUtils.getNowTime());
            				accrualServices.insertAccrual(a);
        				}
        			}
        		}
        	}else if(accrualType.equals("3")){//行政处罚
        		Accrual a = accrualServices.queryOneAccrualById(accrual.getTheID());
        		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>"+accrual.getTitle());
    			a.setTitle(accrual.getTitle());
    			a.setUpdate_pid(user.getId());
    			a.setUpdate_date(DateUtils.getNowTime());
    			a.setReleaseDate(accrual.getReleaseDate());
    			a.setStatus(accrual.getStatus());
    			a.setPunishType(accrual.getPunishType());
    			a.setContents(accrual.getContents());
    			a.setRemark(accrual.getRemark());
    			accrualServices.updateAccrual(a);
        	}else if(accrualType.equals("4")){//行政强制
        		Accrual a = accrualServices.queryOneAccrualById(accrual.getTheID());
    			a.setTitle(accrual.getTitle());
    			a.setUpdate_pid(user.getId());
    			a.setUpdate_date(DateUtils.getNowTime());
    			a.setReleaseDate(accrual.getReleaseDate());
    			a.setStatus(accrual.getStatus());
    			a.setCompulsoryMeasures(accrual.getCompulsoryMeasures());
    			a.setContents(accrual.getContents());
    			a.setRemark(accrual.getRemark());
    			accrualServices.updateAccrual(a);
        	}else if(accrualType.equals("5")){//行政征收
        		Accrual a = accrualServices.queryOneAccrualById(accrual.getTheID());
    			a.setTitle(accrual.getTitle());
    			a.setUpdate_pid(user.getId());
    			a.setUpdate_date(DateUtils.getNowTime());
    			a.setReleaseDate(accrual.getReleaseDate());
    			a.setStatus(accrual.getStatus());
    			a.setLevyStandard(accrual.getLevyStandard());
    			a.setContents(accrual.getContents());
    			a.setRemark(accrual.getRemark());
    			accrualServices.updateAccrual(a);
        	}else if(accrualType.equals("6") || accrualType.equals("7") || accrualType.equals("8") || accrualType.equals("9") 
        			|| accrualType.equals("10")){//行政给付、行政检查、行政指导、行政确认、其他
        		Accrual a = accrualServices.queryOneAccrualById(accrual.getTheID());
    			a.setTitle(accrual.getTitle());
    			a.setUpdate_pid(user.getId());
    			a.setUpdate_date(DateUtils.getNowTime());
    			a.setReleaseDate(accrual.getReleaseDate());
    			a.setStatus(accrual.getStatus());
    			a.setContents(accrual.getContents());
    			a.setRemark(accrual.getRemark());
    			accrualServices.updateAccrual(a);
        	}
		}
		request.setAttribute("catalogID", catalogID);
		return "list";
	        
	}
	
	/**
	 * 
	 */
	public void deleteAccrual(){
		PrintWriter pw = null;
        User user = (User) this.getRequest().getSession().getAttribute("userInSession");
        try {
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            String result;
            Accrual a = accrualServices.queryOneAccrualById(Integer.valueOf(theID));
            if(a != null){
            	String title = a.getTitle();
            	String accrualType = a.getAccrualType();
            	accrualServices.deleteAccrual(a);
            	if(accrualType.equals("1") || accrualType.equals("2")){
	            	List<Accrual> list = accrualServices.getAccrualListByPid(Integer.valueOf(theID));
	            	String ids = "";
	            	if(list.size() > 1){
		            	for(int i = 0;i < list.size();i++){
		            		if(i != list.size()-1){
		            			ids = ids + list.get(i).getTheID() + ",";
		            		}else{
		            			ids = ids + list.get(i).getTheID();
		            		}
		            	}
	            	}else if(list.size() == 1){
	            		ids = "" +list.get(0).getTheID();
	            	}else{
	            		ids = null;
	            	}
	            	if(ids != null){
	            		accrualServices.batchDeleteAccrual(ids);
	            	}
            	}
            	
            	Catalog catalog = new Catalog();
                catalog.setTheID(Integer.valueOf(a.getCatalogID()));
                catalog = catalogServices.queryCatalogByBean(catalog);
                 
                OperationLog ol = new OperationLog();
                ol.setCreateDate(DateUtils.getNowTime());
                ol.setOperatorID(String.valueOf(user.getUserName()));
                ol.setOperatorName(user.getRealName());
                ol.setIpAddress(request.getRemoteAddr());
                ol.setCatalogID(catalogID);
                ol.setCatalogName(catalog.getTitle());
                if(accrualType.equals("1") || accrualType.equals("2")){
                	ol.setDetails("在“"+catalog.getTitle()+"”栏目下删除了一条内容："+title+"及其下属的项目");
                }else{
                	ol.setDetails("在“"+catalog.getTitle()+"”栏目下删除了一条内容："+title);
                }
                operationLogServices.insertOperationLog(ol);
                 
                result = "success";
             } else {
                result = "fail";
             }
        } catch (Exception e) {
            e.printStackTrace();
        }
        pw.flush();
        pw.close();
	}
	
	/**
     * 批量删除
     */
    public void batchDeleteContents() {
    	 PrintWriter pw = null;
         try {
             this.getResponse().setCharacterEncoding("UTF-8");
             pw = this.getResponse().getWriter();
             String result;
             if (theIDs != null && !theIDs.equals("")) {
                 accrualServices.batchDeleteAccrual(theIDs);
                 result = "success";
             } else {
                 result = "fail";
             }
             pw.write(result);
         } catch (Exception e) {
             e.printStackTrace();
         }
         pw.flush();
         pw.close();
    }

	public String getTheID() {
		return theID;
	}

	public void setTheID(String theID) {
		this.theID = theID;
	}

	public String getCatalogID() {
		return catalogID;
	}

	public void setCatalogID(String catalogID) {
		this.catalogID = catalogID;
	}

	public String getCreate_date() {
		return create_date;
	}

	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}

	public Integer getCreater_pid() {
		return creater_pid;
	}

	public void setCreater_pid(Integer creater_pid) {
		this.creater_pid = creater_pid;
	}

	public String getUpdate_date() {
		return update_date;
	}

	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
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

	public String getSecTitle() {
		return secTitle;
	}

	public void setSecTitle(String secTitle) {
		this.secTitle = secTitle;
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

	public String getIllegalAct() {
		return illegalAct;
	}

	public void setIllegalAct(String illegalAct) {
		this.illegalAct = illegalAct;
	}

	public String getPunishType() {
		return punishType;
	}

	public void setPunishType(String punishType) {
		this.punishType = punishType;
	}

	public String getCompulsoryObject() {
		return compulsoryObject;
	}

	public void setCompulsoryObject(String compulsoryObject) {
		this.compulsoryObject = compulsoryObject;
	}

	public String getCompulsoryMeasures() {
		return compulsoryMeasures;
	}

	public void setCompulsoryMeasures(String compulsoryMeasures) {
		this.compulsoryMeasures = compulsoryMeasures;
	}

	public String getLevyItem() {
		return levyItem;
	}

	public void setLevyItem(String levyItem) {
		this.levyItem = levyItem;
	}

	public String getLevyStandard() {
		return levyStandard;
	}

	public void setLevyStandard(String levyStandard) {
		this.levyStandard = levyStandard;
	}

	public String getTheIDs() {
		return theIDs;
	}

	public void setTheIDs(String theIDs) {
		this.theIDs = theIDs;
	}

	public List<Accrual> getAccrualList() {
		return accrualList;
	}

	public void setAccrualList(List<Accrual> accrualList) {
		this.accrualList = accrualList;
	}

	public Accrual getAccrual() {
		return accrual;
	}

	public void setAccrual(Accrual accrual) {
		this.accrual = accrual;
	}
    
}
