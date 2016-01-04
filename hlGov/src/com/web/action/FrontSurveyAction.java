package com.web.action;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import com.system.action.BaseAction;
import com.system.pojo.Survey;
import com.system.pojo.SurveyInfo;
import com.system.utils.DateUtils;
import com.web.services.FrontSurveyInfoServices;
import com.web.services.FrontSurveyServices;

public class FrontSurveyAction extends BaseAction {

	private static final long serialVersionUID = 1L;
	
	@Resource(name="frontSurveyServices")
	private FrontSurveyServices frontSurveyServices;
	
	@Resource(name="frontSurveyInfoServices")
	private FrontSurveyInfoServices frontSurveyInfoServices;
	
	/**
	 * 
	 * 
	 */	
	
	public void front_queryAllSurveyList(){
		List<Survey> list = null;
		Survey s = new Survey();
		s.setStatus("1");
		list = frontSurveyServices.front_queryAllSurveyList(s);
		Iterator<Survey> it = list.iterator();
		List<Survey> sl = new ArrayList<Survey>();
		while(it.hasNext()){
			Survey survey = (Survey)it.next();
			List<SurveyInfo> listInfo = frontSurveyInfoServices.front_querySurveyInfo(survey.getTheID().toString());
			if(listInfo.size()<1){
				sl.add(survey);
			}
		}
		list.removeAll(sl);
		request.setAttribute("list", list);		
	}
	
	public String front_querySurveyListDetail(){
		String index = request.getParameter("index");
		String nowDate = DateUtils.getNowTime().substring(0, 9);
		List<Survey> listSurvey = new ArrayList<Survey>();
		List<Survey> listSurvey1 = new ArrayList<Survey>(); //正在调查
		List<Survey> listSurvey2 = new ArrayList<Survey>(); //以往调查
		Survey s = new Survey();
		s.setStatus("1");
		listSurvey = frontSurveyServices.front_queryAllSurveyList(s);
		Iterator<Survey> it = listSurvey.iterator();
		while(it.hasNext()){
			Survey survey = (Survey)it.next();
			String endDate = survey.getEndDate();
			int result = endDate.compareTo(nowDate);
			if(result>=0){
				logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>往期调查");
				String pID = survey.getTheID().toString();
				List<SurveyInfo> listInfo = frontSurveyInfoServices.front_querySurveyInfo(pID);
				if(listInfo.size()<1){
					listSurvey1.remove(survey);
				}else{
					listSurvey1.add(survey);
				}				
			}else{
				logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>正在调查");
				String pID = survey.getTheID().toString();
				List<SurveyInfo> listInfo = frontSurveyInfoServices.front_querySurveyInfo(pID);
				if(listInfo.size()<1){
					listSurvey2.remove(survey);
				}else{
					listSurvey2.add(survey);
				}
			}
		}
		if(index.equals("1")){ //正在调查
			request.setAttribute("list1", listSurvey1);
		}else if(index.equals("0")){ //以往调查
			request.setAttribute("list0", listSurvey2);
		}
		request.setAttribute("index", index);
		return "success";
	}
	
	public String front_querySurveyByBean(){
		String index = request.getParameter("index");
		int theID = Integer.valueOf(request.getParameter("theID"));
		Survey s = new Survey();
		s = frontSurveyServices.front_querySurveyByBean(theID);
		request.setAttribute("list", s);
		request.setAttribute("flag", "1");
		return "success";
	}
	
	/*public String surveyPage(){
		return "success";
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
    }    */
}
