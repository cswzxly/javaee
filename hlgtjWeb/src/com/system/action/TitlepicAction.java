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

import com.alibaba.fastjson.JSONObject;
import com.system.pojo.Survey;
import com.system.pojo.Titlepic;
import com.system.pojo.User;
import com.system.services.TitlepicServices;
import com.system.utils.DateUtils;

public class TitlepicAction  extends BaseAction{
	
	private static final long serialVersionUID = 1L;
	
	@Resource(name="titlepicServices")
	private TitlepicServices titlepicServices;	
	private File file;
	private String fileFileName;
	
	

	/**
	 * 
	 */
	
	public String titlepicPage(){
		return "success";
	}
	
	public void queryAllTitlepicList(){
		PrintWriter pw = null;
        try{
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            Map<String,Object> map = new HashMap<String, Object>();
            List<Titlepic> listTitlepic = null;
            listTitlepic = titlepicServices.queryAllTitlepicList();
            map.put("total",listTitlepic.size());
            map.put("rows",listTitlepic);
            String result = JSONObject.toJSONString(map);
            pw.write(result);
        }catch (Exception e){
            e.printStackTrace();
        }
        pw.flush();
        pw.close();
	}
	
	public String saveNewTitlepic(){
		String name = request.getParameter("name");
		User user = (User)this.getRequest().getSession().getAttribute("userInSession");
		Titlepic titlepic = new Titlepic();
		titlepic.setName(name);		
		titlepic.setTheDate(DateUtils.getNowTime());
		titlepic.setUserID(user.getId());
		titlepicServices.saveNewTitlepic(titlepic);
		this.fileFileName = titlepic.getUrl()+fileFileName.substring(fileFileName.lastIndexOf("."));
		if(file!=null){
			try {
				this.saveFile();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}			
		}
		Titlepic tp = new Titlepic();
		tp.setUrl(fileFileName);
		titlepicServices.saveEditTitlepic(tp);
        return "success";
	}
	
	public String saveEditTitlepic(){
		int theID = Integer.valueOf(request.getParameter("theID"));
		String linkUrl = request.getParameter("linkUrl");
		
		Titlepic titlepic = new Titlepic();
		titlepic.setTheID(theID);
		if(fileFileName != null && !fileFileName.equals("")){
			this.fileFileName = request.getParameter("theID")+fileFileName.substring(fileFileName.lastIndexOf("."));
			logger.info(">>>>>>>>>>>>>>>>>>>>>>fileFileName="+fileFileName);
			if(file!=null){
				try {
					this.saveFile();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}			
			}
			titlepic.setUrl(fileFileName);
		}else{
			titlepic.setUrl(null);
		}
		titlepic.setLinkUrl(linkUrl);
		titlepicServices.saveEditTitlepic(titlepic);
		return "success";
	}
	
	public void deleteTitlepic(){
		PrintWriter pw = null;
        try{
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            String result;
            int theID = Integer.valueOf(request.getParameter("theID"));
            if(theID>0){
                this.titlepicServices.deleteTitlepic(theID);
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
	
	private String saveFile() throws IOException{
		
		FileOutputStream fos = null;
		FileInputStream fis = null;
		try{
			String urlPath = "uploads/system/titlepic/";//文件存放路径
			String webappPath = request.getSession().getServletContext().getRealPath("/");//获取项目路径
			String filePath = webappPath + urlPath;
			File file = new File(filePath);
			if(!file.exists()){
				file.mkdirs();
			}
			File saveFile = new File(filePath + fileFileName);
			fos = new FileOutputStream(saveFile);
			fis = new FileInputStream(this.getFile());
			byte[] b = new byte[1024];
			int readSize = fis.read(b);
			while(readSize > -1){
				fos.write(b, 0, readSize);
				readSize = fis.read(b);
			}
			String returnUrl = urlPath + fileFileName;
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
	
	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public String getFileFileName() {
		return fileFileName;
	}

	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}
	
}
