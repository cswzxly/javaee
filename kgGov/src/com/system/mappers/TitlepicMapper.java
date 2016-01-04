package com.system.mappers;

import java.util.List;

import com.system.pojo.Titlepic;

public interface TitlepicMapper {

	public List<Titlepic> queryAllTitlepicList();
	
	public int saveNewTitlepic(Titlepic titlepic);
	
	public void saveEditTitlepic(Titlepic titlepic);
	
	public void deleteTitlepic(int theID);
	
	
}
