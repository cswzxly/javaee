package com.web.action;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;

import com.github.pagehelper.PageInfo;
import com.system.action.BaseAction;
import com.system.pojo.OpenCatalog;
import com.system.pojo.OpenContents;
import com.system.pojo.User;
import com.system.pojo.ZlCatalog;
import com.system.pojo.ZlContents;
import com.system.services.UserServices;
import com.web.services.FrontOpenCatalogServices;
import com.web.services.FrontOpenContentsServices;
import com.web.utils.Arithmetic;

public class FrontOpenContentsAction extends BaseAction {

	private static final long serialVersionUID = 1L;
	
	@Resource(name="frontOpenContentsServices")
	private FrontOpenContentsServices frontOpenContentsServices;	
	
	@Resource(name="frontOpenCatalogServices")
	private FrontOpenCatalogServices frontOpenCatalogServices;
	
	@Autowired
	private UserServices userServices;

	public String frontOpenContentsRight(){
		
	//	OpenContents openContents = new OpenContents();
		String catalogID = request.getParameter("theID");
		
		logger.info("lylylyylylyllylylylylylylylylylylylyly"+catalogID);
	    if (catalogID == null ||catalogID == "") {
            catalogID = "46";//给一个默认值
        }
	    
	    logger.info("lylylyylylyllylylylylylylylylylylylyly"+catalogID);
		OpenCatalog catalog = this.getCatalogByID(catalogID);
		
		
		
		logger.info("yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy"+catalog);
		 request.setAttribute("catalog", catalog);
		 List<OpenCatalog> leftCatalogList = this.findChildCatalogs(catalogID);
		 logger.info("1111111111111111111"+leftCatalogList); 
		 OpenCatalog leftCatalog = new OpenCatalog();
//		 if(catalogID!=null&&!"".equals(catalogID)){
//			OpenCatalog catalog = frontOpenCatalogServices.queryOpenCatalogByBean(Integer.valueOf(catalogID));
//			request.setAttribute("catalog", catalog);
//		}
//		 
		 
//		if(catalogID!=null&&!("").equals(catalogID)){
////			openContents.setCatalogID(catalogID);
////			openContents.setStatus("1");
////			List<OpenContents> list = new ArrayList<OpenContents>();
////			list = this.frontOpenContentsServices.queryOpenContentsList(openContents);
//			List<OpenContents> list = new ArrayList<OpenContents>();
//			if(Integer.valueOf(catalogID) != 48 && Integer.valueOf(catalogID) != 67){
//				list = this.queryLeafCataContentsList(catalogID, list);
//			}else{
//				String ids = "48,67";
//				list = frontOpenContentsServices.queryOCListByIDs(ids);
//				System.out.println(">>>>>>>>>>>>>>>>>>"+list.size());
//			}
//			request.setAttribute("list", list);
//		}
		  if (leftCatalogList == null || leftCatalogList.size() <= 0) {//如果不存在子栏目
	            if (catalog.getParentID().equals("0")) {
	                leftCatalog.setTheID(catalog.getTheID());
	            } else {
	                leftCatalog.setParentID(catalog.getParentID());
	            }
	            leftCatalog.setStatus("1");
	            leftCatalogList = this.initLeftCatalog(leftCatalog);
	        }
		  request.setAttribute("leftCatalogList", leftCatalogList);
	      Arithmetic des = new Arithmetic();
	      if (catalog != null) {
	           logger.debug(">>>>>>>>>>>>>>>>>>>>>>> catalogType : " + catalog.getCatalogType());
	           if (catalog.getCatalogType().equals("t_contents")) {
	        		
	        	   List<Integer> catalogIDList = new ArrayList<Integer>();
	            	
	        	   catalogIDList = this.queryLeafCatalogIDList(catalog.getTheID().toString(), catalogIDList);
	            	Integer[] ids = new Integer[catalogIDList.size()];
	            	for(int i = 0;i < catalogIDList.size();i++){
	            		ids[i] = catalogIDList.get(i);
	            	}
	             OpenContents openContents = new OpenContents();
	             openContents.setIds(ids);
	             PageInfo<OpenContents> contentsList = frontOpenContentsServices.queryContentsByIds(openContents, getPageNum(), getPageSize());
	            	
	              	 if(contentsList != null && contentsList.getList().size() > 0){
	                  	for(OpenContents c : contentsList.getList()){
	                  		c.setDesId(des.getEncString(c.getTheID().toString()));
	                  	}
	                  }
	              	  logger.debug(">>>>>>>>>>>>>>>>>>>>>>>  contentsList : " +  contentsList);
	              	  request.setAttribute("contentsList", contentsList);
	           }
	      }
	      request.setAttribute("theID", catalogID);
		return SUCCESS;
	}
	
	private List<Integer> queryLeafCatalogIDList(String catalogID,
			List<Integer> ids) {
		if(catalogID != null){
			OpenCatalog temp = new OpenCatalog();
            temp.setParentID(catalogID);
            temp.setStatus("1");
            List<OpenCatalog> list = frontOpenCatalogServices.queryCatalogListByBean(temp);
            if (list != null && list.size() > 0) {//存在子栏目
                for (int i = 0; i < list.size(); i++) {
                	OpenCatalog c = list.get(i);
                    ids = this.queryLeafCatalogIDList(c.getTheID().toString(), ids);//递归
                }
            } else {
                //不存在子栏目（即叶节点），直接加入到集合中
            	ids.add(Integer.valueOf(catalogID));
            	
            }
    	}
    	return ids;
	}

	private List<OpenCatalog> initLeftCatalog(OpenCatalog catalog) {
		  if (catalog == null) {
	            catalog = new OpenCatalog();
	            catalog.setParentID("1");
	            catalog.setStatus("1");
	        }
		  List<OpenCatalog> list = frontOpenCatalogServices.queryCatalogListByBean(catalog);
	        return list;
	}

	private List<OpenCatalog> findChildCatalogs(String catalogID) {
		OpenCatalog catalog = new OpenCatalog();
        catalog.setParentID(catalogID);
        catalog.setStatus("1");
        List<OpenCatalog> list =frontOpenCatalogServices.queryCatalogListByBean(catalog);
        return list;
	}

	private OpenCatalog getCatalogByID(String catalogID) {
		OpenCatalog temp = new OpenCatalog();
        temp.setTheID(Integer.valueOf(catalogID));
        OpenCatalog catalog = frontOpenCatalogServices.queryCatalogByBean(temp);
        return catalog;
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
