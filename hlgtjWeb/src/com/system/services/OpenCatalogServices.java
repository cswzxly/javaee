package com.system.services;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;
import com.system.pojo.OpenCatalog;
@Transactional
public interface OpenCatalogServices {

	public OpenCatalog queryOpenCatalogByBean(OpenCatalog openCatalog);

    public List<OpenCatalog> queryAllOpenCatalogList();
    
    public List<OpenCatalog> queryOpenCatalogListByBean(OpenCatalog openCatalog);

    public void insertOpenCatalog(OpenCatalog openCatalog);

    public void updateOpenCatalog(OpenCatalog openCatalog);

    public void deleteOpenCatalog(OpenCatalog openCatalog);
	
}
