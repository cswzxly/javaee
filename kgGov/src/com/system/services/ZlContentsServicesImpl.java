package com.system.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.system.mappers.ZlContentsMapper;
import com.system.pojo.ZlContents;
@Service("zlContentsServices")
public class ZlContentsServicesImpl implements ZlContentsServices {

	private ZlContentsMapper zlContentsMapper;

	public ZlContentsMapper getZlContentsMapper() {
		return zlContentsMapper;
	}

	public void setZlContentsMapper(ZlContentsMapper zlContentsMapper) {
		this.zlContentsMapper = zlContentsMapper;
	}

	@Override
	public ZlContents queryContentsByBean(ZlContents contents) {
		return zlContentsMapper.queryContentsByBean(contents);
	}

	@Override
	public List<ZlContents> queryAllContentsList() {
		return zlContentsMapper.queryAllContentsList();
	}

	@Override
	public List<ZlContents> queryContentsListByBean(ZlContents contents) {
		return zlContentsMapper.queryContentsListByBean(contents);
	}

	@Override
	public void insertContents(ZlContents contents) {
		zlContentsMapper.insertContents(contents);	
	}

	@Override
	public void updateContents(ZlContents contents) {
		zlContentsMapper.updateContents(contents);
	}

	@Override
	public void deleteContents(ZlContents contents) {
		zlContentsMapper.deleteContents(contents);
	}

}
