package com.system.action;

/**
 *@author linxc
 *20140731 
 */
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.system.pojo.User;
import com.system.pojo.ZlCatalog;
import com.system.pojo.ZlContents;
import com.system.services.ZlCatalogServices;
import com.system.services.ZlContentsServices;
import com.system.utils.DateUtils;

public class ZlContentsAction extends BaseAction {
	@Resource(name="zlContentsServices")
	private ZlContentsServices zlContentsServices;
	@Resource(name="zlCatalogServices")
	private ZlCatalogServices zlCatalogServices;
	
	private String theID;
	private String catalogID;
	private String releaseDate;
	private String title;
	private String source;
	private String contents;
	private String status;  
	private String conCode;
	private String secTitle;
	
	
	
	public String zlcontentsPage(){
		request.setAttribute("catalogID", catalogID);
		ZlCatalog catalogT = new ZlCatalog();
		if(catalogID != null){
			catalogT.setTheID(Integer.valueOf(catalogID));
		}else{
			catalogT.setTheID(10);
		}
		ZlCatalog catalog = zlCatalogServices.queryCatalogByBean(catalogT);
		request.setAttribute("catalog", catalog);
        return SUCCESS;
    }
	
	public void zlshowCatalogTree(){
		 PrintWriter pw = null;
		 String cid = request.getParameter("cid");
		 Set<Integer> cids = new HashSet<Integer>();
		 if(cid !=null&&!"".equals(cids)){
			 cids.add(Integer.valueOf(cid));
			 cids = this.getParentCatalog(Integer.valueOf(cid),cids);
		 }
		 JSONArray ja = new JSONArray();
	        try{
	            this.getResponse().setCharacterEncoding("UTF-8");
	            pw = this.getResponse().getWriter();
	            ZlCatalog c = new ZlCatalog();
	            c.setStatus("1");
	            List<ZlCatalog> catalogList = zlCatalogServices.queryCatalogListByBean(c);   
	            for(ZlCatalog cTemp:catalogList){
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
	
	public void zlcontentsList(){
		 PrintWriter pw = null;
	        try{
	            this.getResponse().setCharacterEncoding("UTF-8");
	            pw = this.getResponse().getWriter();
	            ZlCatalog catalogT = new ZlCatalog();
	    		catalogT.setTheID(Integer.valueOf(catalogID));
	    		ZlCatalog catalog = zlCatalogServices.queryCatalogByBean(catalogT);
	    		if(catalog != null){
		            Map<String,Object> map = new HashMap<String, Object>();
		            ZlContents contents = new ZlContents();
		            contents.setCatalogID(catalogID);
		            List<ZlContents> list =  zlContentsServices.queryContentsListByBean(contents);
		            for(ZlContents c : list){
		            	c.setCatalogName(catalog.getTitle());
		            	c.setStatusName(c.getStatus().equals("1")?"启用":"停用");
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

	public String zlnewContentsPage(){
		
		//判断是否还有叶子节点
		ZlCatalog zc = new ZlCatalog();
		zc.setParentID(catalogID);
		List<ZlCatalog> list = zlCatalogServices.queryCatalogListByBean(zc);
		if(list.size()>0){
			return "list";   //如果还有叶子节点，不让其执行添加操作，返回列表
		}
		
		ZlCatalog catalogT = new ZlCatalog();
		catalogT.setTheID(Integer.valueOf(catalogID));
		ZlCatalog catalog = zlCatalogServices.queryCatalogByBean(catalogT);
		
		this.request.setAttribute("catalog", catalog);
		this.request.setAttribute("now", DateUtils.getNowTime());
		return "newContentsPage";
	}
	
	public void zlsaveNewContents(){
		 PrintWriter pw = null;
		 User user = (User)this.getRequest().getSession().getAttribute("userInSession");
	        try{
                this.getResponse().setCharacterEncoding("UTF-8");
                pw = this.getResponse().getWriter();
                String result;           
                ZlContents c = new ZlContents();
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
                c.setSecTitle(secTitle);
                zlContentsServices.insertContents(c);
                result = "success";
                
                pw.write(result);
	        }catch (Exception e){
	            e.printStackTrace();
	        }
	        pw.flush();
	        pw.close();
	}
	
	public String zlshowContentsEdit(){
		ZlContents c = new ZlContents();
        c.setTheID(Integer.valueOf(theID));
        ZlContents contents =  zlContentsServices.queryContentsByBean(c);
        ZlCatalog catalogT = new ZlCatalog();
		catalogT.setTheID(Integer.valueOf(contents.getCatalogID()));
		ZlCatalog catalog = zlCatalogServices.queryCatalogByBean(catalogT);
		
		request.setAttribute("catalog", catalog);
        request.setAttribute("contents", contents);
        this.request.setAttribute("now", DateUtils.getNowTime());
		return "showContentsEdit";
	}
	
	public void zlsaveEditContents(){
		 PrintWriter pw = null;
		 User user = (User)this.getRequest().getSession().getAttribute("userInSession");
		 ZlContents c = new ZlContents();
	     c.setTheID(Integer.valueOf(theID));
	     ZlContents contentsT =  zlContentsServices.queryContentsByBean(c);
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
               contentsT.setSecTitle(secTitle);
               zlContentsServices.updateContents(contentsT);
               result = "success";
    
	        }catch (Exception e){
	        	result = "error";
	            e.printStackTrace();
	        }
	     	pw.write(result);
	        pw.flush();
	        pw.close();
	}
	
	public void zldeleteContents(){
        PrintWriter pw = null;
        try{
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            String result;
            ZlContents c = new ZlContents();
   	     	c.setTheID(Integer.valueOf(theID));
   	     	ZlContents contentsT =  zlContentsServices.queryContentsByBean(c);
            if(contentsT!=null){	                
            	zlContentsServices.deleteContents(contentsT);
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
	
	private Set<Integer> getParentCatalog(Integer catalogId,Set<Integer> ids){
		 ZlCatalog c = new ZlCatalog();
		 c.setTheID(catalogId);
		 ZlCatalog catalog = zlCatalogServices.queryCatalogByBean(c);
		 if(catalog !=null){
			 if(Integer.valueOf(catalog.getParentID()) == 0){
				 ids.add(catalogId);
				 ids.add(Integer.valueOf(catalog.getParentID()));
				 return ids;
			 }else{
				 c.setTheID(Integer.valueOf(catalog.getParentID()));
				 ZlCatalog temp = zlCatalogServices.queryCatalogByBean(c);
				 if(temp!=null){
					 if(Integer.valueOf(temp.getParentID())!=0){
						 catalogId = Integer.valueOf(catalog.getParentID());
						 this.getParentCatalog(catalogId, ids);
					 }else{
						 ids.add(catalogId);
						 ids.add(temp.getTheID());
					 }
				 }
			 }
		 }
		 return ids;
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

	public String getConCode() {
		return conCode;
	}

	public void setConCode(String conCode) {
		this.conCode = conCode;
	}

	public String getSecTitle() {
		return secTitle;
	}

	public void setSecTitle(String secTitle) {
		this.secTitle = secTitle;
	} 
	
	
}
