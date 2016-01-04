package com.web.services;

import java.util.List;

import com.github.pagehelper.PageInfo;
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

	public PageInfo<SearchVO> querySearchVOByBean(SearchVO searchVO, Integer pageNum, Integer pageSize);
}
