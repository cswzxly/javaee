package com.web.services;

import java.util.List;

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

	public FrontSearchMapper getFrontSearchMapper() {
		return frontSearchMapper;
	}

	public void setFrontSearchMapper(FrontSearchMapper frontSearchMapper) {
		this.frontSearchMapper = frontSearchMapper;
	}

}
