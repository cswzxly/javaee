package com.web.services;

import org.springframework.transaction.annotation.Transactional;

import com.system.pojo.OpinionPollInfo;

/**
 * @author hchch
 *
 * 2014年11月7日
 */
@Transactional
public interface FrontOpinionPollInfoServices {
	
	public void insertOpinionPollInfo(OpinionPollInfo opinionPollInfo);
	
}
