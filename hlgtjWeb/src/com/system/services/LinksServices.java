package com.system.services;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.system.bean.AllClassBean;
import com.system.pojo.Links;
/**
 * @author hchch
 *
 * 2014年8月13日
 */
@Transactional
public interface LinksServices {

	public Links queryLinksByBean(Links links);

    public List<Links> queryAllLinksList();
    
    public List<Links> queryLinksListByBean(Links links);

    public void insertLinks(Links links);

    public void updateLinks(Links links);

    public void deleteLinks(Links links);
    
    public List<AllClassBean> getLinksListByBean(AllClassBean bean);
    
    public List<Links> queryTopLinksList(Links links);
    
}
