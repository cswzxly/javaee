package com.system.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;

import com.system.pojo.Catalog;
import com.system.pojo.Links;
import com.system.pojo.User;
import com.system.services.CatalogServices;
import com.system.services.LinksServices;
import com.system.utils.DateUtils;

/**
 * @author hchch
 *
 * 2014年8月13日
 */
public class LinksAction extends BaseAction{

	@Autowired
	private CatalogServices catalogServices;
	@Autowired
	private LinksServices linksServices;
	
	private Links links;
	private String theID;
	private String catalogID;
	private File upload;
	private String uploadContentType;
	private String uploadFileName;
	
	/**
	 * 添加友情链接或者便民服务页面
	 * @return
	 */
	public String newLinksPage(){
		Catalog catalog = this.getCatalogById(Integer.valueOf(catalogID));
		
		this.request.setAttribute("catalog", catalog);
		return "newLinksPage";
	}
	
	/**
	 * 保存友情链接或者便民服务
	 * @return
	 */
	public String saveLinks(){
		try{
			if(links != null){
				
				links.setCreate_date(DateUtils.getNowTime());

				Catalog catalog = this.getCatalogById(links.getCatalogID());
				if(catalog != null){
					if(catalog.getCatalogType() != null && catalog.getCatalogType().equals("t_links")){
						if(links.getLink_type().equals("1")){
							String pic_url = this.saveLinksPic(catalog.getCatalogType());
							if(pic_url.equals("1")){
								throw new Exception("上传的图片只能是.jpg或.png或.gif格式！");
							}
							links.setPic_url(pic_url);
							linksServices.insertLinks(links);
						}else{
							linksServices.insertLinks(links);
						}
					}else if(catalog.getCatalogType() != null && catalog.getCatalogType().equals("t_services")){
						
						String pic_url = this.saveLinksPic(catalog.getCatalogType());
						if(pic_url.equals("1")){
							throw new Exception("上传的图片只能是.jpg或.png或.gif格式！");
						}
						links.setPic_url(pic_url);
						linksServices.insertLinks(links);
					}
					
				}
				catalogID = links.getCatalogID().toString();
			}
		}catch(Exception e){
//			e.printStackTrace();
			request.setAttribute("tips", e.getMessage());
			return "error";
		}
		return "success";
	}
	
	/**
	 * 保存图片
	 * @param catalogType
	 * @return
	 * @throws IOException
	 */
	private String saveLinksPic(String catalogType) throws IOException{
		FileInputStream fis = null;
		FileOutputStream fos = null;
		try{
			String urlPath = "uploads/";
			if(catalogType.equals("t_services")){//便民服务图片存放路径
				urlPath = urlPath + "services/";
			}else if(catalogType.equals("t_links")){//友情连接图片存放路径
				urlPath = urlPath + "links/";
			}
			String webappPath = request.getSession().getServletContext().getRealPath("/");
			String filePath = webappPath + urlPath;
			File file = new File(filePath);
			if(!file.exists()){
				file.mkdirs();
			}
			String suffix = uploadFileName.substring(uploadFileName.lastIndexOf(".")).toLowerCase();//获取图片后缀名
			if(suffix != null){
				if(!suffix.equals(".jpg") && !suffix.equals(".png") && !suffix.equals(".gif")){
					return "1";//图片格式不正确
				}
			}
			String fileName = new Date().getTime() + suffix;
			File saveFile = new File(filePath + fileName);
			fos = new FileOutputStream(saveFile);
			fis = new FileInputStream(this.getUpload());
			byte[] b = new byte[1024];
			int readSize = fis.read(b);
			while(readSize > -1){
				fos.write(b, 0, readSize);
				readSize = fis.read(b);
			}
			String returnUrl = urlPath + fileName;
			return returnUrl;
		}catch(Exception e){
			request.setAttribute("tips", e.getMessage());
			return "error";
		}finally{
			if(fos != null){
				fos.close();
			}
			if(fis != null){
				fis.close();
			}
		}
	}
	
	/**
	 * 删除友情连接或者便民服务
	 */
	public void deleteLinks(){
		PrintWriter pw = null;
		
		try {
			this.getResponse().setCharacterEncoding("UTF-8");
			pw = this.getResponse().getWriter();
			String result;
			Links l = new Links();
			l.setTheID(Integer.valueOf(theID));
			Links temp = linksServices.queryLinksByBean(l);
			if(temp != null){
				linksServices.deleteLinks(temp);
				Catalog catalog = this.getCatalogById(temp.getCatalogID());
				if(catalog.getCatalogType().equals("t_links")){
					if(temp.getLink_type().equals("1")){
						String filePath = request.getSession().getServletContext().getRealPath("/")+temp.getPic_url();
						File file = new File(filePath);
						file.delete();
					}
				}else if(catalog.getCatalogType().equals("t_services")){
					String filePath = request.getSession().getServletContext().getRealPath("/")+temp.getPic_url();
					File file = new File(filePath);
					file.delete();
				}
				result = "success";
			}else{
				result = "fail";
			}
			pw.write(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		pw.flush();
        pw.close();
	}
	
	/**
	 * 编辑友情链接或者便民服务页面
	 * @return
	 */
	public String showLinksEdit(){
		Links temp = new Links();
		temp.setTheID(Integer.valueOf(theID));
		links = linksServices.queryLinksByBean(temp);
		Catalog catalog = this.getCatalogById(links.getCatalogID());
		
		request.setAttribute("catalog", catalog);
		return "showLinksEdit";
	}
	
	/**
	 * 修改友情连接或者便民服务
	 * @return
	 */
	public String updateLinks(){
		if(links != null && links.getTheID() != null){
			Links temp = new Links();
			temp.setTheID(links.getTheID());
			Links oldLinks = linksServices.queryLinksByBean(temp);
			oldLinks.setTitle(links.getTitle());
			oldLinks.setLink_url(links.getLink_url());
			oldLinks.setStatus(links.getStatus());
			oldLinks.setUpdate_date(DateUtils.getNowTime());
			if(oldLinks.getLinkKind().equals("1")){
				if(oldLinks.getLink_type().equals("2")){
					oldLinks.setSelect_type(links.getSelect_type());
				}
			}
			linksServices.updateLinks(oldLinks);
			catalogID = oldLinks.getCatalogID().toString();
		}
		return "success";
	}
	
	/**
	 * 根据id获取栏目
	 * @param theID
	 * @return
	 */
	private Catalog getCatalogById(Integer theID){
		Catalog catalogT = new Catalog();
		catalogT.setTheID(theID);
		Catalog catalog = catalogServices.queryCatalogByBean(catalogT);
		return catalog;
	}
	
	public CatalogServices getCatalogServices() {
		return catalogServices;
	}
	public void setCatalogServices(CatalogServices catalogServices) {
		this.catalogServices = catalogServices;
	}
	public LinksServices getLinksServices() {
		return linksServices;
	}
	public void setLinksServices(LinksServices linksServices) {
		this.linksServices = linksServices;
	}
	public Links getLinks() {
		return links;
	}
	public void setLinks(Links links) {
		this.links = links;
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
	public File getUpload() {
		return upload;
	}
	public void setUpload(File upload) {
		this.upload = upload;
	}
	public String getUploadContentType() {
		return uploadContentType;
	}
	public void setUploadContentType(String uploadContentType) {
		this.uploadContentType = uploadContentType;
	}
	public String getUploadFileName() {
		return uploadFileName;
	}
	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}
	
}
