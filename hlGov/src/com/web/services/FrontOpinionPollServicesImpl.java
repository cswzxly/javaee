package com.web.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.system.pojo.OpinionPoll;
import com.web.mappers.FrontOpinionPollMapper;
/**
 * @author hchch
 *
 * 2014年11月7日
 */
@Service("frontOpinionPollServices")
public class FrontOpinionPollServicesImpl implements FrontOpinionPollServices{

	private FrontOpinionPollMapper frontOpinionPollMapper;
	
	@Override
	public List<OpinionPoll> queryOpinionPollListByBean(OpinionPoll opinionPoll) {
		return frontOpinionPollMapper.queryOpinionPollListByBean(opinionPoll);
	}

	@Override
	public OpinionPoll queryOpinionPollByBean(OpinionPoll opinionPoll) {
		return frontOpinionPollMapper.queryOpinionPollByBean(opinionPoll);
	}
	
	public FrontOpinionPollMapper getFrontOpinionPollMapper() {
		return frontOpinionPollMapper;
	}

	public void setFrontOpinionPollMapper(
			FrontOpinionPollMapper frontOpinionPollMapper) {
		this.frontOpinionPollMapper = frontOpinionPollMapper;
	}

	
	
}
