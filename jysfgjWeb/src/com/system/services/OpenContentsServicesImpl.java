package com.system.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.system.bean.AllClassBean;
import com.system.mappers.OpenContentsMapper;
import com.system.pojo.OpenContents;
@Service("openContentsServices")
public class OpenContentsServicesImpl implements OpenContentsServices {

	private OpenContentsMapper openContentsMapper;	

	public OpenContentsMapper getOpenContentsMapper() {
		return openContentsMapper;
	}

	public void setOpenContentsMapper(OpenContentsMapper openContentsMapper) {
		this.openContentsMapper = openContentsMapper;
	}

	@Override
	public OpenContents queryOpenContentsByBean(OpenContents openContents) {
		return openContentsMapper.queryOpenContentsByBean(openContents);
	}

	@Override
	public List<OpenContents> queryAllOpenContentsList() {
		return openContentsMapper.queryAllOpenContentsList();
	}

	@Override
	public List<OpenContents> queryOpenContentsListByBean(OpenContents openContents) {
		return openContentsMapper.queryOpenContentsListByBean(openContents);
	}

	@Override
	public void insertOpenContents(OpenContents openContents) {
		openContentsMapper.insertOpenContents(openContents);	
	}

	@Override
	public void updateOpenContents(OpenContents openContents) {
		openContentsMapper.updateOpenContents(openContents);
	}

	@Override
	public void deleteOpenContents(OpenContents openContents) {
		openContentsMapper.deleteOpenContents(openContents);
	}

	@Override
	public List<AllClassBean> getOpenContentsListByBean(AllClassBean bean) {
		return openContentsMapper.getOpenContentsListByBean(bean);
	}

	@Override
	public List<OpenContents> queryTopOpenContentsList(OpenContents openContents) {
		return openContentsMapper.queryTopOpenContentsList(openContents);
	}

}
