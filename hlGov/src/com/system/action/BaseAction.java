package com.system.action;

import com.opensymphony.xwork2.ActionSupport;
import com.system.filter.EncodeFilter;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BaseAction extends ActionSupport implements ServletRequestAware,ServletResponseAware {

	public static final long serialVersionUID = -5219926425994250729L;
	public DataSourceTransactionManager transactionManager;
	public HttpServletRequest request;
	public HttpServletResponse response;
	protected Log logger = LogFactory.getLog(EncodeFilter.class);

	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	public HttpServletResponse getResponse() {
		return response;
	}

	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}

	public DataSourceTransactionManager getTransactionManager() {
		return transactionManager;
	}

	public void setTransactionManager(
			DataSourceTransactionManager transactionManager) {
		this.transactionManager = transactionManager;
	}

	public void setServletResponse(HttpServletResponse arg0) {
		// TODO Auto-generated method stub
		this.setResponse(arg0);
	}

	public void setServletRequest(HttpServletRequest arg0) {
		// TODO Auto-generated method stub
		this.setRequest(arg0);
	}
	public Integer getPageNum() {
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null){
			pageNum = "1";
		}
		return Integer.valueOf(pageNum);
	}


	public Integer getPageSize() {
		String pageSize = request.getParameter("pageSize");
		if(pageSize == null){
			pageSize = "10";
		}
		return Integer.valueOf(pageSize);
	}


}
