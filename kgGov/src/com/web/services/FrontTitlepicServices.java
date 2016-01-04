package com.web.services;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.system.pojo.Titlepic;
@Transactional
public interface FrontTitlepicServices {

	public List<Titlepic> queryAllTitlepicList();

	public Titlepic queryTitlepicByBean(Titlepic titlepic);
	
}
