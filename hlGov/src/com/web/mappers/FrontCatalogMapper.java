package com.web.mappers;

import java.util.List;

import com.system.pojo.Catalog;

public interface FrontCatalogMapper {
	public Catalog queryCatalogByBean(Catalog catalog);

    public List<Catalog> queryCatalogListByBean(Catalog catalog);

    public List<Catalog> queryTopCatalogList(Catalog catalog);

}
