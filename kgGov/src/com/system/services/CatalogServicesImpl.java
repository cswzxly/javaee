package com.system.services;

import java.util.List;

import com.system.pojo.Role;
import com.system.pojo.User;
import org.springframework.stereotype.Service;

import com.system.mappers.CatalogMapper;
import com.system.pojo.Catalog;

@Service("catalogServices")
public class CatalogServicesImpl  implements  CatalogServices{
	private CatalogMapper catalogMapper;
	
	public CatalogMapper getCatalogMapper() {
		return catalogMapper;
	}

	public void setCatalogMapper(CatalogMapper catalogMapper) {
		this.catalogMapper = catalogMapper;
	}

	@Override
	public Catalog queryCatalogByBean(Catalog catalog) {		
		return catalogMapper.queryCatalogByBean(catalog);
	}

	@Override
	public List<Catalog> queryAllCatalogList() {
		return catalogMapper.queryAllCatalogList();
	}

	public List<Catalog> queryCatalogListByBean(Catalog catalog){
		 return catalogMapper.queryCatalogListByBean(catalog);
	 }
	@Override
	public void insertCatalog(Catalog catalog) {
		catalogMapper.insertCatalog(catalog);
	}

	@Override
	public void updateCatalog(Catalog catalog) {
		catalogMapper.updateCatalog(catalog);
	}

	@Override
	public void deleteCatalog(Catalog catalog) {
		catalogMapper.deleteCatalog(catalog);
	}

	@Override
	public List<Catalog> queryByRole(Role role) {
		return catalogMapper.queryByRole(role);
	}

	@Override
	public List<Catalog> queryCatalogListByUser(User user) {
		return catalogMapper.queryCatalogListByUser(user);
	}

}
