package com.web.services;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.system.pojo.SurveyInfo;
import com.web.mappers.FrontSurveyInfoMapper;


@Service("frontSurveyInfoServices")
public class FrontSurveyInfoServicesImpl implements FrontSurveyInfoServices{

	@Resource(name="frontSurveyInfoMapper")
	private FrontSurveyInfoMapper frontSurveyInfoMapper;
	
	@Override
	public List<SurveyInfo> front_querySurveyInfo(String pID) {
		// TODO Auto-generated method stub
		return frontSurveyInfoMapper.front_querySurveyInfo(pID);
	}
	
	@Override
	public SurveyInfo front_querySurveyInfoByBean(int theID) {
		// TODO Auto-generated method stub
		return frontSurveyInfoMapper.front_querySurveyInfoByBean(theID);
	}
	
	public void front_updateSurveyInfo(SurveyInfo surveyInfo){
		frontSurveyInfoMapper.front_updateSurveyInfo(surveyInfo);
	}
/*
	@Override
	public void insertSurveyInfo(SurveyInfo surveyInfo) {
		// TODO Auto-generated method stub
		surveyInfoMapper.insertSurveyInfo(surveyInfo);
	}

	@Override
	public SurveyInfo querySurveyInfoByBean(int theID) {
		// TODO Auto-generated method stub
		return surveyInfoMapper.querySurveyInfoByBean(theID);
	}

	@Override
	public void updateSurveyInfo(SurveyInfo surveyInfo) {
		// TODO Auto-generated method stub
		surveyInfoMapper.updateSurveyInfo(surveyInfo);
	}

	@Override
	public void deleteSurveyInfo(SurveyInfo surveyInfo) {
		// TODO Auto-generated method stub
		surveyInfoMapper.deleteSurveyInfo(surveyInfo);
	}
*/

	
}
