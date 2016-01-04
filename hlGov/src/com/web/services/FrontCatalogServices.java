package com.web.services;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;
import com.system.pojo.Catalog;
/**
 * @author hchch
 *
 * 2014年8月18日
 */
@Transactional
public interface FrontCatalogServices {

	public Catalog queryCatalogByBean(Catalog catalog);

    
    public List<Catalog> queryCatalogListByBean(Catalog catalog);
    
    public List<Catalog> queryTopCatalogList(Catalog catalog);

	
}
