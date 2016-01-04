package com.system.mappers;

import java.util.List;

import com.system.bean.AllClassBean;
import com.system.pojo.OpinionPoll;

/**
 * @author hchch
 *
 * 2014年11月3日
 */
public interface OpinionPollMapper {
	
	public OpinionPoll queryOpinionPollByBean(OpinionPoll opinionPoll);
	
	public List<OpinionPoll> queryAllOpinionPollList();
	
	public void insertOpinionPoll(OpinionPoll opinionPoll);

	public void updateOpinionPoll(OpinionPoll opinionPoll);
	
	public void deleteOpinionPoll(Integer theID);
	
	public List<AllClassBean> getOpinionPollListByBean(AllClassBean bean);
	
}
