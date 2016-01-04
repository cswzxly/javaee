package com.system.action;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.fastjson.JSONObject;
import com.system.pojo.OpinionPoll;
import com.system.pojo.OpinionPollInfo;
import com.system.services.OpinionPollInfoServices;
import com.system.services.OpinionPollServices;

/**
 * @author hchch
 *
 * 2014年11月4日
 */
public class OpinionPollInfoAction extends BaseAction{

	@Autowired
	private OpinionPollInfoServices opinionPollInfoServices;
	@Autowired
	private OpinionPollServices opinionPollServices;
	
	private String theID;
	private String opinionID;
	private String name;
	private String phone;
	private String email;
	private String contents;
	private String ip;
	
	/**
	 * @return
	 */
	public String opinionPollInfoPage(){
		OpinionPoll op = new OpinionPoll();
		op.setTheID(Integer.valueOf(opinionID));
		op = opinionPollServices.queryOpinionPollByBean(op);
		request.setAttribute("opinionPoll", op);
		return "page";
	}
	
	/**
	 * 
	 */
	public void opinionPollInfoList(){
		PrintWriter pw = null;
		try{
			this.getResponse().setCharacterEncoding("UTF-8");
			pw = this.getResponse().getWriter();
	    	OpinionPollInfo opi = new OpinionPollInfo();
	 		opi.setOpinionID(Integer.valueOf(opinionID));
	 		List<OpinionPollInfo> list = new ArrayList<OpinionPollInfo>();
	 		list = opinionPollInfoServices.queryOpinionPollInfoListByBean(opi);
	 		Map<String,Object> map = new HashMap<String, Object>();
	 		map.put("total", list.size());
	 		map.put("rows", list);
	 		String result = JSONObject.toJSONString(map);
	 		pw.write(result);
	     }catch(Exception e){
	    	 e.printStackTrace();
	     }
	     pw.flush();
	     pw.close();
		
	}
	
	/**
	 * @return
	 */
	public String showOpinionPollInfo(){
		String theID = request.getParameter("theID");
		OpinionPollInfo opi = new OpinionPollInfo();
		opi.setTheID(Integer.valueOf(theID));
		opi = opinionPollInfoServices.queryOpinionPollInfoByBean(opi);
		request.setAttribute("opinionPollInfo", opi);
		
		OpinionPoll op = new OpinionPoll();
		op.setTheID(opi.getOpinionID());
		op = opinionPollServices.queryOpinionPollByBean(op);
		request.setAttribute("opinionPoll", op);
		return "show";
	}
	
	public void deleteOpinionPollInfo(){
		PrintWriter pw = null;
        try{
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            String result; 
            if(theID != null && !theID.equals("")){
            	opinionPollInfoServices.deleteOpinionPollInfo(Integer.valueOf(theID));
            	result = "success";
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
	
	public OpinionPollInfoServices getOpinionPollInfoServices() {
		return opinionPollInfoServices;
	}
	public void setOpinionPollInfoServices(
			OpinionPollInfoServices opinionPollInfoServices) {
		this.opinionPollInfoServices = opinionPollInfoServices;
	}
	public OpinionPollServices getOpinionPollServices() {
		return opinionPollServices;
	}
	public void setOpinionPollServices(OpinionPollServices opinionPollServices) {
		this.opinionPollServices = opinionPollServices;
	}
	public String getTheID() {
		return theID;
	}
	public void setTheID(String theID) {
		this.theID = theID;
	}
	public String getOpinionID() {
		return opinionID;
	}
	public void setOpinionID(String opinionID) {
		this.opinionID = opinionID;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	
}
