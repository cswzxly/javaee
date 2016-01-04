package com.web.action;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.system.action.BaseAction;
import com.system.pojo.Catalog;
import com.system.pojo.Contents;
import com.web.services.FrontCatalogServices;
import com.web.services.FrontContentsServices;

/**
 * @author hchch
 *
 * 2014年8月20日
 */
public class SpecialTopicAction extends BaseAction{

	private static final long serialVersionUID = 1L;
	@Autowired
	private FrontCatalogServices frontCatalogServices;
	@Autowired
	private FrontContentsServices frontContentsServices;

	public String specialTopicList(){
		String catalogID = request.getParameter("catalogID");
		Catalog catalog = this.getCatalogByID(catalogID);
		request.setAttribute("catalog", catalog);
		
		List<Catalog> ztCatalogList = this.initLeftCatalog(catalog.getParentID());
		request.setAttribute("leftCatalogList", ztCatalogList);
		
		Contents contents = new Contents();
		contents.setCatalogID(Integer.valueOf(catalogID));
		contents.setStatus("1");
		List<Contents> contentsList = frontContentsServices.queryContentsListByBean(contents);
		request.setAttribute("contentsList", contentsList);
		return "success";
	}
	
	public String specialTopicShow(){
		String contentsID = request.getParameter("contentID");
		Contents contents = new Contents();
		contents.setTheID(Integer.valueOf(contentsID));
		contents.setStatus("1");
		contents = frontContentsServices.queryContentsByBean(contents);
		request.setAttribute("contents", contents);
		
		Catalog catalog = this.getCatalogByID(contents.getCatalogID().toString());
		request.setAttribute("catalog", catalog);
		
		List<Catalog> ztCatalogList = this.initLeftCatalog(catalog.getParentID());
		request.setAttribute("leftCatalogList", ztCatalogList);
		return "success";
	}
	
	/**
	 * @return
	 */
	private List<Catalog> initLeftCatalog(String pCatalogID){
		Catalog catalog = new Catalog();
		catalog.setCatalogType("t_specialTopic");
		catalog.setParentID(pCatalogID);
		catalog.setStatus("1");
		List<Catalog> list = frontCatalogServices.queryCatalogListByBean(catalog);
		return list;
	}
	
	/**
	 * @param catalogID
	 * @return
	 */
	private Catalog getCatalogByID(String catalogID){
		Catalog temp = new Catalog();
		temp.setTheID(Integer.valueOf(catalogID));
		Catalog catalog = frontCatalogServices.queryCatalogByBean(temp);
		return catalog;
	}
	
	public FrontContentsServices getFrontContentsServices() {
		return frontContentsServices;
	}

	public void setFrontContentsServices(FrontContentsServices frontContentsServices) {
		this.frontContentsServices = frontContentsServices;
	}

	public FrontCatalogServices getFrontCatalogServices() {
		return frontCatalogServices;
	}

	public void setFrontCatalogServices(FrontCatalogServices frontCatalogServices) {
		this.frontCatalogServices = frontCatalogServices;
	}
}
