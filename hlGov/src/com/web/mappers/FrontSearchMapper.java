package com.web.mappers;

import java.util.List;

import com.web.pojo.SearchVO;

/**
 * @author hchch
 *
 * 2014年8月22日
 */
public interface FrontSearchMapper {

	public List<SearchVO> querySearchVOByBean(SearchVO searchVO);
	
}
