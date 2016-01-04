package com.system.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.system.bean.AllClassBean;
import com.system.pojo.Links;

public interface LinksMapper {
	public Links queryLinksByBean(Links links);

    public List<Links> queryAllLinksList();
    
    public List<Links> queryLinksListByBean(Links links);

    public void insertLinks(Links links);

    public void updateLinks(Links links);

    public void deleteLinks(Links links);
    
    public List<AllClassBean> getLinksListByBean(AllClassBean bean);
    
    public List<Links> queryTopLinksList(Links links);
    
}
