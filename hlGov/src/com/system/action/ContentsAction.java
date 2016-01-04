package com.system.action;

/**
 *@author linxc
 *20140731 
 */
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
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
import com.system.pojo.FileInfo;
import com.system.pojo.OpenCatalog;
import com.system.pojo.User;
import com.system.services.CatalogServices;
import com.system.services.ContentsServices;
import com.system.services.FileInfoServices;
import com.system.services.LinksServices;
import com.system.services.OpinionPollServices;
import com.system.services.RoleServices;
import com.system.services.VideoServices;
import com.system.utils.DateUtils;

public class ContentsAction extends BaseAction {
	@Resource(name="contentsServices")
	private ContentsServices contentsServices;
	@Resource(name="catalogServices")
	private CatalogServices catalogServices;
	@Autowired
	private VideoServices videoServices;
	@Autowired
	private LinksServices linksServices;
	@Autowired
	private FileInfoServices fileInfoServices;
	@Autowired
	private OpinionPollServices opinionPollServices;
	@Autowired
    private RoleServices roleServices;
	
	private String theID;
	private String catalogID;
	private String releaseDate;
	private String title;
	private String source;
	private String contents;
	private String status;  
	private String secTitle;
	private String isTop;
	private String author;
	
	private File content;
	private String contentFileName;
	private String contentContentType;
	
	private File filesrc;
	private String filesrcFileName;
	private String filesrcContentType;
	
	
	public String contentsPage(){
		request.setAttribute("catalogID", catalogID);
		logger.info(">>>>>>>>>>>>>>>>>>>catalogID:"+catalogID);
		Catalog catalogT = new Catalog();
		if(catalogID != null){
			catalogT.setTheID(Integer.valueOf(catalogID));
		}else{
			catalogT.setTheID(10);
		}
		Catalog catalog = catalogServices.queryCatalogByBean(catalogT);
		request.setAttribute("catalog", catalog);
        return SUCCESS;
    }
	
	public void showRee(){
		PrintWriter pw = null;
        String cid = request.getParameter("cid");
        Set<Integer> cids = new HashSet<Integer>();
        if (cid != null && !"".equals(cid)) {
            cids.add(Integer.valueOf(cid));
            cids = this.getParentCatalog(Integer.valueOf(cid), cids);
        }
        JSONArray ja = new JSONArray();
        try {
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            User user = (User) this.getRequest().getSession().getAttribute("userInSession");
            Integer size = roleServices.countRoleByAdmin(user);
            List<Catalog> catalogList;
            if (size > 0) {
                Catalog c = new Catalog();
                c.setStatus("1");
                catalogList = catalogServices.queryCatalogListByBean(c);
            } else {
                catalogList = catalogServices.queryCatalogListByUser(user);
            }
            for (Catalog cTemp : catalogList) {
                JSONObject json = new JSONObject();
                json.put("id", cTemp.getTheID());
                json.put("pId", cTemp.getParentID());
                json.put("name", cTemp.getTitle());
                if (cids != null && cids.size() > 0) {
                    for (Integer id : cids) {
                        if (cTemp.getTheID() == id.intValue()) {
                            json.put("open", true);
                        }
                    }
                } else {
                    json.put("open", false);
                }
                ja.add(json);
            }

            String result = JSONObject.toJSONString(ja);
            pw.write(result);
        } catch (Exception e) {
            e.printStackTrace();
        }
        pw.flush();
        pw.close();
	}
	
	public void contentsList(){
		 PrintWriter pw = null;
	        try{
	            this.getResponse().setCharacterEncoding("UTF-8");
	            pw = this.getResponse().getWriter();
	            User user = (User) this.getRequest().getSession().getAttribute("userInSession");
	            Catalog catalogT = new Catalog();
	    		catalogT.setTheID(Integer.valueOf(catalogID));
	    		Catalog catalog = catalogServices.queryCatalogByBean(catalogT);
	    		List<AllClassBean> list = new ArrayList<AllClassBean>();
	    		if(catalog != null && catalog.getCatalogType() != null){
	    			logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>catalog is not null or catalogType is not null");
	    			Map<String,Object> map = new HashMap<String, Object>();
	    			if(catalog.getCatalogType().equals("t_contents") || catalog.getCatalogType().equals("t_specialTopic")){//栏目类型为t_contents
	    				AllClassBean bean = new AllClassBean();
	    				bean.setCatalogID(Integer.valueOf(catalogID));
	    				bean.setTitle(title);
			            list = contentsServices.getContentsListByBean(bean);
			            for(AllClassBean temp : list){
			            	temp.setCatalogName(catalog.getTitle());
			            	temp.setStatusName(temp.getStatus().equals("0")?"停用":"启用");//将状态转化为中文
			            	temp.setIsTopName(temp.getIsTop().equals("0")?"否":"是");//将是否头条转化为中文
			            }
	    			}else if(catalog.getCatalogType().equals("t_video")){//栏目类型为t_video
	    				AllClassBean bean = new AllClassBean();
	    				bean.setCatalogID(Integer.valueOf(catalogID));
	    				bean.setTitle(title);
	    				list = videoServices.getVideoListByBean(bean);
				        for(AllClassBean temp : list){
				            temp.setCatalogName(catalog.getTitle());
				           	temp.setStatusName(temp.getStatus().equals("0")?"停用":"启用");//将状态转化为中文
				           	temp.setIsindexName(temp.getIsindex().equals("0")?"否":"是");
				        }
	    			}else if(catalog.getCatalogType().equals("t_links")){//栏目类型为友情连接
	    				AllClassBean bean = new AllClassBean();
	    				bean.setTitle(title);
	    				bean.setCatalogID(Integer.valueOf(catalogID));
	    				bean.setLinkKind("1");//友情连接
	    				list = linksServices.getLinksListByBean(bean);
	    				for(AllClassBean temp : list){
	    					temp.setCatalogName(catalog.getTitle());
	    					temp.setStatusName(temp.getStatus().equals("0")?"停用":"启用");//将状态转化为中文
	    					if(temp.getLink_type().equals("1")){
	    						temp.setLinkTypeName("图片");
	    					}else{
	    						temp.setLinkTypeName("所属框");
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
	    				bean.setTitle(title);
	    				bean.setLinkKind("2");
	    				list = linksServices.getLinksListByBean(bean);
	    				for(AllClassBean temp : list){
	    					temp.setCatalogName(catalog.getTitle());
	    					temp.setStatusName(temp.getStatus().equals("0")?"停用":"启用");//将状态转化为中文
	    					
	    				}
	    			}else if(catalog.getCatalogType().equals("t_opinionPoll")){//栏目类型为民意征集
	    				AllClassBean bean = new AllClassBean();
	    				bean.setCatalogID(Integer.valueOf(catalogID));
	    				bean.setTitle(title);
	    				list = opinionPollServices.getOpinionPollListByBean(bean);
	    				for(AllClassBean temp : list){
	    					temp.setCatalogName(catalog.getTitle());
					        temp.setStatusName(temp.getStatus().equals("0")?"停用":"启用");//将状态转化为中文
					        temp.setIsCollectName(temp.getIsCollect().equals("0")?"否":"是");
	    				}
	    			}else if(catalog.getCatalogType().equals("t_files")){//t_files
	    				AllClassBean bean = new AllClassBean();
	    				bean.setCatalogID(Integer.valueOf(catalogID));
	    				bean.setTitle(title);
	    				bean.setFileMode("t_fileinfo");
	    				list = fileInfoServices.getFileInfoListByBean(bean);
	    				for(AllClassBean temp : list){
	    					temp.setCatalogName(catalog.getTitle());
	    					temp.setIsshowName(temp.getIsshow().equals("0")?"否":"是");
	    				}
	    				
	    			}
	    			Integer size = roleServices.countRoleByAdmin(user);
	    			if(size<=0){
	    				List<Catalog> catalogList = catalogServices.queryCatalogListByUser(user);
		                if (catalogList.isEmpty()) {
		                    map.put("code", "00");
		                }
	    			}
	    			map.put("total",list.size());
			        map.put("rows",list);
			        map.put("catalogType", catalog.getCatalogType());//返回当前栏目的栏目类型
			        map.put("catalogName", catalog.getTitle());
			        map.put("parentID", catalog.getParentID());
			        String result = JSONObject.toJSONString(map);
			        pw.write(result);
	    		}else{
	    			logger.info(">>>>>>>>>>>>>>>>>>>>>catalog is null or......");
	    			Map<String,Object> map = new HashMap<String, Object>();
	    			Integer size = roleServices.countRoleByAdmin(user);
	    			if(size<=0){
		                List<Catalog> catalogList = catalogServices.queryCatalogListByUser(user);
		                if (catalogList.isEmpty()) {
		                    map.put("code", "00");
		                }
	    			}
	                String result = JSONObject.toJSONString(map);
			        pw.write(result);
	    		}
	    		
	        }catch (Exception e){
	            e.printStackTrace();
	        }
	        pw.flush();
	        pw.close();
	}

	/**
	 * 新建文章页面
	 * @return
	 */
	public String newContentsPage(){
		//判断是否还有叶子节点
		Catalog c = new Catalog();
		c.setParentID(catalogID);
		List<Catalog> list = catalogServices.queryCatalogListByBean(c);
		if(list.size()>0){
			return "list";   //如果还有叶子节点，不让其执行添加操作，返回列表
		}
		
		Catalog catalogT = new Catalog();
		catalogT.setTheID(Integer.valueOf(catalogID));
		Catalog catalog = catalogServices.queryCatalogByBean(catalogT);
//		if(catalog != null && catalog.getCatalogType() != null){
//			if(catalog.getCatalogType().equals("t_contents")){
//				
//			}
//		}
		this.request.setAttribute("catalog", catalog);
		this.request.setAttribute("now", DateUtils.getNowTime());
		return "newContentsPage";
	}
	
	public void saveNewContents(){
		 PrintWriter pw = null;
		 User user = (User)this.getRequest().getSession().getAttribute("userInSession");
	        try{
                this.getResponse().setCharacterEncoding("UTF-8");
                pw = this.getResponse().getWriter();
                Map<String,Object> map = new HashMap<String,Object>();
                String result;           
                Contents c = new Contents();
                c.setTitle(title);
                c.setSecTitle(secTitle);
                c.setSource(source);
                c.setSort(0);
                c.setStatus(status);
                c.setCatalogID(Integer.valueOf(catalogID));
                c.setContents(contents);
                c.setReleaseDate(releaseDate);
                c.setCreater_pid(String.valueOf(user.getId()));
                c.setCreate_date(DateUtils.getNowTime());
                c.setAuthor(author);
                if(isTop.equals("1")){
                	this.updateTopNewsByCatalogID(Integer.valueOf(catalogID), "0");
                }
                c.setIsTop(isTop);
                contentsServices.insertContents(c);
                result = "success";
                map.put("result", result);
                map.put("contentsID", c.getTheID());//返回新建记录的id
                String strMap = JSONObject.toJSONString(map);
                pw.write(strMap);
	        }catch (Exception e){
	            e.printStackTrace();
	        }
	        pw.flush();
	        pw.close();
	}
	
	public String showContentsEdit(){
		Contents c = new Contents();
        c.setTheID(Integer.valueOf(theID));
        Contents contents =  contentsServices.queryContentsByBean(c);
        Catalog catalogT = new Catalog();
		catalogT.setTheID(Integer.valueOf(contents.getCatalogID()));
		Catalog catalog = catalogServices.queryCatalogByBean(catalogT);
		
		FileInfo fileInfo = new FileInfo();
		fileInfo.setContentID(contents.getTheID());
		fileInfo.setIsindex("1");
		fileInfo.setFileType("1");
		fileInfo = fileInfoServices.queryFileInfoByBean(fileInfo);
		
		request.setAttribute("catalog", catalog);
        request.setAttribute("contents", contents);
        request.setAttribute("fileInfo", fileInfo);
		return "showContentsEdit";
	}
	
	public void saveEditContents(){
		 PrintWriter pw = null;
		 User user = (User)this.getRequest().getSession().getAttribute("userInSession");
		 Contents c = new Contents();
	     c.setTheID(Integer.valueOf(theID));
	     Contents contentsT =  contentsServices.queryContentsByBean(c);
	     String result;    
	     try{
               this.getResponse().setCharacterEncoding("UTF-8");
               pw = this.getResponse().getWriter();
               contentsT.setTitle(title);
               contentsT.setSecTitle(secTitle);
               contentsT.setSource(source);
               contentsT.setStatus(status);
               contentsT.setContents(contents);
               contentsT.setReleaseDate(releaseDate);
               contentsT.setUpdate_pid(String.valueOf(user.getId()));
               contentsT.setUpdate_date(DateUtils.getNowTime());
               contentsT.setAuthor(author);
               if(isTop.equals("1")){
            	   this.updateTopNewsByCatalogID(Integer.valueOf(catalogID), "0");
               }
               contentsT.setIsTop(isTop);
               contentsServices.updateContents(contentsT);
               result = "success";
    
	        }catch (Exception e){
	        	result = "error";
	            e.printStackTrace();
	        }
	     	pw.write(result);
	        pw.flush();
	        pw.close();
	}
	
	public void deleteContents(){
        PrintWriter pw = null;
        try{
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            String result;
            Contents c = new Contents();
   	     	c.setTheID(Integer.valueOf(theID));
   	     	Contents contentsT =  contentsServices.queryContentsByBean(c);
            if(contentsT!=null){	                
            	contentsServices.deleteContents(contentsT);
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
		 Catalog c = new Catalog();
		 c.setTheID(catalogId);
		 Catalog catalog = catalogServices.queryCatalogByBean(c);
		 if(catalog !=null){
			 if(Integer.valueOf(catalog.getParentID()) == 0){
				 ids.add(catalogId);
				 ids.add(Integer.valueOf(catalog.getParentID()));
				 return ids;
			 }else{
				 c.setTheID(Integer.valueOf(catalog.getParentID()));
				 Catalog temp = catalogServices.queryCatalogByBean(c);
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
	
	public String saveKindEditorPic() throws IOException{
		FileOutputStream fos = null;
		FileInputStream fis = null;
		try{
			String urlPath = "uploads/kindEditor/pic/";
			String realPath = request.getSession().getServletContext().getRealPath("/") + urlPath;
			File filePath = new File(realPath);
			if (!filePath.exists()) {
				filePath.mkdirs();
			}
			String suffix = this.contentFileName.substring(this.contentFileName.lastIndexOf("."));
			String fileName = new Date().getTime() + suffix;
			File saveFile = new File(realPath + "/" + fileName);
			fos = new FileOutputStream(saveFile);
			fis = new FileInputStream(getContent());
			byte[] b = new byte[1024];
			int readSize = fis.read(b);
			while (readSize > -1){
		        fos.write(b, 0, readSize);
		        readSize = fis.read(b);
			}
			String url =  request.getContextPath() +"/"+ urlPath  + fileName;//项目名+文件存放轮径+文件名
			JSONObject obj = new JSONObject();
			obj.put("error", Integer.valueOf(0));
			obj.put("url", url);
			this.content = null;
	      
			request.setAttribute("jsonStr", obj.toJSONString());
	    }catch (Exception e){
	    	e.printStackTrace();
	    }finally{
	    	if(fos != null){
	    		fos.close();
	    	}
	    	if(fis != null){
	    		fis.close();
	    	}
	    }
		return "success";
	}
	
	public void checkIsTop(){
		PrintWriter pw = null;
	    try{
	    	this.getResponse().setCharacterEncoding("UTF-8");
	    	pw = this.getResponse().getWriter();
	    	String result = "";
//			String catalogID = request.getParameter("catalogID");
			Contents contents = new Contents();
			contents.setCatalogID(Integer.valueOf(catalogID));
			contents.setStatus("1");
			contents.setIsTop("1");
			List<Contents> list = contentsServices.queryContentsListByBean(contents);
			if(list != null && list.size() > 0){
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
	
	public String saveKindEditorFile() throws IOException{
		FileOutputStream fos = null;
		FileInputStream fis = null;
		try{
			String urlPath = "uploads/kindEditor/file/";
			String realPath = request.getSession().getServletContext().getRealPath("/") + urlPath;
			File filePath = new File(realPath);
			if (!filePath.exists()) {
				filePath.mkdirs();
			}
			String suffix = this.filesrcFileName.substring(this.filesrcFileName.lastIndexOf("."));
			String fileName = new Date().getTime() + suffix;
			File saveFile = new File(realPath + "/" + fileName);
			fos = new FileOutputStream(saveFile);
			fis = new FileInputStream(this.getFilesrc());
			byte[] b = new byte[1024];
			int readSize = fis.read(b);
			while (readSize > -1){
		        fos.write(b, 0, readSize);
		        readSize = fis.read(b);
			}
			String url =  request.getContextPath() +"/"+ urlPath  + fileName;//项目名+文件存放轮径+文件名
			JSONObject obj = new JSONObject();
			obj.put("error", Integer.valueOf(0));
			obj.put("url", url);
			this.filesrc = null;
	      
			request.setAttribute("jsonStr", obj.toJSONString());
	    }catch (Exception e){
	    	e.printStackTrace();
	    }finally{
	    	if(fos != null){
	    		fos.close();
	    	}
	    	if(fis != null){
	    		fis.close();
	    	}
	    }
		return "success";
	}
	
	public void changeTopNews(){
		PrintWriter pw = null;
	    try{
	    	this.getResponse().setCharacterEncoding("UTF-8");
	    	pw = this.getResponse().getWriter();
	    	String result = "";
	    	this.updateTopNewsByCatalogID(Integer.valueOf(catalogID), "0");
			Contents contents = new Contents();
			contents.setTheID(Integer.valueOf(theID));
			Contents contentsT =  contentsServices.queryContentsByBean(contents);
			if(contentsT != null){
				contentsT.setIsTop("1");
			}
			contentsServices.updateContents(contentsT);
			result = "1";
			pw.write(result);
	    }catch(Exception e){
	    	e.printStackTrace();
	    }
	    pw.flush();
        pw.close();
	}
	
	private void updateTopNewsByCatalogID(Integer catalogID,String isTop){
		Contents contents = new Contents();
		contents.setCatalogID(catalogID);
		if(isTop != null && !isTop.equals("")){
			contents.setIsTop(isTop);
		}else{
			contents.setIsTop("0");
		}
		contentsServices.updateTopNewsByCatalogID(contents);
	}
	
	public ContentsServices getContentsServices() {
		return contentsServices;
	}

	public void setContentsServices(ContentsServices contentsServices) {
		this.contentsServices = contentsServices;
	}
	
	public CatalogServices getCatalogServices() {
		return catalogServices;
	}

	public void setCatalogServices(CatalogServices catalogServices) {
		this.catalogServices = catalogServices;
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

	public String getSecTitle() {
		return secTitle;
	}

	public void setSecTitle(String secTitle) {
		this.secTitle = secTitle;
	}

	public File getContent() {
		return content;
	}

	public void setContent(File content) {
		this.content = content;
	}

	public String getContentFileName() {
		return contentFileName;
	}

	public void setContentFileName(String contentFileName) {
		this.contentFileName = contentFileName;
	}

	public String getContentContentType() {
		return contentContentType;
	}

	public void setContentContentType(String contentContentType) {
		this.contentContentType = contentContentType;
	}

	public FileInfoServices getFileInfoServices() {
		return fileInfoServices;
	}

	public void setFileInfoServices(FileInfoServices fileInfoServices) {
		this.fileInfoServices = fileInfoServices;
	}

	public String getIsTop() {
		return isTop;
	}

	public void setIsTop(String isTop) {
		this.isTop = isTop;
	}

	public OpinionPollServices getOpinionPollServices() {
		return opinionPollServices;
	}

	public void setOpinionPollServices(OpinionPollServices opinionPollServices) {
		this.opinionPollServices = opinionPollServices;
	}

	public File getFilesrc() {
		return filesrc;
	}

	public void setFilesrc(File filesrc) {
		this.filesrc = filesrc;
	}

	public String getFilesrcFileName() {
		return filesrcFileName;
	}

	public void setFilesrcFileName(String filesrcFileName) {
		this.filesrcFileName = filesrcFileName;
	}

	public String getFilesrcContentType() {
		return filesrcContentType;
	}

	public void setFilesrcContentType(String filesrcContentType) {
		this.filesrcContentType = filesrcContentType;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	
}
