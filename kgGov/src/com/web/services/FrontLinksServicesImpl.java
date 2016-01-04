package com.web.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.system.pojo.Links;
import com.web.mappers.FrontLinksMapper;


/**
 * @author hchch
 *
 * 2014年8月20日
 */
@Service("frontLinksServices")
public class FrontLinksServicesImpl implements FrontLinksServices{
	
	private FrontLinksMapper frontLinksMapper;

	@Override
	public Links queryLinksByBean(Links links) {
		return frontLinksMapper.queryLinksByBean(links);
	}

	@Override
	public List<Links> queryLinksListByBean(Links links) {
		return frontLinksMapper.queryLinksListByBean(links);
	}

	@Override
	public List<Links> queryTopLinksList(Links links) {
		return frontLinksMapper.queryTopLinksList(links);
	}

	public FrontLinksMapper getFrontLinksMapper() {
		return frontLinksMapper;
	}

	public void setFrontLinksMapper(FrontLinksMapper frontLinksMapper) {
		this.frontLinksMapper = frontLinksMapper;
	}

}
