package com.web.services;

import org.springframework.stereotype.Service;

import com.system.pojo.OpinionPollInfo;
import com.web.mappers.FrontOpinionPollInfoMapper;

/**
 * @author hchch
 *
 * 2014年11月7日
 */
@Service("frontOpinionPollInfoServices")
public class FrontOpinionPollInfoServicesImpl implements FrontOpinionPollInfoServices{

	private FrontOpinionPollInfoMapper frontOpinionPollInfoMapper;
	
	@Override
	public void insertOpinionPollInfo(OpinionPollInfo opinionPollInfo) {
		frontOpinionPollInfoMapper.insertOpinionPollInfo(opinionPollInfo);
	}

	public FrontOpinionPollInfoMapper getFrontOpinionPollInfoMapper() {
		return frontOpinionPollInfoMapper;
	}

	public void setFrontOpinionPollInfoMapper(FrontOpinionPollInfoMapper frontOpinionPollInfoMapper) {
		this.frontOpinionPollInfoMapper = frontOpinionPollInfoMapper;
	}

	
}
