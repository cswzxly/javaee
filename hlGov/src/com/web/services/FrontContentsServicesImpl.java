package com.web.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.system.pojo.Contents;
import com.web.mappers.FrontContentsMapper;

@Service("frontContentsServices")
public class FrontContentsServicesImpl implements FrontContentsServices{

	private FrontContentsMapper frontContentsMapper;
	
	@Override
	public Contents queryContentsByBean(Contents contents) {
		return frontContentsMapper.queryContentsByBean(contents);
	}

	@Override
	public List<Contents> queryContentsListByBean(Contents contents) {
		return frontContentsMapper.queryContentsListByBean(contents);
	}

	@Override
	public List<Contents> queryTopContentsList(Contents contents) {
		return frontContentsMapper.queryTopContentsList(contents);
	}
	
	@Override
	public List<Contents> queryContentsByCataPid(Contents contents) {
		return frontContentsMapper.queryContentsByCataPid(contents);
	}

	
	
	public FrontContentsMapper getFrontContentsMapper() {
		return frontContentsMapper;
	}

	public void setFrontContentsMapper(FrontContentsMapper frontContentsMapper) {
		this.frontContentsMapper = frontContentsMapper;
	}

	@Override
	public void updateContentsViewedNum(Contents contents) {
		this.frontContentsMapper.updateContentsViewedNum(contents);
	}

	  @Override
		public PageInfo<Contents> queryContentsByIds(Contents contents, Integer pageNum,
				Integer pageSize) {
			PageHelper.startPage(pageNum, pageSize); 
			List<Contents> list = frontContentsMapper.queryContentsByIds(contents);
			return new PageInfo(list);
		}



}
