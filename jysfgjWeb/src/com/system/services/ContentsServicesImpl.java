package com.system.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.system.bean.AllClassBean;
import com.system.mappers.ContentsMapper;
import com.system.pojo.Contents;
@Service("contentsServices")
public class ContentsServicesImpl implements ContentsServices {

	private ContentsMapper contentsMapper;
	
	public ContentsMapper getContentsMapper() {
		return contentsMapper;
	}

	public void setContentsMapper(ContentsMapper contentsMapper) {
		this.contentsMapper = contentsMapper;
	}

	@Override
	public Contents queryContentsByBean(Contents contents) {
		return contentsMapper.queryContentsByBean(contents);
	}

	@Override
	public List<Contents> queryAllContentsList() {
		return contentsMapper.queryAllContentsList();
	}

	@Override
	public List<Contents> queryContentsListByBean(Contents contents) {
		return contentsMapper.queryContentsListByBean(contents);
	}

	@Override
	public void insertContents(Contents contents) {
		contentsMapper.insertContents(contents);	
	}

	@Override
	public void updateContents(Contents contents) {
		contentsMapper.updateContents(contents);
	}

	@Override
	public void deleteContents(Contents contents) {
		contentsMapper.deleteContents(contents);
	}

	@Override
	public List<AllClassBean> getContentsListByBean(AllClassBean bean) {
		return contentsMapper.getContentsListByBean(bean);
	}

	@Override
	public List<Contents> queryTopContentsList(Contents contents) {
		return contentsMapper.queryTopContentsList(contents);
	}

	@Override
	public void updateTopNewsByCatalogID(Contents contents) {
		contentsMapper.updateTopNewsByCatalogID(contents);
	}
	
	@Override
	public Integer countContentsByBean(Contents contents){
		return contentsMapper.countContentsByBean(contents);
	}

	@Override
	public void batchDeleteContents(String ids) {
		contentsMapper.batchDeleteContents(ids);
	}
	
	
}
