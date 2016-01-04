package com.system.mappers;

import java.util.List;
import com.system.pojo.ZlCatalog;

public interface ZlCatalogMapper {
	public ZlCatalog queryCatalogByBean(ZlCatalog catalog);

    public List<ZlCatalog> queryAllCatalogList();
    
    public List<ZlCatalog> queryCatalogListByBean(ZlCatalog catalog);

    public void insertCatalog(ZlCatalog catalog);

    public void updateCatalog(ZlCatalog catalog);

    public void deleteCatalog(ZlCatalog catalog);

}
