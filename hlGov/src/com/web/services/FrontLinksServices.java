package com.web.services;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.system.pojo.Links;

/**
 * @author hchch
 *
 * 2014年8月20日
 */
@Transactional
public interface FrontLinksServices {

	public Links queryLinksByBean(Links links);

    public List<Links> queryLinksListByBean(Links links);

    public List<Links> queryTopLinksList(Links links);
    
}
