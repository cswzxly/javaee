package com.web.services;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.system.pojo.OpinionPoll;

/**
 * @author hchch
 *
 * 2014年11月7日
 */
@Transactional
public interface FrontOpinionPollServices {

	public List<OpinionPoll> queryOpinionPollListByBean(OpinionPoll opinionPoll);
	
	public OpinionPoll queryOpinionPollByBean(OpinionPoll opinionPoll);
	
}
