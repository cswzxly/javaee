package com.system.action;

/**
 *@author linxc
 *20140731 
 */
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.system.bean.AllClassBean;
import com.system.pojo.Catalog;
import com.system.pojo.Contents;
import com.system.pojo.OpenCatalog;
import com.system.pojo.OpenContents;
import com.system.pojo.User;
import com.system.pojo.ZlCatalog;
import com.system.services.LinksServices;
import com.system.services.OpenCatalogServices;
import com.system.services.OpenContentsServices;
import com.system.services.VideoServices;
import com.system.utils.DateUtils;

public class OpenContentsAction extends BaseAction {
	@Resource(name="openContentsServices")
	private OpenContentsServices openContentsServices;
	@Resource(name="openCatalogServices")
	private OpenCatalogServices openCatalogServices;
	@Autowired
	private VideoServices videoServices;
	@Autowired
	private LinksServices linksServices;
	
	private String theID;
	private String catalogID;
	private String releaseDate;
	private String title;
	private String source;
	private String contents;
	private String status;  
	private String conCode;
	
	
	
	
	public String openContentsPage(){
		request.setAttribute("catalogID", catalogID);
		OpenCatalog catalogT = new OpenCatalog();
		if(catalogID != null){
			catalogT.setTheID(Integer.valueOf(catalogID));
		}else{
			catalogT.setTheID(10);
		}
		OpenCatalog catalog = openCatalogServices.queryOpenCatalogByBean(catalogT);
		request.setAttribute("catalog", catalog);
        return SUCCESS;
    }
	
	public void showOpenTree(){
		 PrintWriter pw = null;
		 String cid = request.getParameter("cid");
		 Set<Integer> cids = new HashSet<Integer>();
		 if(cid !=null&&!"".equals(cids)){
			 cids.add(Integer.valueOf(cid));
			 cids = this.getParentOpenCatalog(Integer.valueOf(cid),cids);
		 }
		 JSONArray ja = new JSONArray();
	        try{
	            this.getResponse().setCharacterEncoding("UTF-8");
	            pw = this.getResponse().getWriter();
	            OpenCatalog c = new OpenCatalog();
	            c.setStatus("1");
	            List<OpenCatalog> catalogList = openCatalogServices.queryOpenCatalogListByBean(c);   
	            for(OpenCatalog cTemp:catalogList){
	            	JSONObject json = new JSONObject();
	            	json.put("id", cTemp.getTheID());
	            	json.put("pId", cTemp.getParentID());
	            	json.put("name", cTemp.getTitle());
	            	if(cids !=null&& cids.size()>0){
	            		for(Integer id : cids){
	            			if(cTemp.getTheID() == id.intValue()){
	            				json.put("open", true);
	            			}
	            		}
	            	}else{
	            		json.put("open", false);
	            	}
	            	ja.add(json);
	            }
	            	            	            
	            String result = JSONObject.toJSONString(ja);
	            pw.write(result);
	        }catch (Exception e){
	            e.printStackTrace();
	        }
	        pw.flush();
	        pw.close();
	}
	
	public void openContentsList(){
		 PrintWriter pw = null;
	        try{
	            this.getResponse().setCharacterEncoding("UTF-8");
	            pw = this.getResponse().getWriter();
	            OpenCatalog catalogT = new OpenCatalog();
	    		catalogT.setTheID(Integer.valueOf(catalogID));
	    		OpenCatalog catalog = openCatalogServices.queryOpenCatalogByBean(catalogT);
	    		List<AllClassBean> list = new ArrayList<AllClassBean>();
	    		if(catalog != null && catalog.getCatalogType() != null){
	    			Map<String,Object> map = new HashMap<String, Object>();
	    			if(catalog.getCatalogType().equals("t_contents")){//栏目类型为t_contents
	    				AllClassBean bean = new AllClassBean();
	    				bean.setCatalogID(Integer.valueOf(catalogID));
			            list = openContentsServices.getOpenContentsListByBean(bean);
			            for(AllClassBean temp : list){
			            	temp.setCatalogName(catalog.getTitle());
			            	temp.setStatusName(temp.getStatus().equals("0")?"停用":"启用");//将状态转化为中文
			            }
	    			}else if(catalog.getCatalogType().equals("t_video")){//栏目类型为t_video
	    				AllClassBean bean = new AllClassBean();
	    				bean.setCatalogID(Integer.valueOf(catalogID));
	    				list = videoServices.getVideoListByBean(bean);
				        for(AllClassBean temp : list){
				            temp.setCatalogName(catalog.getTitle());
				           	temp.setStatusName(temp.getStatus().equals("0")?"停用":"启用");//将状态转化为中文
				        }
	    			}else if(catalog.getCatalogType().equals("t_links")){//栏目类型为友情连接
	    				AllClassBean bean = new AllClassBean();
	    				bean.setCatalogID(Integer.valueOf(catalogID));
	    				bean.setLinkKind("1");//友情连接
	    				list = linksServices.getLinksListByBean(bean);
	    				for(AllClassBean temp : list){
	    					temp.setCatalogName(catalog.getTitle());
	    					temp.setStatusName(temp.getStatus().equals("0")?"停用":"启用");//将状态转化为中文
	    					if(temp.getLink_type().equals("1")){
	    						temp.setLinkTypeName("图片");
	    					}else{
	    						temp.setLinkTypeName("下拉框");
	    						if(temp.getSelect_type().equals("1")){
	    							temp.setSelectTypeName("中央政府部门网站");
	    						}else if(temp.getSelect_type().equals("2")){
	    							temp.setSelectTypeName("省市政府部门网站");
	    						}else if(temp.getSelect_type().equals("3")){
	    							temp.setSelectTypeName("省级机关网站");
	    						}else if(temp.getSelect_type().equals("4")){
	    							temp.setSelectTypeName("公共服务单位网站");
	    						}else if(temp.getSelect_type().equals("5")){
	    							temp.setSelectTypeName("其他友情连接");
	    						}
	    					}
	    				}
	    			}else if(catalog.getCatalogType().equals("t_services")){//栏目类型为便民服务
	    				AllClassBean bean = new AllClassBean();
	    				bean.setCatalogID(Integer.valueOf(catalogID));
	    				bean.setLinkKind("2");
	    				list = linksServices.getLinksListByBean(bean);
	    				for(AllClassBean temp : list){
	    					temp.setCatalogName(catalog.getTitle());
	    					temp.setStatusName(temp.getStatus().equals("0")?"停用":"启用");//将状态转化为中文
	    					
	    				}
	    			}else{
	    				
	    			}
	    			map.put("total",list.size());
			        map.put("rows",list);
			        map.put("catalogType", catalog.getCatalogType());//返回当前栏目的栏目类型
			        map.put("catalogName", catalog.getTitle());
			        String result = JSONObject.toJSONString(map);
			        pw.write(result);
	    		}
	    		
	        }catch (Exception e){
	            e.printStackTrace();
	        }
	        pw.flush();
	        pw.close();
	}

	public String newOpenContentsPage(){
		
		//判断是否还有叶子节点
		OpenCatalog oc = new OpenCatalog();
		oc.setParentID(catalogID);
		List<OpenCatalog> list = openCatalogServices.queryOpenCatalogListByBean(oc);
		if(list.size()>0){
			return "list";   //如果还有叶子节点，不让其执行添加操作，返回列表
		}
		
		OpenCatalog catalogT = new OpenCatalog();
		catalogT.setTheID(Integer.valueOf(catalogID));
		OpenCatalog catalog = openCatalogServices.queryOpenCatalogByBean(catalogT);
		this.request.setAttribute("catalog", catalog);
		this.request.setAttribute("now", DateUtils.getNowTime());
		return "newOpenContentsPage";
	}
	
	public void saveNewOpenContents(){
		 PrintWriter pw = null;
		 User user = (User)this.getRequest().getSession().getAttribute("userInSession");
	        try{
                this.getResponse().setCharacterEncoding("UTF-8");
                pw = this.getResponse().getWriter();
                String result;           
                OpenContents c = new OpenContents();
                c.setTitle(title);
                c.setSource(source);
                c.setSort(0);
                c.setStatus(status);
                c.setCatalogID(catalogID);
                c.setContents(contents);
                c.setReleaseDate(releaseDate);
                c.setCreater_pid(String.valueOf(user.getId()));
                c.setCreate_date(DateUtils.getNowTime());
                c.setConCode(conCode);
                openContentsServices.insertOpenContents(c);
                result = "success";
                
                pw.write(result);
	        }catch (Exception e){
	            e.printStackTrace();
	        }
	        pw.flush();
	        pw.close();
	}
	
	public String showOpenContentsEdit(){
		OpenContents c = new OpenContents();
        c.setTheID(Integer.valueOf(theID));
        OpenContents contents =  openContentsServices.queryOpenContentsByBean(c);
        OpenCatalog catalogT = new OpenCatalog();
		catalogT.setTheID(Integer.valueOf(contents.getCatalogID()));
		OpenCatalog catalog = openCatalogServices.queryOpenCatalogByBean(catalogT);
		
		request.setAttribute("catalog", catalog);
        request.setAttribute("contents", contents);
        this.request.setAttribute("now", DateUtils.getNowTime());
		return "showOpenContentsEdit";
	}
	
	public void saveEditOpenContents(){
		 PrintWriter pw = null;
		 User user = (User)this.getRequest().getSession().getAttribute("userInSession");
		 OpenContents c = new OpenContents();
	     c.setTheID(Integer.valueOf(theID));
	     OpenContents contentsT =  openContentsServices.queryOpenContentsByBean(c);
	     String result;    
	     try{
               this.getResponse().setCharacterEncoding("UTF-8");
               pw = this.getResponse().getWriter();
               contentsT.setTitle(title);
               contentsT.setSource(source);
               contentsT.setStatus(status);
               contentsT.setContents(contents);
               contentsT.setReleaseDate(releaseDate);
               contentsT.setUpdate_pid(String.valueOf(user.getId()));
               contentsT.setUpdate_date(DateUtils.getNowTime());
               contentsT.setConCode(conCode);
               openContentsServices.updateOpenContents(contentsT);
               result = "success";
    
	        }catch (Exception e){
	        	result = "error";
	            e.printStackTrace();
	        }
	     	pw.write(result);
	        pw.flush();
	        pw.close();
	}
	
	public void deleteOpenContents(){
        PrintWriter pw = null;
        try{
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            String result;
            OpenContents c = new OpenContents();
   	     	c.setTheID(Integer.valueOf(theID));
   	     	OpenContents contentsT =  openContentsServices.queryOpenContentsByBean(c);
            if(contentsT!=null){	                
            	openContentsServices.deleteOpenContents(contentsT);
                result = "success";	                
            }else{
                result = "fail";
            }
            pw.write(result);
        }catch (Exception e){
            e.printStackTrace();
        }
        pw.flush();
        pw.close();
    }
	
	private Set<Integer> getParentOpenCatalog(Integer catalogId,Set<Integer> ids){
		 OpenCatalog c = new OpenCatalog();
		 c.setTheID(catalogId);
		 OpenCatalog catalog = openCatalogServices.queryOpenCatalogByBean(c);
		 if(catalog !=null){
			 if(Integer.valueOf(catalog.getParentID()) == 0){
				 ids.add(catalogId);
				 ids.add(Integer.valueOf(catalog.getParentID()));
				 return ids;
			 }else{
				 c.setTheID(Integer.valueOf(catalog.getParentID()));
				 OpenCatalog temp = openCatalogServices.queryOpenCatalogByBean(c);
				 if(temp!=null){
					 if(Integer.valueOf(temp.getParentID())!=0){
						 catalogId = Integer.valueOf(catalog.getParentID());
						 this.getParentOpenCatalog(catalogId, ids);
					 }else{
						 ids.add(catalogId);
						 ids.add(temp.getTheID());
					 }
				 }
			 }
		 }
		 return ids;
	 }	

	public OpenContentsServices getOpenContentsServices() {
		return openContentsServices;
	}

	public void setOpenContentsServices(OpenContentsServices openContentsServices) {
		this.openContentsServices = openContentsServices;
	}

	public OpenCatalogServices getOpenCatalogServices() {
		return openCatalogServices;
	}

	public void setOpenCatalogServices(OpenCatalogServices openCatalogServices) {
		this.openCatalogServices = openCatalogServices;
	}

	public String getTheID() {
		return theID;
	}

	public void setTheID(String theID) {
		this.theID = theID;
	}

	public String getCatalogID() {
		return catalogID;
	}

	public void setCatalogID(String catalogID) {
		this.catalogID = catalogID;
	}

	public String getReleaseDate() {
		return releaseDate;
	}

	public void setReleaseDate(String releaseDate) {
		this.releaseDate = releaseDate;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public VideoServices getVideoServices() {
		return videoServices;
	}

	public void setVideoServices(VideoServices videoServices) {
		this.videoServices = videoServices;
	}

	public LinksServices getLinksServices() {
		return linksServices;
	}

	public void setLinksServices(LinksServices linksServices) {
		this.linksServices = linksServices;
	}

	public String getConCode() {
		return conCode;
	}

	public void setConCode(String conCode) {
		this.conCode = conCode;
	}

	
}
