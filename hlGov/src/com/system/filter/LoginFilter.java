package com.system.filter;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginFilter implements Filter {
	protected Log logger = LogFactory.getLog(EncodeFilter.class);

	public void init(FilterConfig paramFilterConfig) throws ServletException {
		logger.info("================================初始化检查Session拦截器================================");
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain paramFilterChain) throws IOException, ServletException {

		//logger.info("调用检查登录拦截器");
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		HttpSession session = req.getSession();

		String url = req.getRequestURL().toString();
		//logger.info(url);

		if (session.getAttribute("userInSession") != null|| url.contains("login.action")|| url.contains("loginOut.action")) {// 登录后才能访问
			paramFilterChain.doFilter(request, response);
		} else {
			logger.info("没有用户登录");
			req.setAttribute("message", "请重新登录");
			res.sendRedirect("index.jsp");
		}

	}

	public void destroy() {

	}

}
