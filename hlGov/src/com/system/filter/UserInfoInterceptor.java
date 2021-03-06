package com.system.filter;

import java.util.Map;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import com.system.pojo.User;

public class UserInfoInterceptor extends AbstractInterceptor{
	
	private final static Logger logger = Logger.getLogger(UserInfoInterceptor.class);

	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
		ActionContext ctx = invocation.getInvocationContext();
		Map session = ctx.getSession();
		User user = (User) session.get("userInSession");
		if(user != null){
			return invocation.invoke();
		}else{
			return "login";
		}
	}

}
