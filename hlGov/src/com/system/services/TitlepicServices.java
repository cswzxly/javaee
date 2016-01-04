package com.system.services;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.system.pojo.Titlepic;
@Transactional
public interface TitlepicServices {

	public List<Titlepic> queryAllTitlepicList();

	public int saveNewTitlepic(Titlepic titlepic);
	
	public void saveEditTitlepic(Titlepic titlepic);
	
	public void deleteTitlepic(int theID);
	
}
