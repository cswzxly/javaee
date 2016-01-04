package com.web.mappers;

import java.util.List;
import com.system.pojo.ZlCatalog;

public interface FrontZlCatalogMapper {

    public List<ZlCatalog> queryTopZlCatalogList(ZlCatalog zlcatalog);

    public List<ZlCatalog> queryZlCatalogList(ZlCatalog zlcatalog);
    
    public ZlCatalog queryZlCatalogByBean(int theID);
    
}
