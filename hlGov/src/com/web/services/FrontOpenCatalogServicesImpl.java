package com.web.services;

import java.util.List;

import org.springframework.stereotype.Service;
import com.system.pojo.OpenCatalog;
import com.web.mappers.FrontOpenCatalogMapper;


@Service("frontOpenCatalogServices")
public class FrontOpenCatalogServicesImpl  implements  FrontOpenCatalogServices{
	private FrontOpenCatalogMapper frontOpenCatalogMapper;

	public FrontOpenCatalogMapper getFrontOpenCatalogMapper() {
		return frontOpenCatalogMapper;
	}

	public void setFrontOpenCatalogMapper(
			FrontOpenCatalogMapper frontOpenCatalogMapper) {
		this.frontOpenCatalogMapper = frontOpenCatalogMapper;
	}

	@Override
	public List<OpenCatalog> queryTopOpenCatalogList(OpenCatalog openCatalog) {
		// TODO Auto-generated method stub
		return frontOpenCatalogMapper.queryTopOpenCatalogList(openCatalog);
	}

	@Override
	public List<OpenCatalog> queryOpenCatalogList(OpenCatalog openCatalog) {
		// TODO Auto-generated method stub
		return frontOpenCatalogMapper.queryOpenCatalogList(openCatalog);
	}

	@Override
	public OpenCatalog queryOpenCatalogByBean(int theID) {
		// TODO Auto-generated method stub
		return frontOpenCatalogMapper.queryOpenCatalogByBean(theID);
	}

	@Override
	public OpenCatalog queryCatalogByBean(OpenCatalog temp) {
		 return frontOpenCatalogMapper.queryCatalogByBean(temp);
	}

	@Override
	public List<OpenCatalog> queryCatalogListByBean(OpenCatalog catalog) {
		  return frontOpenCatalogMapper.queryCatalogListByBean(catalog);
	}

}
