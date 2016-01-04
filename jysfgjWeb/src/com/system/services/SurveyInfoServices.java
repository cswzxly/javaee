package com.system.services;

import java.util.List;
import com.system.pojo.SurveyInfo;

public interface SurveyInfoServices {

	public List<SurveyInfo> queryAllSurveyInfoList(String pID);
	
	public SurveyInfo querySurveyInfoByBean(int theID);
	
	public void insertSurveyInfo(SurveyInfo surveyInfo);
	
	public void updateSurveyInfo(SurveyInfo surveyInfo);

    public void deleteSurveyInfo(SurveyInfo surveyInfo);
	
}
