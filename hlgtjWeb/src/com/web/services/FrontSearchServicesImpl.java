package com.web.services;

import java.util.List;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import com.web.mappers.FrontSearchMapper;
import com.web.pojo.SearchVO;
/**
 * @author hchch
 *
 * 2014年8月22日
 */
@Service("frontSearchServices")
public class FrontSearchServicesImpl implements FrontSearchServices{
	
	private FrontSearchMapper frontSearchMapper;

	@Override
	public List<SearchVO> querySearchVOByBean(SearchVO searchVO) {
		return frontSearchMapper.querySearchVOByBean(searchVO);
	}
	
	@Override
	public PageInfo<SearchVO> querySearchVOByBean(SearchVO searchVO, Integer pageNum, Integer pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		List<SearchVO> list = frontSearchMapper.querySearchVOByBean(searchVO);
		return new PageInfo<SearchVO>(list);
	}

	public FrontSearchMapper getFrontSearchMapper() {
		return frontSearchMapper;
	}

	public void setFrontSearchMapper(FrontSearchMapper frontSearchMapper) {
		this.frontSearchMapper = frontSearchMapper;
	}

}
