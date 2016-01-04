package com.web.action;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import com.system.action.BaseAction;
import com.system.pojo.Contents;
import com.system.pojo.FileInfo;
import com.system.pojo.Letter;
import com.system.pojo.OpinionPoll;
import com.system.pojo.OpinionPollInfo;
import com.system.pojo.Survey;
import com.system.pojo.SurveyInfo;
import com.system.utils.DateUtils;
import com.web.services.FrontContentsServices;
import com.web.services.FrontFileInfoServices;
import com.web.services.FrontLetterServices;
import com.web.services.FrontOpinionPollInfoServices;
import com.web.services.FrontOpinionPollServices;
import com.web.services.FrontSurveyInfoServices;
import com.web.services.FrontSurveyServices;
import com.web.utils.Arithmetic;

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
	
	@Resource(name="frontLetterServices")
	private FrontLetterServices frontLetterServices;
	
	@Resource(name="frontSurveyServices")
	private FrontSurveyServices frontSurveyServices;
	
	@Resource(name="frontSurveyInfoServices")
	private FrontSurveyInfoServices frontSurveyInfoServices;
	
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
			Arithmetic des = new Arithmetic();
			theID = des.getDesString(theID);
			OpinionPoll op = new OpinionPoll();
			op.setTheID(Integer.valueOf(theID));
			op.setStatus("1");
			op = frontOpinionPollServices.queryOpinionPollByBean(op);
			request.setAttribute("opinionPoll", op);
			request.setAttribute("flag", request.getParameter("flag"));
		}
		return SUCCESS;
	}
	
	public String front_queryContentsList() throws ParseException{
//		Contents contents = new Contents();
//		contents.setCatalogID(45);
//		List<Contents> list = frontContentsServices.queryContentsListByBean(contents);
//		request.setAttribute("list", list);
//		return SUCCESS;
		try{
			Arithmetic des = new Arithmetic();
			String nowDate = DateUtils.getServerDate();
			String passDate = DateUtils.getServerDate();
			
			String flag = request.getParameter("flag");
			
			OpinionPoll op = new OpinionPoll();
			op.setStatus("1");
			if(flag != null){
				flag = des.getDesString(flag);
				if(flag.equals("now")){
					op.setNowDate(nowDate);
					op.setPassDate(null);
				}else{
					op.setPassDate(passDate);
					op.setNowDate(null);
				}
			}
			List<OpinionPoll> list = frontOpinionPollServices.queryOpinionPollListByBean(op);
			for(int i = 0;i < list.size();i++){
				if(flag != null){
					list.get(i).setFlag(des.getEncString(flag));
				}else{
					String endDateStr = list.get(i).getEndDate();
					Date endDate = DateUtils.stringToDate(endDateStr);
					Date now = new Date();
					if(endDate.getTime() >= now.getTime()){
						list.get(i).setFlag(des.getEncString("now"));
					}else{
						list.get(i).setFlag(des.getEncString("old"));
					}
				}
				list.get(i).setDesId(des.getEncString(list.get(i).getTheID().toString()));
			}
			request.setAttribute("list", list);
			request.setAttribute("flag", flag);
		}catch(Exception e){
			e.printStackTrace();
		}
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
	 * 政民互动
	 * @return
	 */
	public String frontContentsPage(){
		logger.info(">>>>>>>>>>>>>>FrontContentsAction:frontContentsPage>>>>>>>>>>>>>>");
		try{
			Arithmetic des = new Arithmetic();
			logger.info(">>>>>>>>>>>>>>民意征集>>>>>>>>>>>>>>");
			OpinionPoll op = new OpinionPoll();
			op.setStatus("1");
			List<OpinionPoll> opList = frontOpinionPollServices.queryOpinionPollListByBean(op);
			for(int i = 0;i < opList.size();i++){
				String endDateStr = opList.get(i).getEndDate();
				Date endDate = DateUtils.stringToDate(endDateStr);
				Date now = new Date();
				if(endDate.getTime() >= now.getTime()){
					opList.get(i).setFlag(des.getEncString("now"));
				}else{
					opList.get(i).setFlag(des.getEncString("old"));
				}
				opList.get(i).setDesId(des.getEncString(opList.get(i).getTheID().toString()));
			}
			request.setAttribute("opList", opList);
			
			logger.info(">>>>>>>>>>>>>>局长信箱>>>>>>>>>>>>>>");
			Letter jzxx = new Letter();
			jzxx.setFlag("1");
			jzxx.setIsOpen("1");
			List<Letter> jzxxList = frontLetterServices.frontLetterDetail(jzxx);
			if(jzxxList != null && jzxxList.size() > 0){
				for(Letter letter : jzxxList){
					letter.setDesId(des.getEncString(letter.getTheID().toString()));
				}
			}
			request.setAttribute("jzxxList", jzxxList);
			
			logger.info(">>>>>>>>>>>>>>业务咨询>>>>>>>>>>>>>>");
			Letter ywzx = new Letter();
			ywzx.setFlag("2");
			ywzx.setIsOpen("1");
			List<Letter> ywzxList = frontLetterServices.frontLetterDetail(ywzx);
			if(ywzxList != null && ywzxList.size() > 0){
				for(Letter letter : ywzxList){
					letter.setDesId(des.getEncString(letter.getTheID().toString()));
				}
			}
			request.setAttribute("ywzxList", ywzxList);
			
			logger.info(">>>>>>>>>>>>>>监督投诉>>>>>>>>>>>>>>");
			Letter jdts = new Letter();
			jdts.setFlag("3");
			jdts.setIsOpen("1");
			List<Letter> jdtsList = frontLetterServices.frontLetterDetail(jdts);
			if(jdtsList != null && jdtsList.size() > 0){
				for(Letter letter : jdtsList){
					letter.setDesId(des.getEncString(letter.getTheID().toString()));
				}
			}
			request.setAttribute("jdtsList", jdtsList);
			
//			logger.info(">>>>>>>>>>>>>>网络调查>>>>>>>>>>>>>>");
//	        Survey s = new Survey();
//	        s.setStatus("1");
//	        List<Survey> surveyList = frontSurveyServices.front_queryAllSurveyList(s);
//	        Iterator<Survey> it = surveyList.iterator();
//	        List<Survey> sl = new ArrayList<Survey>();
//	        while (it.hasNext()) {
//	            Survey survey = (Survey) it.next();
//	            List<SurveyInfo> listInfo = frontSurveyInfoServices.front_querySurveyInfo(survey.getTheID().toString());
//	            if (listInfo.size() < 1) {
//	                sl.add(survey);
//	            }
//	        }
//	        surveyList.removeAll(sl);
//	        if(surveyList != null && surveyList.size() > 0){
//	        	for(Survey su : surveyList){
//	        		su.setDesId(des.getEncString(su.getTheID().toString()));
//	        	}
//	        }
//	        request.setAttribute("surveyList", surveyList);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return "page";
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
