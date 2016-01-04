package com.system.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.system.pojo.Catalog;
import com.system.pojo.User;
import com.system.pojo.Video;
import com.system.services.CatalogServices;
import com.system.services.VideoServices;
import com.system.utils.DateUtils;

/**
 * @author hchch
 *
 * 2014年8月10日
 */
public class VideoAction extends BaseAction{

	@Autowired
	private CatalogServices catalogServices;
	@Autowired
	private VideoServices videoService;
	
	private Video video;
	private String theID;
	private String catalogID;
	private File upload;
	private String uploadContentType;
	private String uploadFileName;
	
	/**
	 * 视频列表
	 * @return
	 */
	public String list(){
		return "list";
	}
	
	/**
	 * 视频添加页
	 * @return
	 */
	public String newVideoPage(){
		Catalog catalogT = new Catalog();
		catalogT.setTheID(Integer.valueOf(catalogID));
		Catalog catalog = catalogServices.queryCatalogByBean(catalogT);
		
		this.request.setAttribute("catalog", catalog);
		return "newVideoPage";
	}
	
	/**
	 * 视频编辑页
	 * @return
	 */
	public String showVideoEdit(){
		Video v = new Video();
		v.setTheID(Integer.valueOf(theID));
		video = videoService.queryVideoByBean(v);
		Catalog catalogT = new Catalog();
		catalogT.setTheID(Integer.valueOf(video.getCatalogID()));
		Catalog catalog = catalogServices.queryCatalogByBean(catalogT);
		
		request.setAttribute("catalog", catalog);
		return "showVideoEdit";
	}
	
	/**
	 * 视频保存
	 * @return
	 */
	public String saveVideo(){
		try {
			User user = (User)this.getRequest().getSession().getAttribute("userInSession");
			if(video != null){
				String url = this.saveVideoFile();
				if(url != null){
					if(url.equals("1")){
						throw new Exception("上传的视频文件只能是.flv格式");
					}
				}
				video.setUrl(url);
				video.setCreater_pid(user.getId().toString());
				video.setCreate_date(DateUtils.getNowTime());
				videoService.insertVideo(video);
				catalogID = video.getCatalogID().toString();
				
			}
		} catch (IOException e) {
			request.setAttribute("tips", e.getMessage());
			return "error";
		} catch (Exception e) {
			request.setAttribute("tips", e.getMessage());
			return "error";
		}
		return "success";
	}
	
	/**
	 * 视频删除
	 * @return
	 */
	public void deleteVideo(){
		PrintWriter pw = null;
        try{
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            String result;
            Video v = new Video();
            v.setTheID(Integer.valueOf(theID));
            Video temp = videoService.queryVideoByBean(v);
            if(temp!=null){	                
            	videoService.deleteVideo(temp);
            	//删除源视频文件
            	String webappPath = request.getSession().getServletContext().getRealPath("/");
            	String filePath = webappPath + temp.getUrl();
            	File file = new File(filePath);
            	file.delete();
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
	
	/**
	 * 修改视频信息
	 * @return
	 */
	public String updateVideo(){
		if(video != null && video.getTheID() != null){
			User user = (User)this.getRequest().getSession().getAttribute("userInSession");
			Video temp = new Video();
			temp.setTheID(video.getTheID());
			Video oldVideo = videoService.queryVideoByBean(temp);
			oldVideo.setReleaseDate(video.getReleaseDate());
			oldVideo.setTitle(video.getTitle());
			oldVideo.setSource(video.getSource());
			oldVideo.setStatus(video.getStatus());
			oldVideo.setUpdate_date(DateUtils.getNowTime());
			oldVideo.setUpdate_pid(user.getId().toString());
			oldVideo.setIsindex(video.getIsindex());
			videoService.updateVideo(oldVideo);
			catalogID = oldVideo.getCatalogID().toString();
		}
		return "success";
	}
	
	private String saveVideoFile() throws IOException{
		
		FileOutputStream fos = null;
		FileInputStream fis = null;
		try{
			String urlPath = "uploads/video/";//视频文件存放路径
			String webappPath = request.getSession().getServletContext().getRealPath("/");//获取项目路径
			String filePath = webappPath + urlPath;
			File file = new File(filePath);
			if(!file.exists()){
				file.mkdirs();
			}
			String suffix = uploadFileName.substring(uploadFileName.lastIndexOf(".")).toLowerCase();//获取视频文件的后缀名
			if(suffix != null){
				if(!suffix.equals(".flv")){
					return "1";//1:代表视频格式不正确
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
	 * 
	 */
	public void checkVideoIndex(){
		PrintWriter pw = null;
		try{
			 this.getResponse().setCharacterEncoding("UTF-8");
			 pw = this.getResponse().getWriter();
			 Video temp = new Video();
			 temp.setIsindex("1");
			 List<Video> list = videoService.queryVideoListByBean(temp);
			 String result = "";
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

	public CatalogServices getCatalogServices() {
		return catalogServices;
	}

	public void setCatalogServices(CatalogServices catalogServices) {
		this.catalogServices = catalogServices;
	}

	public Video getVideo() {
		return video;
	}

	public void setVideo(Video video) {
		this.video = video;
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

	public VideoServices getVideoService() {
		return videoService;
	}

	public void setVideoService(VideoServices videoService) {
		this.videoService = videoService;
	}

	public String getTheID() {
		return theID;
	}

	public void setTheID(String theID) {
		this.theID = theID;
	}
	
}
