package com.system.utils;

import java.io.File;
import java.sql.PreparedStatement;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.opensymphony.xwork2.ActionContext;
import com.system.filter.EncodeFilter;

public class DatabaseBackup extends QuartzJobBean{
	
	protected Log logger = LogFactory.getLog(EncodeFilter.class);
	
	public void backup() {  
//        ActionContext context = ActionContext.getContext();  
//        HttpServletRequest request = (HttpServletRequest) context  
//                .get(ServletActionContext.HTTP_REQUEST);  
//        String webtruepath = request.getParameter("path");  
        String name = "kggov_"+DateUtils.getServerDate(); //数据库备份名  
        try {  
        	String webtruepath = "D:\\dataBaseBakFromJava\\";
            File file = new File(webtruepath);  
            String path = file.getPath() + "\\" + name + ".bak";// name文件名  
            String bakSQL = "backup database kggov to disk=? with init";// SQL语句  
            PreparedStatement bak = DataBaseUtil.getConnection()  
                    .prepareStatement(bakSQL);  
            bak.setString(1, path);// path必须是绝对路径  
            bak.execute(); // 备份数据库  
            bak.close();  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
    }  
	
//	public static void main(String[] args){
//		System.out.println(DatabaseBackup.backup());
//	}

	@Override
	protected void executeInternal(JobExecutionContext arg0)
			throws JobExecutionException {
		logger.info(">>>>>>>>>>>>>>>>>>>>>开始执行数据库备份操作>>>>>>>>>>>>>>>>>>>>>");
		this.backup();
		logger.info(">>>>>>>>>>>>>>>>>>>>>完成数据库备份操作>>>>>>>>>>>>>>>>>>>>>");
	}
}
