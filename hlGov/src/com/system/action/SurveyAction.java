package com.system.action;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.alibaba.fastjson.JSONObject;
import com.system.pojo.Survey;
import com.system.pojo.User;
import com.system.services.SurveyServices;
import com.system.utils.DateUtils;

public class SurveyAction extends BaseAction {

	private static final long serialVersionUID = 1L;
	
	@Resource(name="surveyServices")
	private SurveyServices surveyServices;
	
	/**
	 * 
	 * 网上调查列表
	 */	
	
	public String surveyPage(){
		return "success";
	}
	
	public void queryAllSurveyList(){
		PrintWriter pw = null;
        try{
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            Map<String,Object> map = new HashMap<String, Object>();
            List<Survey> listSurvey = null;
    		listSurvey = surveyServices.queryAllSurveyList();
    		Iterator it = listSurvey.iterator();
    		while(it.hasNext()){
    			Survey s = (Survey)it.next();
    			if(s.getStatus().equals("1")){
    				s.setStatus("启用");
    			}else{
    				s.setStatus("停用");
    			}    			
    		}
            map.put("total",listSurvey.size());
            map.put("rows",listSurvey);
            String result = JSONObject.toJSONString(map);
            pw.write(result);
        }catch (Exception e){
            e.printStackTrace();
        }
        pw.flush();
        pw.close();
	}
	
	public void saveNewSurvey(){
		PrintWriter pw = null;
        try{
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
			String title = request.getParameter("title");
			String summary = request.getParameter("summary");
			String beginDate = request.getParameter("beginDate");
			String endDate = request.getParameter("endDate");
			String status = request.getParameter("status");
			User user = (User)this.getRequest().getSession().getAttribute("userInSession");
			Survey survey = new Survey();
			survey.setTitle(title);
			survey.setSummary(summary);
			survey.setBeginDate(beginDate);
			survey.setEndDate(endDate);
			survey.setTheDate(DateUtils.getNowTime());
			survey.setStatus(status);
			survey.setUserID(user.getId());
			surveyServices.insertSurvey(survey);
			String result;
			result = "success";
			pw.write(result);
        }catch (Exception e){
        	e.printStackTrace();
        }
        pw.flush();
        pw.close();
	}
	
	public void saveEditSurvey(){
		PrintWriter pw = null;
        try{
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            String result;
			Integer theID = Integer.valueOf(request.getParameter("theID"));
			Survey s = surveyServices.querySurveyByBean(theID);
			if(s!=null){
				s.setTitle(request.getParameter("title"));
				s.setSummary(request.getParameter("summary"));
				s.setBeginDate(request.getParameter("beginDate"));
				s.setEndDate(request.getParameter("endDate"));
				s.setStatus(request.getParameter("status"));
				surveyServices.updateSurvey(s);
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

    public void deleteSurvey(){
    	 PrintWriter pw = null;
         try{
             this.getResponse().setCharacterEncoding("UTF-8");
             pw = this.getResponse().getWriter();
             String result;
             int theID = Integer.valueOf(request.getParameter("theID"));
             Survey s = surveyServices.querySurveyByBean(theID);
             if(s!=null){
                 this.surveyServices.deleteSurvey(s);
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
