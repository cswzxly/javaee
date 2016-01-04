package com.web.mappers;

import java.util.List;
import com.system.pojo.SurveyInfo;

public interface FrontSurveyInfoMapper {
	

    public List<SurveyInfo> front_querySurveyInfo(String pID);
    
    public void front_updateSurveyInfo(SurveyInfo surveyInfo);
    
    public SurveyInfo front_querySurveyInfoByBean(int theID);
    
/*    ;
    
    public void insertSurveyInfo(SurveyInfo surveyInfo);
    
    public void updateSurveyInfo(SurveyInfo surveyInfo);

    public void deleteSurveyInfo(SurveyInfo surveyInfo);*/

}
