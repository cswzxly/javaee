package com.web.services;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;
import com.system.pojo.OpenCatalog;

@Transactional
public interface FrontOpenCatalogServices {
    
    public List<OpenCatalog> queryTopOpenCatalogList(OpenCatalog openCatalog);

    public List<OpenCatalog> queryOpenCatalogList(OpenCatalog openCatalog);
    
    public OpenCatalog queryOpenCatalogByBean(int theID);

	public OpenCatalog queryCatalogByBean(OpenCatalog temp);

	public List<OpenCatalog> queryCatalogListByBean(OpenCatalog catalog);
    
}
