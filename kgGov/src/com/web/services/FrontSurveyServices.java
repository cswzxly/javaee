package com.web.services;

import java.util.List;

import com.system.pojo.Survey;

public interface FrontSurveyServices {

	public List<Survey> front_queryAllSurveyList(Survey survey);
	
	public Survey front_querySurveyByBean(int theID);
	
	/*
	
	public void insertSurvey(Survey survey);
	
	public void updateSurvey(Survey survey);

    public void deleteSurvey(Survey survey);*/
	
}
