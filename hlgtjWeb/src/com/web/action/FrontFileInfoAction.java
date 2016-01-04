package com.web.action;
import java.io.InputStream;

import org.apache.struts2.ServletActionContext;

import com.system.action.BaseAction;

public class FrontFileInfoAction extends BaseAction {

	private static final long serialVersionUID = 1L;
	
	private String downPath;

	public InputStream getInputStream() throws Exception{
		logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>downPath="+downPath);
		return ServletActionContext.getServletContext().getResourceAsStream(downPath);
	}
	
	public String getDownloadFileName(){
		String downFileName = downPath.substring(downPath.lastIndexOf("/")+1);
		try{
			downFileName = new String(downFileName.getBytes(),"ISO8859-1");
		}catch(Exception e){
			e.printStackTrace();
		}
		logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>downFileName="+downFileName);
		return downFileName;
	}	
	
	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		return SUCCESS;
	}

	public String getDownPath() {
		return downPath;
	}

	public void setDownPath(String downPath) {
		this.downPath = downPath;
	}
	
}
