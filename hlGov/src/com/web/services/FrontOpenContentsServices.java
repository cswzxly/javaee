package com.web.services;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageInfo;
import com.system.pojo.OpenContents;
import com.system.pojo.ZlContents;

@Transactional
public interface FrontOpenContentsServices {

    
	public List<OpenContents> queryTopOpenContentsList(OpenContents openContents);

	public List<OpenContents> queryOpenContentsList(OpenContents openContents);
	
	public OpenContents frontOpenContentsDetail(int theID);
	
	public List<OpenContents> queryOCListByIDs(String ids);

	public PageInfo<OpenContents> queryContentsByIds(OpenContents openContents,
			Integer pageNum, Integer pageSize);

	List<OpenContents> queryContentsByIds(OpenContents contents);
}
