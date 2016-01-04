package com.system.services;

import java.util.List;

import com.system.pojo.Role;
import com.system.pojo.User;
import org.springframework.transaction.annotation.Transactional;
import com.system.pojo.Catalog;
@Transactional
public interface CatalogServices {


	public Catalog queryCatalogByBean(Catalog catalog);

    public List<Catalog> queryAllCatalogList();
    
    public List<Catalog> queryCatalogListByBean(Catalog catalog);

    public void insertCatalog(Catalog catalog);

    public void updateCatalog(Catalog catalog);

    public void deleteCatalog(Catalog catalog);

    public List<Catalog> queryByRole(Role role);

    public List<Catalog> queryCatalogListByUser(User user);

}
