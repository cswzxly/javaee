package com.system.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.system.bean.AllClassBean;
import com.system.mappers.OpinionPollMapper;
import com.system.pojo.OpinionPoll;

/**
 * @author hchch
 *
 * 2014年11月3日
 */
@Service("opinionPollServices")
public class OpinionPollServicesImpl implements OpinionPollServices{
	
	private OpinionPollMapper opinionPollMapper;

	@Override
	public OpinionPoll queryOpinionPollByBean(OpinionPoll opinionPoll) {
		return opinionPollMapper.queryOpinionPollByBean(opinionPoll);
	}

	@Override
	public List<OpinionPoll> queryAllOpinionPollList() {
		return opinionPollMapper.queryAllOpinionPollList();
	}

	@Override
	public void insertOpinionPoll(OpinionPoll opinionPoll) {
		opinionPollMapper.insertOpinionPoll(opinionPoll);
	}

	@Override
	public void updateOpinionPoll(OpinionPoll opinionPoll) {
		opinionPollMapper.updateOpinionPoll(opinionPoll);
	}

	@Override
	public void deleteOpinionPoll(Integer theID) {
		opinionPollMapper.deleteOpinionPoll(theID);
	}

	@Override
	public List<AllClassBean> getOpinionPollListByBean(AllClassBean bean) {
		return opinionPollMapper.getOpinionPollListByBean(bean);
	}

	public OpinionPollMapper getOpinionPollMapper() {
		return opinionPollMapper;
	}

	public void setOpinionPollMapper(OpinionPollMapper opinionPollMapper) {
		this.opinionPollMapper = opinionPollMapper;
	}
	
	

}
