package com.web.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.system.pojo.Contents;
import com.system.pojo.OpenContents;
import com.web.mappers.FrontOpenContentsMapper;


@Service("frontOpenContentsServices")
public class FrontOpenContentsServicesImpl  implements  FrontOpenContentsServices{
	
	private FrontOpenContentsMapper frontOpenContentsMapper;
	
	public FrontOpenContentsMapper getFrontOpenContentsMapper() {
		return frontOpenContentsMapper;
	}


	public void setFrontOpenContentsMapper(FrontOpenContentsMapper frontOpenContentsMapper) {
		this.frontOpenContentsMapper = frontOpenContentsMapper;
	}


	@Override
	public List<OpenContents> queryTopOpenContentsList(OpenContents openContents) {
		return frontOpenContentsMapper.queryTopOpenContentsList(openContents);
	}


	@Override
	public List<OpenContents> queryOpenContentsList(OpenContents openContents) {
		return frontOpenContentsMapper.queryOpenContentsList(openContents);
	}


	@Override
	public OpenContents frontOpenContentsDetail(int theID) {
		return frontOpenContentsMapper.frontOpenContentsDetail(theID);
	}


	@Override
	public List<OpenContents> queryOCListByIDs(String ids) {
		
		return frontOpenContentsMapper.queryOCListByIDs(ids);
	}


	@Override
	public PageInfo<OpenContents> queryContentsByIds(OpenContents openContents,
			Integer pageNum, Integer pageSize) {
		PageHelper.startPage(pageNum, pageSize); 
		List<OpenContents> list = frontOpenContentsMapper.queryContentsByIds(openContents);
		return new PageInfo(list);
	}
	   @Override
	    public List<OpenContents> queryContentsByIds(OpenContents contents) {
	        return frontOpenContentsMapper.queryContentsByIds(contents);
	    }

}
