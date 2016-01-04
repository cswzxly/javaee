package com.web.action;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;

import com.system.action.BaseAction;
import com.system.pojo.User;
import com.system.pojo.ZlCatalog;
import com.system.pojo.ZlContents;
import com.system.services.UserServices;
import com.web.services.FrontZlCatalogServices;
import com.web.services.FrontZlContentsServices;

public class FrontZlContentsAction extends BaseAction {

	private static final long serialVersionUID = 1L;
	
	@Resource(name="frontZlContentsServices")
	private FrontZlContentsServices frontZlContentsServices;	
	
	@Resource(name="frontZlCatalogServices")
	private FrontZlCatalogServices frontZlCatalogServices;
	
	@Autowired
	private UserServices userServices;

	public String frontZlContentsRight(){
		ZlContents zlContents = new ZlContents();
		String catalogID = request.getParameter("theID");
		if(catalogID!=null&&!"".equals(catalogID)){
			ZlCatalog catalog = frontZlCatalogServices.queryZlCatalogByBean(Integer.valueOf(catalogID));
			request.setAttribute("catalog", catalog);
		}
		
		if(catalogID!=null&&!("").equals(catalogID)){
			
			ZlCatalog zlcatalog = new ZlCatalog();
			zlcatalog.setParentID(catalogID);
			List<ZlCatalog> zlCatalogList = frontZlCatalogServices.queryZlCatalogList(zlcatalog);
			if(zlCatalogList.size() > 0){
				zlContents.setCatalogPid(catalogID);
			}else{
				zlContents.setCatalogID(catalogID);
			}
			zlContents.setStatus("1");
			List<ZlContents> list = new ArrayList<ZlContents>();
			list = this.frontZlContentsServices.queryZlContentsList(zlContents);
			request.setAttribute("list", list);
		}
		request.setAttribute("theID", catalogID);
		return SUCCESS;
	}
	
	public String frontZlContentsDetail(){
		int theID = Integer.valueOf(request.getParameter("theID"));
		ZlContents zlContents = frontZlContentsServices.queryZlContentsByBean(theID);
		
		User user = new User();
		user.setId(Integer.valueOf(zlContents.getCreater_pid()));
		user = userServices.queryUserByBean(user);
		zlContents.setUserName(user.getRealName());
		
		request.setAttribute("zlContents", zlContents);
		String title = request.getParameter("title");
		request.setAttribute("title", title);
		return SUCCESS;
	}
	
	
	
}
