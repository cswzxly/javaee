package com.system.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.system.mappers.CatalogMapper;
import com.system.mappers.ZlCatalogMapper;
import com.system.pojo.Catalog;
import com.system.pojo.ZlCatalog;

@Service("zlCatalogServices")
public class ZlCatalogServicesImpl  implements  ZlCatalogServices{
	private ZlCatalogMapper zlCatalogMapper;

	public ZlCatalogMapper getZlCatalogMapper() {
		return zlCatalogMapper;
	}

	public void setZlCatalogMapper(ZlCatalogMapper zlCatalogMapper) {
		this.zlCatalogMapper = zlCatalogMapper;
	}

	@Override
	public ZlCatalog queryCatalogByBean(ZlCatalog catalog) {		
		return zlCatalogMapper.queryCatalogByBean(catalog);
	}

	@Override
	public List<ZlCatalog> queryAllCatalogList() {
		return zlCatalogMapper.queryAllCatalogList();
	}

	public List<ZlCatalog> queryCatalogListByBean(ZlCatalog catalog){
		 return zlCatalogMapper.queryCatalogListByBean(catalog);
	 }
	@Override
	public void insertCatalog(ZlCatalog catalog) {
		zlCatalogMapper.insertCatalog(catalog);
	}

	@Override
	public void updateCatalog(ZlCatalog catalog) {
		zlCatalogMapper.updateCatalog(catalog);
	}

	@Override
	public void deleteCatalog(ZlCatalog catalog) {
		zlCatalogMapper.deleteCatalog(catalog);
	}

}
