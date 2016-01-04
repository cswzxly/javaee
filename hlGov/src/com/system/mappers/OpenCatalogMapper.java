package com.system.mappers;

import java.util.List;

import com.system.pojo.OpenCatalog;

public interface OpenCatalogMapper {
	public OpenCatalog queryOpenCatalogByBean(OpenCatalog openCatalog);

    public List<OpenCatalog> queryAllOpenCatalogList();
    
    public List<OpenCatalog> queryOpenCatalogListByBean(OpenCatalog openCatalog);

    public void insertOpenCatalog(OpenCatalog openCatalog);

    public void updateOpenCatalog(OpenCatalog openCatalog);

    public void deleteOpenCatalog(OpenCatalog openCatalog);
    
    public List<OpenCatalog> queryTopOpenCatalogList(OpenCatalog openCatalog);

}
