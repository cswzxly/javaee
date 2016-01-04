package com.web.mappers;

import java.util.List;

import com.system.pojo.OpinionPoll;

/**
 * @author hchch
 *
 * 2014年11月7日
 */
public interface FrontOpinionPollMapper {
	
	public List<OpinionPoll> queryOpinionPollListByBean(OpinionPoll opinionPoll);
	
	public OpinionPoll queryOpinionPollByBean(OpinionPoll opinionPoll);
	
}
