package com.web.filter;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.context.ApplicationContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import com.system.KgGov;
import com.system.pojo.Catalog;
import com.web.services.FrontCatalogServices;

public class InitFrontCatalog extends AbstractInterceptor{
	
	private FrontCatalogServices frontCatalogServices;

	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
		ApplicationContext ac = KgGov.getContext();
		ActionContext ctx = invocation.getInvocationContext();
		Map session = ctx.getSession();
		List<Catalog> catalogList = (List<Catalog>) session.get("catalogList");
		if(catalogList == null || catalogList.size() == 0){
			catalogList = new ArrayList<Catalog>();
			frontCatalogServices = (FrontCatalogServices) ac.getBean("frontCatalogServices");
			Catalog catalog = new Catalog();
			catalog.setIsFirstCatalog("1");
			catalog.setStatus("1");
			List<Catalog> firstCatalogList = frontCatalogServices.queryCatalogListByBean(catalog);//获取一级栏目
			for(int i = 0;i < firstCatalogList.size();i++){
				catalogList.add(firstCatalogList.get(i));
				Catalog temp = new Catalog();
				temp.setParentID(firstCatalogList.get(i).getTheID().toString());
				temp.setTopNum("6");//只获取前6条的数据
				temp.setStatus("1");
				List<Catalog> list = frontCatalogServices.queryTopCatalogList(temp);
				for(int j = 0;j < list.size();j++){
					catalogList.add(list.get(j));
				}
			}
			session.put("catalogList", catalogList);
		}
		return invocation.invoke();
	}

	public FrontCatalogServices getFrontCatalogServices() {
		return frontCatalogServices;
	}

	public void setFrontCatalogServices(FrontCatalogServices frontCatalogServices) {
		this.frontCatalogServices = frontCatalogServices;
	}

}
