package com.system.action;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.alibaba.fastjson.JSONObject;
import com.system.pojo.Survey;
import com.system.pojo.SurveyInfo;
import com.system.pojo.User;
import com.system.services.SurveyInfoServices;
import com.system.utils.DateUtils;

public class SurveyInfoAction extends BaseAction {

	private static final long serialVersionUID = 1L;
	
	@Resource(name="surveyInfoServices")
	private SurveyInfoServices surveyInfoServices;
	
	/**
	 * 
	 * 网上调查列表
	 */	
	
	public String surveyInfoPage(){
		String pID = request.getParameter("pID");
		request.setAttribute("pID", pID);
		return "success";
	}
	
	public void queryAllSurveyInfoList(){
		logger.info(">>>>>>>>>>>>>>>>>pID="+request.getParameter("pID"));
		PrintWriter pw = null;
        try{
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            Map<String,Object> map = new HashMap<String, Object>();
            List<SurveyInfo> listSurveyInfo = null;
            String pID = request.getParameter("pID");
    		listSurveyInfo = surveyInfoServices.queryAllSurveyInfoList(pID);
    		request.setAttribute("pID", pID);
            map.put("total",listSurveyInfo.size());
            map.put("rows",listSurveyInfo);
            String result = JSONObject.toJSONString(map);
            pw.write(result);
        }catch (Exception e){
            e.printStackTrace();
        }
        pw.flush();
        pw.close();
	}
	
	public void saveNewSurveyInfo(){
		PrintWriter pw = null;
        try{
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
			String pID = request.getParameter("pID");
			String content = request.getParameter("content");
			String status = request.getParameter("status");
			User user = (User)this.getRequest().getSession().getAttribute("userInSession");
			SurveyInfo surveyInfo = new SurveyInfo();
			surveyInfo.setpID(pID);
			surveyInfo.setContent(content);
			surveyInfo.setStatus(status);
			surveyInfo.setTheDate(DateUtils.getNowTime());
			surveyInfo.setUserID(user.getId());
			surveyInfo.setCount("0");
			surveyInfoServices.insertSurveyInfo(surveyInfo);
			String result;
			result = "success";
			pw.write(result);
        }catch (Exception e){
        	e.printStackTrace();
        }
        pw.flush();
        pw.close();
	}
	
	public void saveEditSurveyInfo(){
		PrintWriter pw = null;
        try{
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            String result;
			int theID = Integer.valueOf(request.getParameter("theID"));
			Integer pID = Integer.valueOf(request.getParameter("pID"));
			SurveyInfo si = surveyInfoServices.querySurveyInfoByBean(theID);
			if(si!=null){
				si.setContent(request.getParameter("content"));
				si.setStatus(request.getParameter("status"));
				surveyInfoServices.updateSurveyInfo(si);
				request.setAttribute("pID", pID);
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

    public void deleteSurveyInfo(){
    	 PrintWriter pw = null;
         try{
             this.getResponse().setCharacterEncoding("UTF-8");
             pw = this.getResponse().getWriter();
             String result;
             logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>theID"+request.getParameter("theID"));
             int theID = Integer.valueOf(request.getParameter("theID"));
             SurveyInfo s = surveyInfoServices.querySurveyInfoByBean(theID);
             if(s!=null){
                 this.surveyInfoServices.deleteSurveyInfo(s);
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
}
