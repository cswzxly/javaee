package com.web.services;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.system.pojo.Survey;
import com.web.mappers.FrontSurveyMapper;

@Service("frontSurveyServices")
public class FrontSurveyServicesImpl implements FrontSurveyServices{

	@Resource(name="frontSurveyMapper")
	private FrontSurveyMapper frontSurveyMapper;

	@Override
	public List<Survey> front_queryAllSurveyList(Survey survey) {
		// TODO Auto-generated method stub
		return frontSurveyMapper.front_queryAllSurveyList(survey);
	}

	@Override
	public Survey front_querySurveyByBean(int theID) {
		// TODO Auto-generated method stub
		return frontSurveyMapper.front_querySurveyByBean(theID);
	}
	
	
}
