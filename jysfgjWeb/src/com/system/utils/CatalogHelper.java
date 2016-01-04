package com.system.utils;

public class CatalogHelper {
	
	public static String getNameByCatalogType(String catalog){
		String catalogTypeName = "";
		if(catalog.equals("t_contents")){
			catalogTypeName="文章页面";
		}else if(catalog.equals("t_video")){
			catalogTypeName="视频页面";
		}else if(catalog.equals("t_links")){
			catalogTypeName="友情链接";
		}else if(catalog.equals("t_fileinfo")){
			catalogTypeName="资料页面";
		}else if(catalog.equals("t_specialTopic")){
			catalogTypeName="专题报道";
		}else if(catalog.equals("t_services")){
			catalogTypeName="便民服务";
		}else if(catalog.equals("0")){
			catalogTypeName="";
		}else if(catalog.equals("t_oneContent")){
			catalogTypeName="单文章页面";
		}else if(catalog.equals("t_accrual")){
			catalogTypeName="权责清单";
		}else{

		}
		return catalogTypeName;
	}
	
	public static String getNameByZlCatalogType(String catalog){
		String catalogTypeName = "";
		if(catalog.equals("t_contents")){
			catalogTypeName="文章页面";
		}else if(catalog.equals("t_links")){
			catalogTypeName="跳转页面";
		}else{

		}
		return catalogTypeName;
	}
}
