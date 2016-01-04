package com.system.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.system.mappers.OpenCatalogMapper;
import com.system.pojo.OpenCatalog;

@Service("openCatalogServices")
public class OpenCatalogServicesImpl implements OpenCatalogServices{
	private OpenCatalogMapper openCatalogMapper;
	
	public OpenCatalogMapper getOpenCatalogMapper() {
		return openCatalogMapper;
	}

	public void setOpenCatalogMapper(OpenCatalogMapper openCatalogMapper) {
		this.openCatalogMapper = openCatalogMapper;
	}

	@Override
	public OpenCatalog queryOpenCatalogByBean(OpenCatalog openCatalog) {		
		return openCatalogMapper.queryOpenCatalogByBean(openCatalog);
	}

	@Override
	public List<OpenCatalog> queryAllOpenCatalogList() {
		return openCatalogMapper.queryAllOpenCatalogList();
	}

	public List<OpenCatalog> queryOpenCatalogListByBean(OpenCatalog openCatalog){
		 return openCatalogMapper.queryOpenCatalogListByBean(openCatalog);
	 }
	@Override
	public void insertOpenCatalog(OpenCatalog openCatalog) {
		openCatalogMapper.insertOpenCatalog(openCatalog);
	}

	@Override
	public void updateOpenCatalog(OpenCatalog openCatalog) {
		openCatalogMapper.updateOpenCatalog(openCatalog);
	}

	@Override
	public void deleteOpenCatalog(OpenCatalog openCatalog) {
		openCatalogMapper.deleteOpenCatalog(openCatalog);
	}

}
