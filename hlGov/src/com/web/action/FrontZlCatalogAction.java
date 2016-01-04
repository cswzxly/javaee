package com.web.action;
import java.util.List;

import javax.annotation.Resource;

import org.apache.struts2.ServletActionContext;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.system.action.BaseAction;
import com.system.pojo.ZlCatalog;
import com.web.services.FrontZlCatalogServices;

public class FrontZlCatalogAction extends BaseAction {

	private static final long serialVersionUID = 1L;
	
	@Resource(name="frontZlCatalogServices")
	private FrontZlCatalogServices frontZlCatalogServices;	

	public String frontZlCatalogPage(){
		String theID = request.getParameter("theID");
		String pageNum = request.getParameter("pageNum");
		String pageSize = request.getParameter("pageSize");
		request.setAttribute("theID", theID);
	
		request.setAttribute("pageNum ",pageNum);
		request.setAttribute("pageSize",pageSize);
		request.setAttribute("flag", request.getParameter("flag"));
		logger.info("lyyyyy>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.."+theID );
		logger.info("lyyyyy>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.."+pageNum );
		logger.info("lyyyyy>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.."+pageSize);
		return SUCCESS;
	}
	
	public String frontZlCatalogLeft(){
		logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>..");
		ZlCatalog zlCatalog = new ZlCatalog();
		zlCatalog.setStatus("1");
		List<ZlCatalog> catalList = frontZlCatalogServices.queryZlCatalogList(zlCatalog);
		JSONArray array = new JSONArray();
		request = ServletActionContext.getRequest();
		for (int i = 0; i < catalList.size(); i++) {
			JSONObject obj = new JSONObject();
			ZlCatalog catalog = catalList.get(i);
			
			String theID = catalog.getTheID().toString();
			ZlCatalog oc = new ZlCatalog();
			oc.setParentID(theID);
			oc.setStatus("1");
			List<ZlCatalog> list = frontZlCatalogServices.queryZlCatalogList(oc);
			
			obj.put("id", catalog.getTheID());
			obj.put("pId", catalog.getParentID());
			obj.put("name", catalog.getTitle());
			obj.put("open", true);
			if (((catalog.getParentID()).equals("1")) && list.size()>0) {
				obj.put("iconOpen", request.getContextPath()
						+ "/ztree/css/zTreeStyle/img/diy/1_open.png");
				obj.put("iconClose", request.getContextPath()
						+ "/ztree/css/zTreeStyle/img/diy/1_close.png");
				
			} else if ((catalog.getParentID()).equals("1")) {
				obj.put("icon", request.getContextPath()
						+ "/ztree/css/zTreeStyle/img/diy/1_open.png");
			} else {
				obj.put("icon", request.getContextPath()
						+ "/ztree/css/zTreeStyle/img/diy/3.png");
			}
			array.add(obj);
		}

		request = ServletActionContext.getRequest();
		request.setAttribute("array", JSONArray.toJSONString(array));
		return SUCCESS;
	}
	
	
}
