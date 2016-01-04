package com.system.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.system.pojo.ZlCatalog;
import com.system.services.ZlCatalogServices;
import com.system.utils.CatalogHelper;

public class ZlCatalogAction  extends BaseAction{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Resource(name="zlCatalogServices")
	private ZlCatalogServices zlCatalogServices;	
	private String theID;
	private String title;
	private String catalogType;
	private String sort;
	private String url;
	private String status;
	private String isUploadPic;
	private String parentID;	
	private File uploadinfo;
	private String uploadinfoContentType;
	private String uploadinfoFileName;

	public String getParentID() {
		return parentID;
	}

	public void setParentID(String parentID) {
		this.parentID = parentID;
	}
		
	public String getTheID() {
		return theID;
	}

	public void setTheID(String theID) {
		this.theID = theID;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getCatalogType() {
		return catalogType;
	}

	public void setCatalogType(String catalogType) {
		this.catalogType = catalogType;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getIsUploadPic() {
		return isUploadPic;
	}

	public void setIsUploadPic(String isUploadPic) {
		this.isUploadPic = isUploadPic;
	}

	public File getUploadinfo() {
		return uploadinfo;
	}

	public void setUploadinfo(File uploadinfo) {
		this.uploadinfo = uploadinfo;
	}

	public String getUploadinfoContentType() {
		return uploadinfoContentType;
	}

	public void setUploadinfoContentType(String uploadinfoContentType) {
		this.uploadinfoContentType = uploadinfoContentType;
	}

	public String getUploadinfoFileName() {
		return uploadinfoFileName;
	}

	public void setUploadinfoFileName(String uploadinfoFileName) {
		this.uploadinfoFileName = uploadinfoFileName;
	}

	
	
	
	
	public String zlCatalogPage(){
        return SUCCESS;
    }
	
	public void zlshowCatalogTree(){
		 PrintWriter pw = null;
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
	
	public void zlcatalogList(){
		 PrintWriter pw = null;
	        try{
	            this.getResponse().setCharacterEncoding("UTF-8");
	            pw = this.getResponse().getWriter();
	            Map<String,Object> map = new HashMap<String, Object>();
	            ZlCatalog c = new ZlCatalog();
	            c.setParentID(parentID);
	            c.setStatus("1");
	            List<ZlCatalog> list =  zlCatalogServices.queryCatalogListByBean(c);
	            for(ZlCatalog ca:list){
	            	ca.setCatalogTypeName(CatalogHelper.getNameByCatalogType(ca.getCatalogType()));
	            	ca.setStatusName(ca.getStatus()=="1"?"停用":"启用");
	            }
	            map.put("total",list.size());
	            map.put("rows",list);
	            String result = JSONObject.toJSONString(map);
	            pw.write(result);
	        }catch (Exception e){
	            e.printStackTrace();
	        }
	        pw.flush();
	        pw.close();
	}

	public void zlsaveNewCatalog(){
		PrintWriter pw = null;
        try{
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            String result;           
            ZlCatalog c = new ZlCatalog();
            c.setParentID(parentID);
            c.setStatus(status);
            c.setTitle(title);
            c.setSort(Integer.valueOf(sort));
            c.setUrl(url);
            c.setCatalogType(catalogType);
            c.setIsFirstCatalog("0");
            c.setIsUploadPic(isUploadPic);
            zlCatalogServices.insertCatalog(c);
            result = "success";
            
            pw.write(result);
        }catch (Exception e){
            e.printStackTrace();
        }
        pw.flush();
        pw.close();
	}
	
	
	public void zlsaveEditCatalog(){
        PrintWriter pw = null;
        try{
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            String result;
            ZlCatalog c = new ZlCatalog();
            c.setTheID(Integer.valueOf(theID));
            c = zlCatalogServices.queryCatalogByBean(c);
            if(c!=null){
                c.setTitle(title);
                c.setCatalogType(catalogType);
                c.setSort(Integer.valueOf(sort));
                c.setStatus(status);
                c.setUrl(url);
                c.setIsFirstCatalog("0");
                c.setIsUploadPic(isUploadPic);
                zlCatalogServices.updateCatalog(c);
                result = "success";
            }else {
                result = "fail";
            }
            pw.write(result);
        }catch (Exception e){
            e.printStackTrace();
        }
        pw.flush();
        pw.close();
    }
	
	public void zluploader() throws IOException{
		PrintWriter pw = null;
        this.getResponse().setCharacterEncoding("UTF-8");
        pw = this.getResponse().getWriter();
        String ID = request.getParameter("theID");
        String result="";
        FileOutputStream fos = null;
        FileInputStream fis = null;
        try {
        	String urlPath = "/uploads/zt/pic/";
        	String classpath = ZlCatalogAction.class.getResource("/").getPath();
        	String path = classpath.substring(0,classpath.length()-"WEB-INF/classes/".length());
        	String realPath = path+urlPath;
//        	System.out.println(">>>>"+realPath);
        	File filePath = new File(realPath);
        	if(!filePath.exists()){
        		filePath.mkdirs();
        	}
        	String suffix = uploadinfoFileName.substring(uploadinfoFileName.lastIndexOf(".")).toLowerCase();
        	String fileName = ID+suffix;
        	File saveFile = new File(realPath+fileName);
        	fos = new FileOutputStream(saveFile);
        	fis = new FileInputStream(this.getUploadinfo());
        	byte[] b = new byte[fis.available()];
        	int readSize = fis.read(b);
        	while(readSize>-1){
        		fos.write(b,0,readSize);
        		readSize = fis.read();
        	}
        	fos.close();
        	fis.close();
            pw.write(result);
        } catch (Exception e) {
            e.printStackTrace();
        }
        pw.flush();
        pw.close();
	}
	
	
	 public void zldeleteCatalog(){
	        PrintWriter pw = null;
	        try{
	            this.getResponse().setCharacterEncoding("UTF-8");
	            pw = this.getResponse().getWriter();
	            String result;
	            ZlCatalog c = new ZlCatalog();
	            c.setTheID(Integer.valueOf(theID));
	            c = zlCatalogServices.queryCatalogByBean(c);
	            if(c!=null){	                
	            	zlCatalogServices.deleteCatalog(c);
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
	 }


