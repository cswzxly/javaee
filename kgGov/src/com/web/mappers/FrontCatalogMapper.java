package com.web.mappers;

import com.system.pojo.Catalog;

import java.util.List;

public interface FrontCatalogMapper {
	public Catalog queryCatalogByBean(Catalog catalog);

    public List<Catalog> queryCatalogListByBean(Catalog catalog);

    public List<Catalog> queryTopCatalogList(Catalog catalog);

    List<Catalog> queryCatalogByParentID(String parentID);

    Catalog queryCatalogByID(String theID);

}
