package com.system.services;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.system.mappers.SurveyMapper;
import com.system.pojo.Survey;

@Service("surveyServices")
public class SurveyServicesImpl implements SurveyServices{

	@Resource(name="surveyMapper")
	private SurveyMapper surveyMapper;
	
	@Override
	public List<Survey> queryAllSurveyList() {
		// TODO Auto-generated method stub
		return surveyMapper.queryAllSurveyList();
	}

	@Override
	public void insertSurvey(Survey survey) {
		// TODO Auto-generated method stub
		surveyMapper.insertSurvey(survey);
	}

	@Override
	public Survey querySurveyByBean(int theID) {
		// TODO Auto-generated method stub
		return surveyMapper.querySurveyByBean(theID);
	}

	@Override
	public void updateSurvey(Survey survey) {
		// TODO Auto-generated method stub
		surveyMapper.updateSurvey(survey);
	}

	@Override
	public void deleteSurvey(Survey survey) {
		// TODO Auto-generated method stub
		surveyMapper.deleteSurvey(survey);
	}

}
