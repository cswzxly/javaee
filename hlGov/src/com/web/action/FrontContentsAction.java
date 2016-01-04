package com.web.action;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import com.system.action.BaseAction;
import com.system.pojo.Contents;
import com.system.pojo.OpinionPoll;
import com.system.pojo.OpinionPollInfo;
import com.system.utils.DateUtils;
import com.web.services.FrontContentsServices;
import com.web.services.FrontFileInfoServices;
import com.web.services.FrontOpinionPollInfoServices;
import com.web.services.FrontOpinionPollServices;
import com.web.utils.PropertiesUtils;

public class FrontContentsAction extends BaseAction {

	private static final long serialVersionUID = 1L;
	
	@Resource(name="frontContentsServices")
	private FrontContentsServices frontContentsServices;	
	
	@Resource(name="frontFileInfoServices")
	private FrontFileInfoServices frontFileInfoServices;
	
	@Resource(name="frontOpinionPollServices")
	private FrontOpinionPollServices frontOpinionPollServices;
	
	@Resource(name="frontOpinionPollInfoServices")
	private FrontOpinionPollInfoServices frontOpinionPollInfoServices;
	
	private String name;
	private String email;
	private String phone;
	private String contents;
	private Integer opinionID;

	public String front_queryContentsDetail(){
		logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>theID="+request.getParameter("theID"));
//		int theID = Integer.valueOf(request.getParameter("theID"));
//		Contents contents = new Contents();
//		contents.setTheID(theID);
//		Contents c = frontContentsServices.queryContentsByBean(contents);
//		request.setAttribute("contents", c);
//		FileInfo fileInfo = new FileInfo();
//		fileInfo.setContentID(theID);
//		List<FileInfo> fileInfoList = frontFileInfoServices.front_fileInfoList(fileInfo);
//		request.setAttribute("fileInfoList", fileInfoList);
//		request.setAttribute("title", request.getParameter("title"));
//		request.setAttribute("theID", theID);
		String theID = request.getParameter("theID");
		
		if(theID != null && !"".equals(theID)){
			OpinionPoll op = new OpinionPoll();
			op.setTheID(Integer.valueOf(theID));
			op.setStatus("1");
			op = frontOpinionPollServices.queryOpinionPollByBean(op);
			request.setAttribute("opinionPoll", op);
			request.setAttribute("flag", request.getParameter("flag"));
		}
		return SUCCESS;
	}
	
	public String front_queryContentsList(){
//		Contents contents = new Contents();
//		contents.setCatalogID(45);
//		List<Contents> list = frontContentsServices.queryContentsListByBean(contents);
//		request.setAttribute("list", list);
		
		String nowDate = DateUtils.getServerDate();
		String passDate = DateUtils.getServerDate();
		
		String flag = request.getParameter("flag");
		
		OpinionPoll op = new OpinionPoll();
		op.setStatus("1");
		if(flag != null){
			if(flag.equals("now")){
				op.setNowDate(nowDate);
				op.setPassDate(null);
			}else{
				op.setPassDate(passDate);
				op.setNowDate(null);
			}
		}
		List<OpinionPoll> list = frontOpinionPollServices.queryOpinionPollListByBean(op);
		
		request.setAttribute("list", list);
		request.setAttribute("flag", flag);
		return SUCCESS;
	}
	
	public String front_saveOpinionPollInfo(){
		if(opinionID != null){
			OpinionPollInfo opi = new OpinionPollInfo();
			opi.setName(name);
			opi.setPhone(phone);
			opi.setEmail(email);
			opi.setCreateDate(DateUtils.getNowTime());
			opi.setIp(request.getRemoteAddr());
			opi.setContents(contents);
			opi.setOpinionID(opinionID);
			frontOpinionPollInfoServices.insertOpinionPollInfo(opi);
			return "success";
		}
		return "success";
	}
	
	/**
	 * 投诉建议
	 * @return
	 */
	public String tsjyPage(){
		
		String path = request.getSession().getServletContext().getRealPath("/");
		String propertiesPath = path + "WEB-INF/classes/web_index.properties";
		String value = PropertiesUtils.readValue(propertiesPath, "tsjyCatalogID");
		
		Contents temp = new Contents();
		temp.setStatus("1");
		temp.setCatalogID(Integer.valueOf(value));
		List<Contents> tsjyList = frontContentsServices.queryContentsListByBean(temp);
		request.setAttribute("tsjyList", tsjyList);
		
		return "tsjyPage";
	}
	
	public String tsjyDetailPage(){
		
		String theID = request.getParameter("theID");
		Contents temp = new Contents();
		temp.setTheID(Integer.valueOf(theID));
		temp = frontContentsServices.queryContentsByBean(temp);
		request.setAttribute("contentsDetail", temp);
		
		return "tsjyDetailPage";
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public Integer getOpinionID() {
		return opinionID;
	}

	public void setOpinionID(Integer opinionID) {
		this.opinionID = opinionID;
	}
	
}
