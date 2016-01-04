package com.web.services;

import java.util.List;

import org.springframework.stereotype.Service;
import com.system.pojo.Catalog;
import com.web.mappers.FrontCatalogMapper;

/**
 * @author hchch
 *         <p/>
 *         2014年8月18日
 */
@Service("frontCatalogServices")
public class FrontCatalogServicesImpl implements FrontCatalogServices {
//	private CatalogMapper catalogMapper;

    private FrontCatalogMapper frontCatalogMapper;

    public FrontCatalogMapper getFrontCatalogMapper() {
        return frontCatalogMapper;
    }

    public void setFrontCatalogMapper(FrontCatalogMapper frontCatalogMapper) {
        this.frontCatalogMapper = frontCatalogMapper;
    }

    @Override
    public Catalog queryCatalogByBean(Catalog catalog) {
        return frontCatalogMapper.queryCatalogByBean(catalog);
    }

    public List<Catalog> queryCatalogListByBean(Catalog catalog) {
        return frontCatalogMapper.queryCatalogListByBean(catalog);
    }

    @Override
    public List<Catalog> queryTopCatalogList(Catalog catalog) {
        return frontCatalogMapper.queryTopCatalogList(catalog);
    }

    @Override
    public List<Catalog> queryCatalogByParentID(String parentID) {
        return frontCatalogMapper.queryCatalogByParentID(parentID);
    }

    public Catalog queryCatalogByID(String theID) {
        return frontCatalogMapper.queryCatalogByID(theID);
    }

	@Override
	public int countCatalogByBean(Catalog catalog) {
		return frontCatalogMapper.countCatalogByBean(catalog);
	}

}
