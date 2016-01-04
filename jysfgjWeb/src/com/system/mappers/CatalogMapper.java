package com.system.mappers;

import java.util.List;

import com.system.pojo.Catalog;
import com.system.pojo.Role;
import com.system.pojo.User;

public interface CatalogMapper {
	public Catalog queryCatalogByBean(Catalog catalog);

    public List<Catalog> queryAllCatalogList();
    
    public List<Catalog> queryCatalogListByBean(Catalog catalog);

    public void insertCatalog(Catalog catalog);

    public void updateCatalog(Catalog catalog);

    public void deleteCatalog(Catalog catalog);
    
    public List<Catalog> queryTopCatalogList(Catalog catalog);

    public List<Catalog> queryByRole(Role role);

    public List<Catalog> queryCatalogListByUser(User user);

}
