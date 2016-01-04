package com.system.mappers;

import java.util.List;

import com.system.bean.AllClassBean;
import com.system.pojo.OpinionPollInfo;

public interface OpinionPollInfoMapper {

	public OpinionPollInfo queryOpinionPollInfoByBean(OpinionPollInfo opinionPollInfo);
	
	public List<OpinionPollInfo> queryAllOpinionPollInfoList();
	
	public List<OpinionPollInfo> queryOpinionPollInfoListByBean(OpinionPollInfo opinionPollInfo);
	
	public void insertOpinionPollInfo(OpinionPollInfo opinionPollInfo);

	public void updateOpinionPollInfo(OpinionPollInfo opinionPollInfo);
	
	public void deleteOpinionPollInfo(Integer theID);
	
	public List<AllClassBean> getOpinionPollInfoListByBean(AllClassBean bean);
	
}
