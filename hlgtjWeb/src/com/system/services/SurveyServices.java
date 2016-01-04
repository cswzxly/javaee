package com.system.services;

import java.util.List;

import com.system.pojo.Survey;

public interface SurveyServices {

	public List<Survey> queryAllSurveyList();
	
	public Survey querySurveyByBean(int theID);
	
	public void insertSurvey(Survey survey);
	
	public void updateSurvey(Survey survey);

    public void deleteSurvey(Survey survey);
	
}
