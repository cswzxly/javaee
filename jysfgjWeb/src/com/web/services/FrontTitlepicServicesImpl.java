package com.web.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.system.pojo.Titlepic;
import com.web.mappers.FrontTitlepicMapper;

@Service("frontTitlepicServices")
public class FrontTitlepicServicesImpl  implements FrontTitlepicServices{
	private FrontTitlepicMapper frontTitlepicMapper;

	@Override
	public List<Titlepic> queryAllTitlepicList() {
		return frontTitlepicMapper.queryAllTitlepicList();
	}

	@Override
	public Titlepic queryTitlepicByBean(Titlepic titlepic) {
		return frontTitlepicMapper.queryTitlepicByBean(titlepic);
	}

	public FrontTitlepicMapper getFrontTitlepicMapper() {
		return frontTitlepicMapper;
	}

	public void setFrontTitlepicMapper(FrontTitlepicMapper frontTitlepicMapper) {
		this.frontTitlepicMapper = frontTitlepicMapper;
	}

	
	
}
