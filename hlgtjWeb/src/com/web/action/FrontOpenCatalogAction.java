package com.web.action;
import java.util.List;

import javax.annotation.Resource;

import org.apache.struts2.ServletActionContext;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.system.action.BaseAction;
import com.system.pojo.OpenCatalog;
import com.web.services.FrontOpenCatalogServices;

public class FrontOpenCatalogAction extends BaseAction {

	private static final long serialVersionUID = 1L;
	
	@Resource(name="frontOpenCatalogServices")
	private FrontOpenCatalogServices frontOpenCatalogServices;	

	public String frontOpenCatalogPage(){
		String theID = request.getParameter("theID");
		request.setAttribute("theID", theID);
		request.setAttribute("flag", request.getParameter("flag"));
		return SUCCESS;
	}
	
	public String frontOpenCatalogLeft(){
		logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>..");
		OpenCatalog openCatalog = new OpenCatalog();
		openCatalog.setStatus("1");
		openCatalog.setCatalogType("t_contents");
		List<OpenCatalog> catalList = frontOpenCatalogServices.queryOpenCatalogList(openCatalog);
		JSONArray array = new JSONArray();
		request = ServletActionContext.getRequest();
		for (int i = 0; i < catalList.size(); i++) {
			JSONObject obj = new JSONObject();
			OpenCatalog catalog = catalList.get(i);
			
			String theID = catalog.getTheID().toString();
			OpenCatalog oc = new OpenCatalog();
			oc.setParentID(theID);
			oc.setStatus("1");
			oc.setCatalogType("t_contents");
			List<OpenCatalog> list = frontOpenCatalogServices.queryOpenCatalogList(oc);
			
			obj.put("id", catalog.getTheID());
			obj.put("pId", catalog.getParentID());
			obj.put("name", catalog.getTitle());
			if (((catalog.getParentID()).equals("1")) && list.size()>0) {
				obj.put("iconOpen", request.getContextPath()
						+ "/ztree/css/zTreeStyle/img/diy/1_open.png");
				obj.put("iconClose", request.getContextPath()
						+ "/ztree/css/zTreeStyle/img/diy/1_close.png");
				obj.put("open", true);
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
