package com.system.services;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.system.mappers.SurveyInfoMapper;
import com.system.pojo.SurveyInfo;

@Service("surveyInfoServices")
public class SurveyInfoServicesImpl implements SurveyInfoServices{

	@Resource(name="surveyInfoMapper")
	private SurveyInfoMapper surveyInfoMapper;
	
	@Override
	public List<SurveyInfo> queryAllSurveyInfoList(String pID) {
		// TODO Auto-generated method stub
		return surveyInfoMapper.queryAllSurveyInfoList(pID);
	}

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

}
