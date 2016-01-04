package com.system.action;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.fastjson.JSONObject;
import com.system.pojo.Catalog;
import com.system.pojo.OpinionPoll;
import com.system.pojo.OpinionPollInfo;
import com.system.pojo.User;
import com.system.services.CatalogServices;
import com.system.services.OpinionPollInfoServices;
import com.system.services.OpinionPollServices;
import com.system.utils.DateUtils;

public class OpinionPollAction extends BaseAction{

	@Autowired
	private OpinionPollServices opinionPollService;
	@Autowired
	private CatalogServices catalogServices;
	@Autowired
	private OpinionPollInfoServices opinionPollInfoServices;
	
	private String theID;
	private String catalogID;
	private String title;
	private String beginDate;
	private String endDate;
	private String status;
	private String isCollect;
	private String summary;
	private String releaseDate;
	
	public String newOpinionPollPage(){
		//判断是否还有叶子节点
		Catalog c = new Catalog();
		c.setParentID(catalogID);
		List<Catalog> list = catalogServices.queryCatalogListByBean(c);
		if(list.size()>0){
			return "list";   //如果还有叶子节点，不让其执行添加操作，返回列表
		}
		Catalog catalogT = new Catalog();
		catalogT.setTheID(Integer.valueOf(catalogID));
		Catalog catalog = catalogServices.queryCatalogByBean(catalogT);
		this.request.setAttribute("catalog", catalog);
		this.request.setAttribute("now", DateUtils.getNowTime());
		return "newOpinionPollPage";
	}
	
	public String showOpinionPollEdit(){
		OpinionPoll op = new OpinionPoll();
		op.setTheID(Integer.valueOf(theID));
		op = opinionPollService.queryOpinionPollByBean(op);
		
		Catalog catalogT = new Catalog();
		catalogT.setTheID(Integer.valueOf(op.getCatalogID()));
		Catalog catalog = catalogServices.queryCatalogByBean(catalogT);
		
		request.setAttribute("catalog", catalog);
		request.setAttribute("opinionPoll", op);
		return "showOpinionPollEdit";
	}

	public void deleteOpinionPoll(){
		PrintWriter pw = null;
        try{
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            String result; 
            if(theID != null && !theID.equals("")){
            	OpinionPollInfo opi = new OpinionPollInfo();
            	opi.setOpinionID(Integer.valueOf(theID));
            	List<OpinionPollInfo> list = opinionPollInfoServices.queryOpinionPollInfoListByBean(opi);
            	if(list != null && list.size() > 0){
            		result = "other";
            	}else{
	            	opinionPollService.deleteOpinionPoll(Integer.valueOf(theID));
	            	result = "success";
            	}
            }else{
            	result = "fail";
            }
            pw.write(result);
        }catch (Exception e){
            e.printStackTrace();
        }
        pw.flush();
        pw.close();
		
	}
	
	public void saveNewOpinionPoll(){
		PrintWriter pw = null;
		User user = (User)this.getRequest().getSession().getAttribute("userInSession");
		try{
			this.getResponse().setCharacterEncoding("UTF-8");
			pw = this.getResponse().getWriter();
			Map<String,Object> map = new HashMap<String,Object>();
			String result;
			OpinionPoll op = new OpinionPoll();
			op.setTitle(title);
			op.setStatus(status);
			op.setCreateDate(DateUtils.getNowTime());
			op.setBeginDate(beginDate);
			op.setEndDate(endDate);
			op.setCatalogID(Integer.valueOf(catalogID));
			op.setIsCollect(isCollect);
			op.setSummary(summary);
			op.setUserID(user.getId());
			op.setReleaseDate(releaseDate);
			opinionPollService.insertOpinionPoll(op);
			result = "success";
            map.put("result", result);
            String strMap = JSONObject.toJSONString(map);
            pw.write(strMap);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public void saveEditOpinionPoll(){
		PrintWriter pw = null;
		OpinionPoll op = new OpinionPoll();
		op.setTheID(Integer.valueOf(theID));
		op = opinionPollService.queryOpinionPollByBean(op);
		String result; 
		try{
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            op.setTitle(title);
            op.setSummary(summary);
            op.setStatus(status);
            op.setIsCollect(isCollect);
            op.setBeginDate(beginDate);
            op.setEndDate(endDate);
            op.setCatalogID(Integer.valueOf(catalogID));
            op.setReleaseDate(releaseDate);
            opinionPollService.updateOpinionPoll(op);
            result="success";
		}catch(Exception e){
			result = "error";
			e.printStackTrace();
		}
		pw.write(result);
        pw.flush();
        pw.close();
	}
	
	public OpinionPollServices getOpinionPollService() {
		return opinionPollService;
	}

	public void setOpinionPollService(OpinionPollServices opinionPollService) {
		this.opinionPollService = opinionPollService;
	}

	public CatalogServices getCatalogServices() {
		return catalogServices;
	}

	public void setCatalogServices(CatalogServices catalogServices) {
		this.catalogServices = catalogServices;
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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
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

	public String getIsCollect() {
		return isCollect;
	}

	public void setIsCollect(String isCollect) {
		this.isCollect = isCollect;
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

	public String getReleaseDate() {
		return releaseDate;
	}

	public void setReleaseDate(String releaseDate) {
		this.releaseDate = releaseDate;
	}

	public OpinionPollInfoServices getOpinionPollInfoServices() {
		return opinionPollInfoServices;
	}

	public void setOpinionPollInfoServices(
			OpinionPollInfoServices opinionPollInfoServices) {
		this.opinionPollInfoServices = opinionPollInfoServices;
	}
	
}
