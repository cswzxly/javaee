package com.web.mappers;

import java.util.List;

import com.system.pojo.Links;

public interface FrontLinksMapper {
	public Links queryLinksByBean(Links links);
    
    public List<Links> queryLinksListByBean(Links links);
    
    public List<Links> queryTopLinksList(Links links);
    
}
