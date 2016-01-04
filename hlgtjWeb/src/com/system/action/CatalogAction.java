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

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.system.pojo.Catalog;
import com.system.pojo.Contents;
import com.system.pojo.Links;
import com.system.pojo.Video;
import com.system.services.CatalogServices;
import com.system.services.ContentsServices;
import com.system.services.LinksServices;
import com.system.services.VideoServices;
import com.system.utils.CatalogHelper;

public class CatalogAction extends BaseAction {
	@Resource(name = "catalogServices")
	private CatalogServices catalogServices;
	@Autowired
	private ContentsServices contentsServices;
	@Autowired
	private VideoServices videoServices;
	@Autowired
	private LinksServices linksServices;
	private String parentID;
	private String theID;
	private String title;
	private String catalogType;
	private String sort;
	private String url;
	private String status;
	private String isUploadPic;
	private File uploadinfo;
	private String uploadinfoContentType;
	private String uploadinfoFileName;

	private File ztbanner;
	private String ztbannerContentType;
	private String ztbannerFileName;

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

	public File getZtbanner() {
		return ztbanner;
	}

	public void setZtbanner(File ztbanner) {
		this.ztbanner = ztbanner;
	}

	public String getZtbannerContentType() {
		return ztbannerContentType;
	}

	public void setZtbannerContentType(String ztbannerContentType) {
		this.ztbannerContentType = ztbannerContentType;
	}

	public String getZtbannerFileName() {
		return ztbannerFileName;
	}

	public void setZtbannerFileName(String ztbannerFileName) {
		this.ztbannerFileName = ztbannerFileName;
	}

	public ContentsServices getContentsServices() {
		return contentsServices;
	}

	public void setContentsServices(ContentsServices contentsServices) {
		this.contentsServices = contentsServices;
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

	public String catalogPage() {
		return SUCCESS;
	}

	public void showRee() {
		PrintWriter pw = null;
		JSONArray ja = new JSONArray();
		try {
			this.getResponse().setCharacterEncoding("UTF-8");
			pw = this.getResponse().getWriter();
			Catalog c = new Catalog();
			//c.setStatus("1");
			List<Catalog> catalogList = catalogServices
					.queryCatalogListByBean(c);
			for (Catalog cTemp : catalogList) {
				JSONObject json = new JSONObject();
				json.put("id", cTemp.getTheID());
				json.put("pId", cTemp.getParentID());
				json.put("name", cTemp.getTitle());

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

	public void catalogList() {
		PrintWriter pw = null;
		try {
			this.getResponse().setCharacterEncoding("UTF-8");
			pw = this.getResponse().getWriter();
			Map<String, Object> map = new HashMap<String, Object>();
			Catalog c = new Catalog();
			c.setParentID(parentID);
			//c.setStatus("1");
			List<Catalog> list = catalogServices.queryCatalogListByBean(c);
			for (Catalog ca : list) {
				ca.setCatalogTypeName(CatalogHelper.getNameByCatalogType(ca
						.getCatalogType()));
				ca.setStatusName(ca.getStatus().equals("1") ? "启用" : "停用");
			}
			map.put("total", list.size());
			map.put("rows", list);
			String result = JSONObject.toJSONString(map);
			pw.write(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		pw.flush();
		pw.close();
	}

	public void saveNewCatalog() {
		PrintWriter pw = null;
		try {
			this.getResponse().setCharacterEncoding("UTF-8");
			pw = this.getResponse().getWriter();
			String result;
			Catalog c = new Catalog();
			c.setParentID(parentID);
			c.setStatus(status);
			c.setTitle(title);
			c.setSort(Integer.valueOf(sort));
			c.setUrl(url);
			c.setCatalogType(catalogType);
			c.setIsFirstCatalog("0");
			c.setIsUploadPic(isUploadPic);
			catalogServices.insertCatalog(c);
			if (catalogType.equals("t_fileinfo")) {
				c.setUrl("/web/areaInfoList.action?type=zlxz&catalogID=" + c.getTheID());
				catalogServices.updateCatalog(c);
			}
			result = "success";

			pw.write(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		pw.flush();
		pw.close();
	}

	public void saveEditCatalog() {
		PrintWriter pw = null;
		try {
			this.getResponse().setCharacterEncoding("UTF-8");
			pw = this.getResponse().getWriter();
			String result;
			Catalog c = new Catalog();
			c.setTheID(Integer.valueOf(theID));
			c = catalogServices.queryCatalogByBean(c);
			if (c != null) {
				c.setTitle(title);
				c.setCatalogType(catalogType);
				c.setSort(Integer.valueOf(sort));
				c.setStatus(status);
				c.setUrl(url);
				// c.setIsFirstCatalog("0");
				c.setIsUploadPic(isUploadPic);
				if (catalogType.equals("t_fileinfo")) {
					c.setUrl("/web/areaInfoList.action?type=zlxz&catalogID=" + c.getTheID());
				}
				catalogServices.updateCatalog(c);
				result = "success";
			} else {
				result = "fail";
			}
			pw.write(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		pw.flush();
		pw.close();
	}

	@SuppressWarnings("deprecation")
	public void uploader() throws IOException {
		PrintWriter pw = null;
		this.getResponse().setCharacterEncoding("UTF-8");
		this.getResponse().setContentType("text/html");// 可以使页面返回信息只有后台编辑的信息
		pw = this.getResponse().getWriter();
		String ID = request.getParameter("theID");
		String result = "";
		FileOutputStream fos = null;
		FileInputStream fis = null;
		try {
			String urlPath = "/uploads/zt/pic/";
			String classpath = CatalogAction.class.getResource("/").getPath();
			String path = classpath.substring(0, classpath.length()
					- "WEB-INF/classes/".length());
			String realPath = path + urlPath;
			// System.out.println(">>>>"+realPath);
			File filePath = new File(realPath);
			if (!filePath.exists()) {
				filePath.mkdirs();
			}
			String suffix = uploadinfoFileName.substring(
					uploadinfoFileName.lastIndexOf(".")).toLowerCase();
			if (!suffix.equals(".jpg")) {
				result = "缩略图只能上传.jpg格式的图片";
				pw.write(result);
			} else {
				String fileName = ID + suffix;
				File saveFile = new File(realPath + fileName);
				fos = new FileOutputStream(saveFile);
				fis = new FileInputStream(this.getUploadinfo());
				byte[] b = new byte[fis.available()];
				int readSize = fis.read(b);
				while (readSize > -1) {
					fos.write(b, 0, readSize);
					readSize = fis.read();
				}
				fos.close();
				fis.close();
				result = "success";
				pw.write(result);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		pw.flush();
		pw.close();
	}

	public void deleteCatalog() {
		PrintWriter pw = null;
		try {
			this.getResponse().setCharacterEncoding("UTF-8");
			pw = this.getResponse().getWriter();
			String result;
			//是否有子栏目
			Catalog temp = new Catalog();
			temp.setParentID(theID);
			List<Catalog> cataList = catalogServices.queryCatalogListByBean(temp);

			// 是否关联内容表
			Contents con = new Contents();
			con.setCatalogID(Integer.valueOf(theID));
			List<Contents> conList = contentsServices.queryContentsListByBean(con);
			// 是否关联视频表
			Video video = new Video();
			video.setCatalogID(Integer.valueOf(theID));
			List<Video> videoList = videoServices.queryVideoListByBean(video);
			// 是否关联友情链接表
			Links links = new Links();
			links.setCatalogID(Integer.valueOf(theID));
			List<Links> linksList = linksServices.queryLinksListByBean(links);
			if ((conList != null && conList.size() > 0)
					|| (videoList != null && videoList.size() > 0)
					|| (linksList != null && linksList.size() > 0)
					|| (cataList != null && cataList.size() > 0)) {
				result = "other";
			} else {
				Catalog c = new Catalog();
				c.setTheID(Integer.valueOf(theID));
				c = catalogServices.queryCatalogByBean(c);
				if (c != null) {
					catalogServices.deleteCatalog(c);
					result = "success";
				} else {
					result = "fail";
				}

			}
			pw.write(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		pw.flush();
		pw.close();
	}

	public void uploadZtBanner() throws IOException {
		PrintWriter pw = null;
		this.getResponse().setCharacterEncoding("UTF-8");
		this.getResponse().setContentType("text/html");// 可以使页面返回信息只有后台编辑的信息
		pw = this.getResponse().getWriter();
		String ID = request.getParameter("theID");
		String result = "";
		FileOutputStream fos = null;
		FileInputStream fis = null;
		try {
			String urlPath = "/uploads/zt/pic/";
			String classpath = CatalogAction.class.getResource("/").getPath();
			String path = classpath.substring(0, classpath.length()
					- "WEB-INF/classes/".length());
			String realPath = path + urlPath;
			File filePath = new File(realPath);
			if (!filePath.exists()) {
				filePath.mkdirs();
			}
			String suffix = ztbannerFileName.substring(
					ztbannerFileName.lastIndexOf(".")).toLowerCase();
			if (!suffix.equals(".jpg")) {
				result = "专题banner只能上传.jpg格式的图片";
			} else {
				String fileName = ID + "_banner" + suffix;
				File saveFile = new File(realPath + fileName);
				fos = new FileOutputStream(saveFile);
				fis = new FileInputStream(this.getZtbanner());
				byte[] b = new byte[fis.available()];
				int readSize = fis.read(b);
				while (readSize > -1) {
					fos.write(b, 0, readSize);
					readSize = fis.read();
				}
				fos.close();
				fis.close();
				result = "success";
			}
			pw.write(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		pw.flush();
		pw.close();
	}

}
