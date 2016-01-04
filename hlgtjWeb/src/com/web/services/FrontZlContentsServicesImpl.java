package com.web.services;

import java.util.List;

import org.springframework.stereotype.Service;
import com.system.pojo.ZlContents;
import com.web.mappers.FrontZlContentsMapper;


@Service("frontZlContentsServices")
public class FrontZlContentsServicesImpl  implements  FrontZlContentsServices{
	
	private FrontZlContentsMapper frontZlContentsMapper;

	public FrontZlContentsMapper getFrontZlContentsMapper() {
		return frontZlContentsMapper;
	}

	public void setFrontZlContentsMapper(FrontZlContentsMapper frontZlContentsMapper) {
		this.frontZlContentsMapper = frontZlContentsMapper;
	}

	@Override
	public List<ZlContents> queryTopZlContentsList(ZlContents zlContents) {
		// TODO Auto-generated method stub
		return frontZlContentsMapper.queryTopZlContentsList(zlContents);
	}

	@Override
	public List<ZlContents> queryZlContentsList(ZlContents zlContents) {
		// TODO Auto-generated method stub
		return frontZlContentsMapper.queryZlContentsList(zlContents);
	}

	@Override
	public ZlContents queryZlContentsByBean(int theID) {
		// TODO Auto-generated method stub
		return frontZlContentsMapper.queryZlContentsByBean(theID);
	}



}
