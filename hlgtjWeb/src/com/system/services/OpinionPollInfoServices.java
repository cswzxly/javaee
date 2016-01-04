package com.system.services;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.system.bean.AllClassBean;
import com.system.pojo.OpinionPollInfo;

/**
 * @author hchch
 *
 * 2014年11月4日
 */
@Transactional
public interface OpinionPollInfoServices {

	public OpinionPollInfo queryOpinionPollInfoByBean(OpinionPollInfo opinionPollInfo);
	
	public List<OpinionPollInfo> queryOpinionPollInfoListByBean(OpinionPollInfo opinionPollInfo);
	
	public List<OpinionPollInfo> queryAllOpinionPollInfoList();
	
	public void insertOpinionPollInfo(OpinionPollInfo opinionPollInfo);

	public void updateOpinionPollInfo(OpinionPollInfo opinionPollInfo);
	
	public void deleteOpinionPollInfo(Integer theID);
	
	public List<AllClassBean> getOpinionPollInfoListByBean(AllClassBean bean);
	
	
}
