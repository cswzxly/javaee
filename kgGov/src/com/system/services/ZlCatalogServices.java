package com.system.services;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.system.pojo.ZlCatalog;

@Transactional
public interface ZlCatalogServices {
	
	public ZlCatalog queryCatalogByBean(ZlCatalog catalog);

    public List<ZlCatalog> queryAllCatalogList();
    
    public List<ZlCatalog> queryCatalogListByBean(ZlCatalog catalog);

    public void insertCatalog(ZlCatalog catalog);

    public void updateCatalog(ZlCatalog catalog);

    public void deleteCatalog(ZlCatalog catalog);

}
