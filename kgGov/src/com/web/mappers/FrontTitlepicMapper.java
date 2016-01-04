package com.web.mappers;

import java.util.List;

import com.system.pojo.Titlepic;

public interface FrontTitlepicMapper {

	public List<Titlepic> queryAllTitlepicList();
	
	public Titlepic queryTitlepicByBean(Titlepic titlepic);
	
}
