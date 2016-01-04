package com.web.action;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import com.system.action.BaseAction;
import com.system.pojo.Survey;
import com.system.pojo.SurveyInfo;
import com.system.utils.DateUtils;
import com.web.services.FrontSurveyInfoServices;
import com.web.services.FrontSurveyServices;

public class FrontSurveyInfoAction extends BaseAction {

	private static final long serialVersionUID = 1L;
	
	@Resource(name="frontSurveyServices")
	private FrontSurveyServices frontSurveyServices;
	
	@Resource(name="frontSurveyInfoServices")
	private FrontSurveyInfoServices frontSurveyInfoServices;
	
	/**
	 * 前台-网上投票-显示内容列表
	 * 
	 */	
	public String front_querySurveyInfo(){
		String theID = request.getParameter("theID");
		Survey s = frontSurveyServices.front_querySurveyByBean(Integer.valueOf(theID));
		String endDate = s.getEndDate();
		String nowDate = DateUtils.getNowTime().substring(0, 9);
		int result = endDate.compareTo(nowDate);
		if(result<0){
			logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>往期调查");
			request.setAttribute("Ccount", 1);
		}else{
			logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>正在调查");
		}
		List<SurveyInfo> listSurveyInfo = new ArrayList<SurveyInfo>();		
		listSurveyInfo = frontSurveyInfoServices.front_querySurveyInfo(theID);
		request.setAttribute("list", listSurveyInfo);
		request.setAttribute("title", s.getTitle());
		request.setAttribute("theDate", s.getTheDate());
		request.setAttribute("pId", s.getTheID());
		String count = request.getParameter("count");
		if(count!=null&&!"".equals(count)){
			request.setAttribute("count", count);
		}		
		request.setAttribute("index", request.getParameter("index"));
		return "success";		
	}
	
	/**
	 * 前台-网上投票-保存投票信息
	 * 
	 */
	public String front_updateSurveyInfo(){		
		SurveyInfo sf = new SurveyInfo();
		String id = request.getParameter("theID");
		if(id!=null&&!"".equals(id)){
			int theID = Integer.valueOf(id); //获取theID
			logger.info(">>>>>>>>>>>>>>>>>>>>>>>>theID="+theID);
			sf = frontSurveyInfoServices.front_querySurveyInfoByBean(theID);
			int count = Integer.valueOf(sf.getCount())+1; //更新点击次数		
			SurveyInfo surveyInfo = new SurveyInfo();
			surveyInfo.setTheID(theID);		
			surveyInfo.setCount(Integer.toString(count));
			frontSurveyInfoServices.front_updateSurveyInfo(surveyInfo);	
			request.setAttribute("pId", request.getParameter("pId"));
		}
		return "success";
	}
	
	/**
	 * 根据调查id获取当前调查结果
	 * @return
	 */
	public String front_querySurveyResult(){
		String id = request.getParameter("id");
		if(id != null && !"".equals(id)){
			Integer theID = Integer.valueOf(id);
			Survey s = frontSurveyServices.front_querySurveyByBean(Integer.valueOf(theID));
			List<SurveyInfo> listSurveyInfo = new ArrayList<SurveyInfo>();		
			listSurveyInfo = frontSurveyInfoServices.front_querySurveyInfo(theID.toString());
			request.setAttribute("survey", s);
			request.setAttribute("list", listSurveyInfo);
			
		}
		return "success";
	}
}
