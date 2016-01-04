package com.web.services;

import java.util.List;

import org.springframework.stereotype.Service;
import com.system.pojo.ZlCatalog;
import com.web.mappers.FrontZlCatalogMapper;

@Service("frontZlCatalogServices")
public class FrontZlCatalogServicesImpl  implements  FrontZlCatalogServices{
	private FrontZlCatalogMapper frontZlCatalogMapper;

	public FrontZlCatalogMapper getFrontZlCatalogMapper() {
		return frontZlCatalogMapper;
	}

	public void setFrontZlCatalogMapper(FrontZlCatalogMapper frontZlCatalogMapper) {
		this.frontZlCatalogMapper = frontZlCatalogMapper;
	}

	@Override
	public List<ZlCatalog> queryTopZlCatalogList(ZlCatalog zlcatalog) {
		// TODO Auto-generated method stub
		return frontZlCatalogMapper.queryTopZlCatalogList(zlcatalog);
	}

	@Override
	public List<ZlCatalog> queryZlCatalogList(ZlCatalog zlcatalog) {
		// TODO Auto-generated method stub
		return frontZlCatalogMapper.queryZlCatalogList(zlcatalog);
	}

	@Override
	public ZlCatalog queryZlCatalogByBean(int theID) {
		// TODO Auto-generated method stub
		return frontZlCatalogMapper.queryZlCatalogByBean(theID);
	}

}
