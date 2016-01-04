package com.web.action;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;

import com.system.action.BaseAction;
import com.system.pojo.OpenCatalog;
import com.system.pojo.OpenContents;
import com.system.pojo.User;
import com.system.services.UserServices;
import com.web.services.FrontOpenCatalogServices;
import com.web.services.FrontOpenContentsServices;

public class FrontOpenContentsAction extends BaseAction {

	private static final long serialVersionUID = 1L;
	
	@Resource(name="frontOpenContentsServices")
	private FrontOpenContentsServices frontOpenContentsServices;	
	
	@Resource(name="frontOpenCatalogServices")
	private FrontOpenCatalogServices frontOpenCatalogServices;
	
	@Autowired
	private UserServices userServices;

	public String frontOpenContentsRight(){
		logger.info(">>>>>>>>>>>>>>>>>>>>>>>frontOpenContentsAction:frontOpenContentsRight>>>>>>>>>>>>>>>");
		OpenContents openContents = new OpenContents();
		String catalogID = request.getParameter("theID");
		if(catalogID!=null&&!"".equals(catalogID)){
			OpenCatalog catalog = frontOpenCatalogServices.queryOpenCatalogByBean(Integer.valueOf(catalogID));
			request.setAttribute("catalog", catalog);
		}
		if(catalogID!=null&&!("").equals(catalogID)){
//			openContents.setCatalogID(catalogID);
//			openContents.setStatus("1");
//			List<OpenContents> list = new ArrayList<OpenContents>();
//			list = this.frontOpenContentsServices.queryOpenContentsList(openContents);
			List<OpenContents> list = new ArrayList<OpenContents>();
			if(Integer.valueOf(catalogID) != 48 && Integer.valueOf(catalogID) != 67){
				list = this.queryLeafCataContentsList(catalogID, list);
			}else{
				String ids = "48,67";
				list = frontOpenContentsServices.queryOCListByIDs(ids);
				System.out.println(">>>>>>>>>>>>>>>>>>"+list.size());
			}
			request.setAttribute("list", list);
		}
		return SUCCESS;
	}
	
	public String frontOpenContentsDetail(){
		int theID = Integer.valueOf(request.getParameter("theID"));
		OpenContents openContents = frontOpenContentsServices.frontOpenContentsDetail(theID);
		
		User user = new User();
		user.setId(Integer.valueOf(openContents.getCreater_pid()));
		user = userServices.queryUserByBean(user);
		openContents.setUserName(user.getRealName());
		
		request.setAttribute("openContents", openContents);
		return SUCCESS;
	}

	/**
	 * 根据某个catalogID查找其子id的所有内容
	 * @param theID
	 * @param contentsList
	 * @return
	 */
	public List<OpenContents> queryLeafCataContentsList(String theID,List<OpenContents> contentsList){
		if(theID != null){
			OpenCatalog temp = new OpenCatalog();
			temp.setParentID(theID);
			temp.setStatus("1");
			List<OpenCatalog> list = frontOpenCatalogServices.queryOpenCatalogList(temp);
			if(list != null && list.size() > 0){//存在子栏目
				for(int i = 0;i < list.size();i++){
					OpenCatalog oc = list.get(i);
					contentsList = this.queryLeafCataContentsList(oc.getTheID().toString(),contentsList);//递归
				}
			}else{
				//不存在子栏目（即叶节点），直接查询内容
				OpenContents oc = new OpenContents();
				oc.setCatalogID(theID);
				oc.setStatus("1");
				List<OpenContents> tempList = frontOpenContentsServices.queryOpenContentsList(oc);
				for(int i = 0;i < tempList.size();i++){
					contentsList.add(tempList.get(i));
				}
			}
		}
		return contentsList;
	}
	
	public UserServices getUserServices() {
		return userServices;
	}

	public void setUserServices(UserServices userServices) {
		this.userServices = userServices;
	}
	
	
	
}
