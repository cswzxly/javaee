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

import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.fastjson.JSONObject;
import com.system.pojo.Catalog;
import com.system.pojo.FileInfo;
import com.system.services.CatalogServices;
import com.system.services.FileInfoServices;

public class FileInfoAction extends BaseAction{
	@Resource(name="fileInfoServices")
	private FileInfoServices fileInfoServices;
	@Autowired
	private CatalogServices catalogServices;
	private Integer theID;
	private Integer contentID;
	private String fileType;
	private String title;
	private String fileUrl;
	private String isshow;
	private String source;
	private Integer sort;
	private String isindex;
	private String fileMode;
	private String catalogID;
	private String releaseDate;
	
	private File uploadinfo;
	private String uploadinfoContentType;
	private String uploadinfoFileName;
	
	public String fileInfoPage(){
		request.setAttribute("contentID", request.getParameter("contentID"));
		String open = request.getParameter("open");
		if(open!=null&&!"".equals(open)){
			request.setAttribute("open", open);
		}		
		return SUCCESS;
	}
	
	/**
	 * 文件列表
	 */
	public void fileInfoList(){
		logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>FileInfoAction:fileInfoList");
		 PrintWriter pw = null;
	        try{
	            this.getResponse().setCharacterEncoding("UTF-8");
	            pw = this.getResponse().getWriter();
	            Map<String,Object> map = new HashMap<String, Object>();
	            FileInfo fi = new FileInfo();
	            fi.setContentID(contentID);
	            List<FileInfo> list =  fileInfoServices.queryFileInfoListByBean(fi);
	            for(FileInfo fInfo:list){
	            	fInfo.setFileTypeName(fInfo.getFileType().equals("1")?"图片":"文件");
	            	fInfo.setIsshowName(fInfo.getIsshow().equals("1")?"是":"否");
	            	fInfo.setIsindexName(fInfo.getIsindex().equals("1")?"是":"否");
	            }
	            map.put("total",list.size());
	            map.put("rows",list);
	            String open = request.getParameter("open");
	    		if(open!=null&&!"".equals(open)){
	    			request.setAttribute("open", open);
	    		}	            
	            String result = JSONObject.toJSONString(map);
	            pw.write(result);
	        }catch (Exception e){
	            e.printStackTrace();
	        }
	        pw.flush();
	        pw.close();
	}
	
	/**
	 * 保存上传文件
	 * @throws IOException
	 */
	public void uploader() throws IOException{
		PrintWriter pw = null;
        this.getResponse().setCharacterEncoding("UTF-8");
        pw = this.getResponse().getWriter();
        String ID = request.getParameter("theID");
        String result="";
        FileOutputStream fos = null;
        FileInputStream fis = null;
        try {
        	String urlPath = "uploads/fileInfo/";
        	String path = request.getSession().getServletContext().getRealPath("/");
        	String realPath = path+urlPath;
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
        	
        	FileInfo f = new FileInfo();
        	f.setTheID(Integer.valueOf(ID));
        	f.setFileUrl(urlPath+fileName);
        	fileInfoServices.updateFileInfo(f);
        	result = "success";
            pw.write(result);
        } catch (Exception e) {
            e.printStackTrace();
        }
        pw.flush();
        pw.close();
	}
	
	/**
	 * 保存新建文件资料
	 */
	public void saveNewFileInfo(){
		PrintWriter pw = null;
        try{
        	
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            Map<String,Object> map = new HashMap<String,Object>();
            String result;           
            FileInfo fileInfo = new FileInfo();
            fileInfo.setContentID(contentID);
            fileInfo.setTitle(title);
            fileInfo.setSort(Integer.valueOf(sort));
            fileInfo.setIsshow(isshow);
            fileInfo.setFileType(fileType);
            fileInfo.setIsindex(isindex);
            fileInfo.setFileMode("t_contents");
            fileInfo.setReleaseDate(releaseDate);
            
            fileInfoServices.insertFileInfo(fileInfo);
            result = "success";
            map.put("result", result);
            map.put("fileInfoID", fileInfo.getTheID());//返回新建记录的id
            String strMap = JSONObject.toJSONString(map);
            pw.write(strMap);
        }catch (Exception e){
            e.printStackTrace();
        }
        pw.flush();
        pw.close();
	}
	
	/**
	 * 检查图片是否存在首页显示
	 */
	public void checkIndex(){
		PrintWriter pw = null;
        try{
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            int count;
            FileInfo fileInfo = new FileInfo();
            fileInfo.setContentID(contentID);
            fileInfo.setIsindex("1");
            count = fileInfoServices.countPicIndex(fileInfo);
            String result = "";
            if(count > 0){
            	result = "1";
            }else{
            	result = "0";
            }
            pw.write(result);
        }catch(Exception e){
        	e.printStackTrace();
        }
        pw.flush();
        pw.close();
	}
	
	/**
	 * 删除文件资料
	 */
	public void deleteFileInfo(){
		 PrintWriter pw = null;
		 try{
			 this.getResponse().setCharacterEncoding("UTF-8");
			 pw = this.getResponse().getWriter();
			 String result;
			 FileInfo f = new FileInfo();
			 f.setTheID(Integer.valueOf(theID));
			 f = fileInfoServices.queryFileInfoByBean(f);
			 if(f!=null){	                
				 fileInfoServices.deleteFileInfo(f);
				 result = "success";
	                
				 //删除源文件
				 
				 String webappPath = request.getSession().getServletContext().getRealPath("/");
				 String filePath = webappPath + f.getFileUrl();
				 this.deleteSourceFile(filePath);
				 
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
	
	/**
	 * 保存编辑的文件资料
	 */
	public void saveEditFileInfo(){
		PrintWriter pw = null;
        try{
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            String result;
            FileInfo f = new FileInfo();
            f.setTheID(Integer.valueOf(theID));
            f = fileInfoServices.queryFileInfoByBean(f);
            if(f!=null){
                f.setTitle(title);
                f.setFileType(fileType);
                f.setIsindex("0");
                f.setSort(sort);
                f.setIsshow(isshow);
                fileInfoServices.updateFileInfo(f);
                result = "success";
            }else {
                result = "fail";
            }
            pw.write(result);
        }catch (Exception e){
            e.printStackTrace();
        }
        pw.flush();
	}
	
	public void saveTheNewFile(){
		PrintWriter pw = null;
        try{
        	
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            Map<String,Object> map = new HashMap<String,Object>();
            String result;           
            FileInfo fileInfo = new FileInfo();
            fileInfo.setContentID(null);
            fileInfo.setTitle(title);
            fileInfo.setSort(Integer.valueOf(sort));
            fileInfo.setIsshow(isshow);
            fileInfo.setFileType(fileType);
            fileInfo.setIsindex(isindex);
            fileInfo.setFileMode("t_fileinfo");
            fileInfo.setCatalogID(Integer.valueOf(catalogID));
            fileInfo.setReleaseDate(releaseDate);
            fileInfoServices.insertFileInfo(fileInfo);
            result = "success";
            map.put("result", result);
            map.put("fileInfoID", fileInfo.getTheID());//返回新建记录的id
            String strMap = JSONObject.toJSONString(map);
            pw.write(strMap);
        }catch (Exception e){
            e.printStackTrace();
        }
        pw.flush();
        pw.close();
	}
	
	public String newTheFileInfoPage(){
		request.setAttribute("catalogID", catalogID);
		Catalog catalogT = new Catalog();
		if(catalogID != null){
			catalogT.setTheID(Integer.valueOf(catalogID));
		}else{
			catalogT.setTheID(10);
		}
		Catalog catalog = catalogServices.queryCatalogByBean(catalogT);
		request.setAttribute("catalog", catalog);
		return "success";
	}
	
	public String showTheFileInfoPage(){
		if(theID != null){
			FileInfo fileInfo = new FileInfo();
			fileInfo.setTheID(Integer.valueOf(theID));
			fileInfo = fileInfoServices.queryFileInfoByBean(fileInfo);
			request.setAttribute("fileInfo", fileInfo);
			
			Catalog catalog = new Catalog();
			catalog.setTheID(fileInfo.getCatalogID());
			catalog = catalogServices.queryCatalogByBean(catalog);
			request.setAttribute("catalog", catalog);
		}
		return "success";
	}
	
	public void saveTheEditFile(){
		PrintWriter pw = null;
        try{
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            Map<String,Object> map = new HashMap<String,Object>();
            String result;           
            FileInfo fileInfo = new FileInfo();
            fileInfo.setTheID(theID);
            fileInfo = fileInfoServices.queryFileInfoByBean(fileInfo);
            fileInfo.setTitle(title);
            fileInfo.setIsshow(isshow);
            fileInfo.setReleaseDate(releaseDate);
            fileInfoServices.updateFileInfo(fileInfo);
            
            result = "success";
            map.put("result", result);
            map.put("fileInfoID", fileInfo.getTheID());//返回新建记录的id
            String strMap = JSONObject.toJSONString(map);
            pw.write(strMap);
        }catch(Exception e){
        	e.printStackTrace();
        }
        pw.flush();
        pw.close();
	}
	
	public void coverOldFile() throws IOException{
		PrintWriter pw = null;
        this.getResponse().setCharacterEncoding("UTF-8");
        pw = this.getResponse().getWriter();
        String ID = request.getParameter("theID");
        FileInfo fileInfo = new FileInfo();
        fileInfo.setTheID(Integer.valueOf(ID));
        fileInfo = fileInfoServices.queryFileInfoByBean(fileInfo);
        String result="";
        FileOutputStream fos = null;
        FileInputStream fis = null;
        try {
        	String urlPath = "uploads/fileInfo/";
        	String path = request.getSession().getServletContext().getRealPath("/");
        	String realPath = path+urlPath;
        	File filePath = new File(realPath);
        	if(!filePath.exists()){
        		filePath.mkdirs();
        	}
        	String suffix = uploadinfoFileName.substring(uploadinfoFileName.lastIndexOf(".")).toLowerCase();
        	String fileName = ID+suffix;
        	if(!fileInfo.getFileUrl().equals(realPath+fileName)){//原文件与新文件为不同格式
        		this.deleteSourceFile(request.getSession().getServletContext().getRealPath("/")+fileInfo.getFileUrl());
        		File saveFile = new File(realPath+fileName);
            	fos = new FileOutputStream(saveFile);
            	fis = new FileInputStream(this.getUploadinfo());
            	byte[] b = new byte[fis.available()];
            	int readSize = fis.read(b);
            	while(readSize>-1){
            		fos.write(b,0,readSize);
            		readSize = fis.read();
            	}

            	FileInfo f = new FileInfo();
            	f.setTheID(Integer.valueOf(ID));
            	f.setFileUrl(urlPath+fileName);
            	fileInfoServices.updateFileInfo(f);
        	}else{//原文件与新文件为同一格式
        		File saveFile = new File(realPath+fileName);
            	fos = new FileOutputStream(saveFile);
            	fis = new FileInputStream(this.getUploadinfo());
            	byte[] b = new byte[fis.available()];
            	int readSize = fis.read(b);
            	while(readSize>-1){
            		fos.write(b,0,readSize);
            		readSize = fis.read();
            	}
        	}
        	fos.close();
        	fis.close();
        	
        	result = "success";
            pw.write(result);
        } catch (Exception e) {
            e.printStackTrace();
        }
        pw.flush();
        pw.close();
	}
	
	/**
	 * 删除原文件
	 * @param filePath
	 */
	public void deleteSourceFile(String filePath){
		if(filePath != null){
			System.out.println("++++++++++++++++++++++++"+filePath);
			File file = new File(filePath);
			System.out.println("++++++++++++++++++++++++"+file.delete());
		}
	}
	
	public Integer getTheID() {
		return theID;
	}

	public void setTheID(Integer theID) {
		this.theID = theID;
	}

	public Integer getContentID() {
		return contentID;
	}

	public void setContentID(Integer contentID) {
		this.contentID = contentID;
	}

	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getFileUrl() {
		return fileUrl;
	}

	public void setFileUrl(String fileUrl) {
		this.fileUrl = fileUrl;
	}

	public String getIsshow() {
		return isshow;
	}

	public void setIsshow(String isshow) {
		this.isshow = isshow;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public FileInfoServices getFileInfoServices() {
		return fileInfoServices;
	}

	public void setFileInfoServices(FileInfoServices fileInfoServices) {
		this.fileInfoServices = fileInfoServices;
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

	public String getIsindex() {
		return isindex;
	}

	public void setIsindex(String isindex) {
		this.isindex = isindex;
	}

	public String getFileMode() {
		return fileMode;
	}

	public void setFileMode(String fileMode) {
		this.fileMode = fileMode;
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
	
	
	
}
