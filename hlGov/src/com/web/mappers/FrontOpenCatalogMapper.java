package com.web.mappers;

import java.util.List;

import com.system.pojo.OpenCatalog;

public interface FrontOpenCatalogMapper {

    public List<OpenCatalog> queryTopOpenCatalogList(OpenCatalog openCatalog);
    
    public List<OpenCatalog> queryOpenCatalogList(OpenCatalog openCatalog);
    
    public OpenCatalog queryOpenCatalogByBean(int theID);

	public OpenCatalog queryCatalogByBean(OpenCatalog temp);

	public List<OpenCatalog> queryCatalogListByBean(OpenCatalog catalog);

}
