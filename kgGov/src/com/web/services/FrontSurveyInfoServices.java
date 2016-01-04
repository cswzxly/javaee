package com.web.services;

import java.util.List;
import com.system.pojo.SurveyInfo;

public interface FrontSurveyInfoServices {

	public List<SurveyInfo> front_querySurveyInfo(String pID);
	
	public SurveyInfo front_querySurveyInfoByBean(int theID);
	
	public void front_updateSurveyInfo(SurveyInfo surveyInfo);
	
/*	public SurveyInfo querySurveyInfoByBean(int theID);
	
	public void insertSurveyInfo(SurveyInfo surveyInfo);
	
	public void updateSurveyInfo(SurveyInfo surveyInfo);

    public void deleteSurveyInfo(SurveyInfo surveyInfo);*/
	
}
