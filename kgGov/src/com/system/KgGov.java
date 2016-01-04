package com.system;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * 
 * @author 林尧
 * 
 *         2015年11月18日
 */
/*
 * 当一个类实现了这个接口（ApplicationContextAware）之后， 这个类就可以方便获得ApplicationContext中的所有bean。
 * 换句话说，就是这个类可以直接获取spring配置文件中，所有有引用到的bean对象。
 */
public class KgGov implements ApplicationContextAware {

	private static ApplicationContext applicationContext;

	@Override
	public void setApplicationContext(ApplicationContext contex)
			throws BeansException {
		applicationContext = contex;
	}

	public static ApplicationContext getContext() {

		if (applicationContext == null) {
			applicationContext = new ClassPathXmlApplicationContext(
					"classpath:applicationContext.xml");
		}
		return applicationContext;
	}

}
