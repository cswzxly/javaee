package com.system.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.system.bean.AllClassBean;
import com.system.mappers.LinksMapper;
import com.system.pojo.Links;

/**
 * @author hchch
 *
 * 2014年8月13日
 */
@Service("linksServices")
public class LinksServicesImpl implements LinksServices{
	
	private LinksMapper linksMapper;

	@Override
	public Links queryLinksByBean(Links links) {
		return linksMapper.queryLinksByBean(links);
	}

	@Override
	public List<Links> queryAllLinksList() {
		return linksMapper.queryAllLinksList();
	}

	@Override
	public List<Links> queryLinksListByBean(Links links) {
		return linksMapper.queryLinksListByBean(links);
	}

	@Override
	public void insertLinks(Links links) {
		linksMapper.insertLinks(links);
	}

	@Override
	public void updateLinks(Links links) {
		linksMapper.updateLinks(links);
	}

	@Override
	public void deleteLinks(Links links) {
		linksMapper.deleteLinks(links);
	}

	@Override
	public List<AllClassBean> getLinksListByBean(AllClassBean bean) {
		return linksMapper.getLinksListByBean(bean);
	}

	@Override
	public List<Links> queryTopLinksList(Links links) {
		return linksMapper.queryTopLinksList(links);
	}
	
	
	public LinksMapper getLinksMapper() {
		return linksMapper;
	}

	public void setLinksMapper(LinksMapper linksMapper) {
		this.linksMapper = linksMapper;
	}

}
