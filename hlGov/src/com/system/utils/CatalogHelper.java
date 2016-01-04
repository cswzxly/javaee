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
		}else if(catalog.equals("t_specialTopic")){
			catalogTypeName="专题报道";
		}else if(catalog.equals("t_services")){
			catalogTypeName="便民服务";
		}else if(catalog.equals("0")){
			catalogTypeName="";
		}else if(catalog.equals("t_opinionPoll")){
			catalogTypeName="民意征集";
		}else if(catalog.equals("t_files")){
			catalogTypeName="资料页面";
		}else{
			
		}
		return catalogTypeName;
	}
}
