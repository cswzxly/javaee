package com.system.filter;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import javax.servlet.*;
import java.io.IOException;

public class EncodeFilter implements Filter {   
    protected String sEncodingName;   
  
    protected FilterConfig sysFilter;   
  
    protected boolean bEnable;   
  
    protected Log logger = LogFactory.getLog(EncodeFilter.class);
  
    public void destroy() {   
  
    }   
  
    public void doFilter(ServletRequest arg0, ServletResponse arg1,   
            FilterChain arg2) throws IOException, ServletException {   
        // TODO Auto-generated method stub   
        if (this.bEnable) {   
            try {     
                arg0.setCharacterEncoding(this.sEncodingName);   
                arg1.setContentType("text/html;charset=" + this.sEncodingName);   
                arg1.setCharacterEncoding(this.sEncodingName);   
                arg2.doFilter(arg0, arg1);   
  
            } catch (Exception e) {   
                logger.info("出错了");   
            }   
            // session.close();   
        } else {   
            arg2.doFilter(arg0, arg1);   
        }   
    }   
  
    public void init(FilterConfig arg0) throws ServletException {   
    	
        this.sysFilter = arg0;   
        this.loadFilterSetting();   
    }   
  
    private void loadFilterSetting() {   
        this.sEncodingName = this.sysFilter.getInitParameter("encoding");  
        logger.info("================================初始化字符编码拦截器================================");
        logger.info("encoding:" + sEncodingName);   
        String sEnable = this.sysFilter.getInitParameter("enable");   
        if (sEnable != null && sEnable.equalsIgnoreCase("true")) {   
            this.bEnable = true;   
        } else {   
            this.bEnable = false;   
        }   
    }   
  
  
}   