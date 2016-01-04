package com.web.services;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.system.pojo.OpenContents;

@Transactional
public interface FrontOpenContentsServices {

    
	public List<OpenContents> queryTopOpenContentsList(OpenContents openContents);

	public List<OpenContents> queryOpenContentsList(OpenContents openContents);
	
	public OpenContents frontOpenContentsDetail(int theID);
	
	public List<OpenContents> queryOCListByIDs(String ids);
}
