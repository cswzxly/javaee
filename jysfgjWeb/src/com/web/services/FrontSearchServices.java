package com.web.services;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.web.pojo.SearchVO;

/**
 * @author hchch
 *
 * 2014年8月22日
 */
@Transactional
public interface FrontSearchServices {
	
	public List<SearchVO> querySearchVOByBean(SearchVO searchVO);

}
