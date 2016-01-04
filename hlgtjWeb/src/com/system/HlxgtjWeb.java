package com.system;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class HlxgtjWeb implements ApplicationContextAware{
	private static ApplicationContext applicationContext;

	@Override
	public void setApplicationContext(ApplicationContext contex)
			throws BeansException {
		applicationContext = contex;
	}

	public static ApplicationContext getContext() {
		System.out.println("applicationContext:"+applicationContext);
		if(applicationContext==null){
			applicationContext = new ClassPathXmlApplicationContext(
                    "classpath:applicationContext.xml");
		}
		return applicationContext;
	}

}
