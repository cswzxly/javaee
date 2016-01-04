package com.system.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.system.mappers.TitlepicMapper;
import com.system.pojo.Titlepic;

@Service("titlepicServices")
public class TitlepicServicesImpl  implements TitlepicServices{
	private TitlepicMapper titlepicMapper;

	public TitlepicMapper getTitlepicMapper() {
		return titlepicMapper;
	}

	public void setTitlepicMapper(TitlepicMapper titlepicMapper) {
		this.titlepicMapper = titlepicMapper;
	}

	@Override
	public List<Titlepic> queryAllTitlepicList() {
		// TODO Auto-generated method stub
		return titlepicMapper.queryAllTitlepicList();
	}

	@Override
	public int saveNewTitlepic(Titlepic titlepic) {
		// TODO Auto-generated method stub
		return titlepicMapper.saveNewTitlepic(titlepic);
	}

	@Override
	public void deleteTitlepic(int theID) {
		// TODO Auto-generated method stub
		titlepicMapper.deleteTitlepic(theID);
	}

	@Override
	public void saveEditTitlepic(Titlepic titlepic) {
		// TODO Auto-generated method stub
		titlepicMapper.saveEditTitlepic(titlepic);
	}
	
}
