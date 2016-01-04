package com.system.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.system.bean.AllClassBean;
import com.system.mappers.OpinionPollInfoMapper;
import com.system.pojo.OpinionPollInfo;

/**
 * @author hchch
 *
 * 2014年11月4日
 */
@Service("opinionPollInfoServices")
public class OpinionPollInfoServicesImpl implements OpinionPollInfoServices{
	
	private OpinionPollInfoMapper opinionPollInfoMapper;

	@Override
	public OpinionPollInfo queryOpinionPollInfoByBean(OpinionPollInfo opinionPollInfo) {
		return opinionPollInfoMapper.queryOpinionPollInfoByBean(opinionPollInfo);
	}

	@Override
	public List<OpinionPollInfo> queryAllOpinionPollInfoList() {
		return opinionPollInfoMapper.queryAllOpinionPollInfoList();
	}

	@Override
	public void insertOpinionPollInfo(OpinionPollInfo opinionPollInfo) {
		opinionPollInfoMapper.insertOpinionPollInfo(opinionPollInfo);
	}

	@Override
	public void updateOpinionPollInfo(OpinionPollInfo opinionPollInfo) {
		opinionPollInfoMapper.updateOpinionPollInfo(opinionPollInfo);
	}

	@Override
	public void deleteOpinionPollInfo(Integer theID) {
		opinionPollInfoMapper.deleteOpinionPollInfo(theID);
	}

	@Override
	public List<AllClassBean> getOpinionPollInfoListByBean(AllClassBean bean) {
		return opinionPollInfoMapper.getOpinionPollInfoListByBean(bean);
	}
	
	@Override
	public List<OpinionPollInfo> queryOpinionPollInfoListByBean(OpinionPollInfo opinionPollInfo) {
		return opinionPollInfoMapper.queryOpinionPollInfoListByBean(opinionPollInfo);
	}
	
	public OpinionPollInfoMapper getOpinionPollInfoMapper() {
		return opinionPollInfoMapper;
	}

	public void setOpinionPollInfoMapper(OpinionPollInfoMapper opinionPollInfoMapper) {
		this.opinionPollInfoMapper = opinionPollInfoMapper;
	}


}
