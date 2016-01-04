package com.system.mappers;

import java.util.List;
import com.system.pojo.Survey;

public interface SurveyMapper {
	

    public List<Survey> queryAllSurveyList();
    
    public Survey querySurveyByBean(int theID);
    
    public void insertSurvey(Survey survey);
    
    public void updateSurvey(Survey survey);

    public void deleteSurvey(Survey survey);

}
