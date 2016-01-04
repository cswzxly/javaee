package com.web.action;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.system.action.BaseAction;
import com.system.bean.AllClassBean;
import com.system.pojo.*;
import com.system.services.UserServices;
import com.web.services.FrontAccrualServices;
import com.web.services.FrontCatalogServices;
import com.web.services.FrontContentsServices;
import com.web.services.FrontFileInfoServices;
import com.web.services.FrontVideoServices;
import com.web.utils.Arithmetic;
import com.web.utils.HtmlRegexpUtil;
import com.web.utils.PropertiesUtils;
import com.web.utils.StringUtils;

import org.springframework.beans.factory.annotation.Autowired;

import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public class AreaInfoAction extends BaseAction {

    private static final long serialVersionUID = 1L;
    @Autowired
    private FrontCatalogServices frontCatalogServices;
    @Autowired
    private FrontContentsServices frontContentsServices;
    @Autowired
    private FrontVideoServices frontVideoServices;
    @Autowired
    private FrontFileInfoServices frontFileInfoServices;
    @Autowired
    private UserServices userServices;
    @Autowired
    private FrontAccrualServices frontAccrualServices;


    /**
     * 二级页面
     *
     * @return
     */
    public String areaInfoPage() {

        List<Catalog> areaCatalogList = this.initLeftCatalog(null);
        request.setAttribute("areaCatalogList", areaCatalogList);

        FileInfo fiParam = new FileInfo();
        String propertiesPath = request.getSession().getServletContext().getRealPath("/") + "WEB-INF/classes/web_index.properties";
        String kgfjCatalogID = PropertiesUtils.readValue(propertiesPath, "kgfjCatalogID");
        fiParam.setFileMode("t_fileinfo");
        fiParam.setFileType("1");
        fiParam.setIsshow("1");
        fiParam.setCatalogID(Integer.valueOf(kgfjCatalogID));
        List<FileInfo> fileInfoList = frontFileInfoServices.front_fileInfoList(fiParam);
        request.setAttribute("fileInfoList", fileInfoList);

//		Video video = new Video();
//		video.setCatalogID(44);
//		video.setStatus("1");
//		video.setTopNum("1");
//		List<Video> videoList2 = frontVideoServices.queryTopVideoList(video);
//		if(videoList2 != null && videoList2.size() > 0){
//			request.setAttribute("videoIndex", videoList2.get(0));
//		}
        return "areaInfoPage";
    }

    public String areaInfoMainList() {
        String catalogID = request.getParameter("catalogID");
        Arithmetic des = new Arithmetic();
        if (catalogID == null) {
            catalogID = "5";//给一个默认值
        }

        Catalog catalog = this.getCatalogByID(catalogID);
        request.setAttribute("catalog", catalog);

        List<Catalog> thirdCatalogList = this.frontCatalogServices.queryCatalogByParentID(catalogID);
        request.setAttribute("thirdCatalogList", thirdCatalogList);

        List<Contents> contentsList = new ArrayList<Contents>();
        for (Catalog catalogParam : thirdCatalogList) {
            Contents contentsParam = new Contents();
            contentsParam.setCatalogID(catalogParam.getTheID());
            contentsParam.setStatus("1");
            contentsParam.setTopNum("5");
            List<Contents> tempList = frontContentsServices.queryTopContentsList(contentsParam);
            if (tempList.size() < 5) {
                Contents contents = null;
                for (int i = tempList.size(); i < 5; i++) {
                    tempList.add(contents);
                }
            }
            contentsList.addAll(tempList);
        }
        request.setAttribute("contentsList", contentsList);

        List<Catalog> leftCatalogList = this.findChildCatalogs(catalogID);
        Catalog leftCatalog = new Catalog();
        if (leftCatalogList == null || leftCatalogList.size() <= 0) {//如果不存在子栏目
            if (catalog.getParentID().equals("0")) {
                leftCatalog.setTheID(catalog.getTheID());
            } else {
                leftCatalog.setParentID(catalog.getParentID());
            }
            leftCatalogList = this.initLeftCatalog(leftCatalog);
        }
        request.setAttribute("leftCatalogList", leftCatalogList);

        this.initTheTitle(catalog);
        return "areaInfoMainList";
    }

    /**
     * @return
     */
    public String areaInfoList() {

        String catalogID = request.getParameter("catalogID");
        if (catalogID == null) {
            catalogID = "5";//给一个默认值
        }

        Catalog catalog = this.getCatalogByID(catalogID);
        request.setAttribute("catalog", catalog);

        List<Catalog> leftCatalogList = this.findChildCatalogs(catalogID);
        Catalog leftCatalog = new Catalog();
        if (leftCatalogList == null || leftCatalogList.size() <= 0) {//如果不存在子栏目
            if (catalog.getParentID().equals("0")) {
                leftCatalog.setTheID(catalog.getTheID());
            } else {
                leftCatalog.setParentID(catalog.getParentID());
            }
            leftCatalogList = this.initLeftCatalog(leftCatalog);
        }
        request.setAttribute("leftCatalogList", leftCatalogList);

        Arithmetic des = new Arithmetic();
        
        if (catalog != null) {
            logger.debug(">>>>>>>>>>>>>>>>>>>>>>> catalogType : " + catalog.getCatalogType());
            if (catalog.getCatalogType().equals("t_contents")) {
//				Contents contents = new Contents();
//				contents.setCatalogID(Integer.valueOf(catalogID));
//				contents.setStatus("1");
//				List<Contents> contentsList = frontContentsServices.queryContentsListByBean(contents);
            	
//                List<Contents> contentsList = new ArrayList<Contents>();
//                contentsList = this.queryLeafCataContentsList(catalog.getTheID().toString(), contentsList);
            	
            	List<Integer> catalogIDList = new ArrayList<Integer>();
            	catalogIDList = this.queryLeafCatalogIDList(catalog.getTheID().toString(), catalogIDList);
            	Integer[] ids = new Integer[catalogIDList.size()];
            	for(int i = 0;i < catalogIDList.size();i++){
            		ids[i] = catalogIDList.get(i);
            	}
            	Contents contents = new Contents();
            	contents.setIds(ids);
//            	List<Contents> contentsList = frontContentsServices.queryContentsByIds(contents);
            	PageInfo<Contents> contentsList = frontContentsServices.queryContentsByIds(contents, getPageNum(), getPageSize());
                if(contentsList != null && contentsList.getList().size() > 0){
                	for(Contents c : contentsList.getList()){
                		c.setDesId(des.getEncString(c.getTheID().toString()));
                	}
                }
                request.setAttribute("contentsList", contentsList);
            } else if (catalog.getCatalogType().equals("t_video")) {
                Video video = new Video();
                video.setCatalogID(Integer.valueOf(catalogID));
                video.setStatus("1");
                List<Video> videoList = frontVideoServices.queryVideoListByBean(video);
                if(videoList != null && videoList.size() > 0){
                	for(Video c : videoList){
                		c.setDesId(des.getEncString(c.getTheID().toString()));
                	}
                }
                request.setAttribute("videoList", videoList);
            } else if (catalog.getCatalogType().equals("t_fileinfo")) {
                FileInfo fileInfo = new FileInfo();
                fileInfo.setCatalogID(Integer.valueOf(catalogID));
                fileInfo.setFileMode("t_fileinfo");
                fileInfo.setIsshow("1");
                List<FileInfo> fileInfoList = frontFileInfoServices.front_fileInfoList(fileInfo);
                request.setAttribute("fileInfoList", fileInfoList);
            } else if (catalog.getCatalogType().equals("t_oneContent")){
            	Contents contents = new Contents();
            	contents.setCatalogID(Integer.valueOf(catalogID));
            	contents = frontContentsServices.queryContentsByBean(contents);
            	if(contents == null || contents.getTheID() == null){
            		contents.setTitle(catalog.getTitle());//如果没有添加文章，则默认使用文章所在栏目的名称
            	}
            	request.setAttribute("contents", contents);
            }
        }
        this.initTheTitle(catalog);
        if(catalog.getCatalogType().equals("t_oneContent")){
        	return "contentsShow";
        }
        return "areaInfoList";
    }

    /**
     * 文章内容显示
     *
     * @return
     */
    public String contentsShow() {

        //文章内容
    	try{
	        String contentsID = request.getParameter("contentsID");
	        if(contentsID != null && !"".equals(contentsID)){
		        Arithmetic des = new Arithmetic();
		        Contents temp = new Contents();
		        contentsID = des.getDesString(contentsID);
		        temp.setTheID(Integer.valueOf(contentsID));
		        Contents contents = frontContentsServices.queryContentsByBean(temp);
		        contents.setVisitCount(contents.getVisitCount() + 1);
		        frontContentsServices.updateContents(contents);
		        logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> c12345 = " + contents);
		
		        User user = new User();
		        user.setId(Integer.valueOf(contents.getCreater_pid()));
		        user = userServices.queryUserByBean(user);
		        if (user != null) {
		            contents.setUserName(user.getRealName());
		        }
		        request.setAttribute("contents", contents);
		
		        //查找图片
		        FileInfo fileInfo = new FileInfo();
		        fileInfo.setContentID(contents.getTheID());
		        fileInfo.setIsshow("1");
		        fileInfo.setFileType("1");
		        List<FileInfo> picList = frontFileInfoServices.front_fileInfoList(fileInfo);
		        request.setAttribute("picList", picList);
		
		        //查找附件
		        fileInfo = new FileInfo();
		        fileInfo.setContentID(contents.getTheID());
		        fileInfo.setFileType("2");
		        fileInfo.setIsshow("1");
		        List<FileInfo> fileList = frontFileInfoServices.front_fileInfoList(fileInfo);
		        request.setAttribute("fileList", fileList);
		
		        //
		        Catalog catalog = this.getCatalogByID(contents.getCatalogID().toString());
		        request.setAttribute("catalog", catalog);
		
		        Catalog leftCatalog = new Catalog();
		        if (catalog.getParentID().equals("0")) {
		            leftCatalog.setTheID(catalog.getTheID());
		        } else {
		            leftCatalog.setParentID(catalog.getParentID());
		        }
		        List<Catalog> leftCatalogList = this.initLeftCatalog(leftCatalog);
		        request.setAttribute("leftCatalogList", leftCatalogList);
		        this.initTheTitle(catalog);
	        }
    	}catch(Exception e){
    		e.printStackTrace();
    	}
        return "contentsShow";
    }

    /**
     * 视频播放
     *
     * @return
     */
    public String videoShow() {

        String videoID = request.getParameter("videoID");
        if(videoID != null && !"".equals(videoID)){
        	Arithmetic des = new Arithmetic();
        	videoID = des.getDesString(videoID); 
	        Video temp = new Video();
	        temp.setTheID(Integer.valueOf(videoID));
	        Video video = frontVideoServices.queryVideoByBean(temp);
	        request.setAttribute("video", video);
	        request.setAttribute("videoUrl", video.getUrl());
	
	        Catalog catalog = this.getCatalogByID(video.getCatalogID().toString());
	        request.setAttribute("catalog", catalog);
	
	        Catalog leftCatalog = new Catalog();
	        if (catalog.getParentID().equals("0")) {
	            leftCatalog.setTheID(catalog.getTheID());
	        } else {
	            leftCatalog.setParentID(catalog.getParentID());
	        }
	        List<Catalog> leftCatalogList = this.initLeftCatalog(leftCatalog);
	        request.setAttribute("leftCatalogList", leftCatalogList);
	
	        this.initTheTitle(catalog);
        }
        return "videoShow";
    }

    /**
     * 初始左导航
     *
     * @return
     */
    private List<Catalog> initLeftCatalog(Catalog catalog) {
        if (catalog == null) {
            catalog = new Catalog();
            catalog.setParentID("1");
        }
        catalog.setStatus("1");
        List<Catalog> list = frontCatalogServices.queryCatalogListByBean(catalog);
        return list;
    }

    /**
     * @param catalogID
     * @return
     */
    private Catalog getCatalogByID(String catalogID) {
        Catalog temp = new Catalog();
        temp.setTheID(Integer.valueOf(catalogID));
        Catalog catalog = frontCatalogServices.queryCatalogByBean(temp);
        return catalog;
    }

    /**
     * 附件下载
     *
     * @throws java.io.IOException
     */
    public void download() throws IOException {
        FileInputStream fis = null;
        BufferedOutputStream bos = null;
        try {
            String theID = request.getParameter("theID");
            FileInfo fileInfo = new FileInfo();
            fileInfo.setTheID(Integer.valueOf(theID));
            fileInfo = frontFileInfoServices.queryFileInfoByBean(fileInfo);
            String suffix = fileInfo.getFileUrl().substring(fileInfo.getFileUrl().lastIndexOf(".")).toLowerCase();
            response.setContentType("bin;charset=UTF-8");
            response.addHeader("Content-Disposition", "attachment;fileName=\"" + StringUtils.converGb2312ToIso8859(fileInfo.getTitle() + suffix + "\""));

            String realPath = request.getSession().getServletContext().getRealPath("/");
            fis = new FileInputStream(realPath + fileInfo.getFileUrl());
            bos = new BufferedOutputStream(response.getOutputStream());
            byte[] b = new byte[1024];
            while (fis.read(b) != -1) {
                bos.write(b);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (fis != null) {
                fis.close();
            }
            if (bos != null) {
                bos.close();
            }
        }

    }

    /**
     * 二级页面中板块内容获取
     */
    public void areaInfoContents() {
        PrintWriter pw = null;
        try {
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            String catalogID = request.getParameter("catalogID");
            Contents contents = new Contents();
            contents.setCatalogID(Integer.valueOf(catalogID));
            contents.setStatus("1");
            contents.setTopNum("6");
            List<Contents> list = frontContentsServices.queryTopContentsList(contents);
            if (list != null && list.size() > 0) {
                for (int i = 0; i < list.size(); i++) {
                    Contents temp = list.get(i);
                    if (temp.getTitle().length() > 16) {
                        list.get(i).setTitle(temp.getTitle().substring(0, 16) + "...");
                    }
                    System.out.println("allTitle:"+list.get(i).getAllTitle());
                    Arithmetic des = new Arithmetic();
                    list.get(i).setDesId(des.getEncString(temp.getTheID().toString()));
                }
            }
            
            String result = JSONArray.toJSONString(list);
            pw.write(result);
        } catch (Exception e) {
            e.printStackTrace();
        }
        pw.flush();
        pw.close();
    }

    private void initTheTitle(Catalog catalog) {
        //左导航标题和当前位置的标题（临时方法）
        String type = request.getParameter("type");
        String contentTitle = "";
        if (type != null) {
//        	type = des.getDesString(type);
            if (type.equals("contents")) {
                List<Catalog> list = this.findChildCatalogs(catalog.getTheID().toString());
                if (list != null && list.size() > 0) {
                    contentTitle = catalog.getTitle();
                } else {
                	if(catalog.getParentID().equals(0)){
	                    Catalog pc = new Catalog();
	                    pc.setStatus("1");
	                    pc.setTheID(Integer.valueOf(catalog.getParentID()));
	                    pc = frontCatalogServices.queryCatalogByBean(pc);
	                    contentTitle = pc.getTitle();
                	}else{
                		contentTitle = catalog.getTitle();
                	}
                }
            }
            request.setAttribute("leftTitle", type);
            request.setAttribute("contentTitle", contentTitle);
        }
    }

    /**
     * 镇场页面
     *
     * @return
     */
    public String townPage() {
        request.setAttribute("theID", request.getParameter("theID"));
        request.setAttribute("flag", request.getParameter("flag"));
        return "townPage";
    }

    /**
     * 镇场栏目
     *
     * @return
     */
    public String townCatalogLeft() {
        Catalog townCatalog = new Catalog();
        townCatalog.setStatus("1");
        townCatalog.setParentID("59");
        List<Catalog> catalogList = frontCatalogServices.queryCatalogListByBean(townCatalog);
        JSONArray array = new JSONArray();
        for (int i = 0; i < catalogList.size(); i++) {
            JSONObject obj = new JSONObject();
            Catalog catalog = catalogList.get(i);

            String theID = catalog.getTheID().toString();
            Catalog temp = new Catalog();
            temp.setParentID(theID);
            temp.setStatus("1");
            List<Catalog> list = frontCatalogServices.queryCatalogListByBean(temp);
            obj.put("id", catalog.getTheID());
            obj.put("pId", catalog.getParentID());
            obj.put("name", catalog.getTitle());
            if (((catalog.getParentID()).equals("1")) && list.size() > 0) {
                obj.put("iconOpen", request.getContextPath()
                        + "/ztree/css/zTreeStyle/img/diy/1_open.png");
                obj.put("iconClose", request.getContextPath()
                        + "/ztree/css/zTreeStyle/img/diy/1_close.png");
                obj.put("open", true);
            } else if ((catalog.getParentID()).equals("1")) {
                obj.put("icon", request.getContextPath()
                        + "/ztree/css/zTreeStyle/img/diy/1_open.png");
            } else {
                obj.put("icon", request.getContextPath()
                        + "/ztree/css/zTreeStyle/img/diy/3.png");
            }
            array.add(obj);

            this.writeSecTree(list, array);
        }
        request.setAttribute("array", JSONArray.toJSONString(array));
        return "left";
    }

    /**
     * 生成二级树
     *
     * @param list
     * @param array
     */
    public void writeSecTree(List<Catalog> list, JSONArray array) {
        if (list != null && list.size() > 0) {
            for (int i = 0; i < list.size(); i++) {
                Catalog catalog = list.get(i);
                JSONObject obj = new JSONObject();
                obj.put("id", catalog.getTheID());
                obj.put("pId", catalog.getParentID());
                obj.put("name", catalog.getTitle());
                if (((catalog.getParentID()).equals("1")) && list.size() > 0) {
                    obj.put("iconOpen", request.getContextPath()
                            + "/ztree/css/zTreeStyle/img/diy/1_open.png");
                    obj.put("iconClose", request.getContextPath()
                            + "/ztree/css/zTreeStyle/img/diy/1_close.png");
                    obj.put("open", true);
                } else if ((catalog.getParentID()).equals("1")) {
                    obj.put("icon", request.getContextPath()
                            + "/ztree/css/zTreeStyle/img/diy/1_open.png");
                } else {
                    obj.put("icon", request.getContextPath()
                            + "/ztree/css/zTreeStyle/img/diy/3.png");
                }
                array.add(obj);
            }

        }
    }

    public String townContentsList() {
        String catalogID = request.getParameter("theID");
        if (catalogID != null && !"".equals(catalogID)) {
            Catalog catalog = new Catalog();
            catalog.setTheID(Integer.valueOf(catalogID));
            catalog = frontCatalogServices.queryCatalogByBean(catalog);
            request.setAttribute("catalog", catalog);

//			Contents contents = new Contents();
//			contents.setCatalogID(Integer.valueOf(catalogID));
//			contents.setStatus("1");
//			List<Contents> conList = frontContentsServices.queryContentsListByBean(contents);
//			request.setAttribute("conList", conList);
            
//            List<Contents> conList = new ArrayList<Contents>();
//            conList = this.queryLeafCataContentsList(catalogID, conList);
            
            List<Integer> catalogIDList = new ArrayList<Integer>();
            catalogIDList = this.queryLeafCatalogIDList(catalogID, catalogIDList);
            Integer[] ids = new Integer[catalogIDList.size()];
            for(int i = 0;i < catalogIDList.size();i++){
            	ids[i] = catalogIDList.get(i);
            }
            
            Contents contents = new Contents();
            contents.setIds(ids);
            contents.setStatus("1");
            List<Contents> conList = frontContentsServices.queryContentsByIds(contents);
            request.setAttribute("conList", conList);
        }

        return "list";
    }

    /**
     * 镇场信息具体内容
     *
     * @return
     */
    public String townContentsDetail() {
        String contentsID = request.getParameter("theID");
        if (contentsID != null && !"".equals(contentsID)) {
            Contents contents = new Contents();
            contents.setTheID(Integer.valueOf(contentsID));
            contents = frontContentsServices.queryContentsByBean(contents);

            User user = new User();
            user.setId(Integer.valueOf(contents.getCreater_pid()));
            user = userServices.queryUserByBean(user);
            contents.setUserName(user.getRealName());

            request.setAttribute("contents", contents);
        }
        return "detail";
    }

    /**
     * 机关单位页面
     *
     * @return
     */
    public String officePage() {
        request.setAttribute("theID", request.getParameter("theID"));
        request.setAttribute("flag", request.getParameter("flag"));
        return "officePage";
    }

    /**
     * 机关单位栏目
     *
     * @return
     */
    public String officeCatalogLeft() {
        Catalog townCatalog = new Catalog();
        townCatalog.setStatus("1");
        townCatalog.setParentID("67");
        List<Catalog> catalogList = frontCatalogServices.queryCatalogListByBean(townCatalog);
        JSONArray array = new JSONArray();
        for (int i = 0; i < catalogList.size(); i++) {
            JSONObject obj = new JSONObject();
            Catalog catalog = catalogList.get(i);

            String theID = catalog.getTheID().toString();
            Catalog temp = new Catalog();
            temp.setParentID(theID);
            temp.setStatus("1");
            List<Catalog> list = frontCatalogServices.queryCatalogListByBean(temp);
            obj.put("id", catalog.getTheID());
            obj.put("pId", catalog.getParentID());
            obj.put("name", catalog.getTitle());
            if (((catalog.getParentID()).equals("1")) && list.size() > 0) {
                obj.put("iconOpen", request.getContextPath()
                        + "/ztree/css/zTreeStyle/img/diy/1_open.png");
                obj.put("iconClose", request.getContextPath()
                        + "/ztree/css/zTreeStyle/img/diy/1_close.png");
                obj.put("open", true);
            } else if ((catalog.getParentID()).equals("1")) {
                obj.put("icon", request.getContextPath()
                        + "/ztree/css/zTreeStyle/img/diy/1_open.png");
            } else {
                obj.put("icon", request.getContextPath()
                        + "/ztree/css/zTreeStyle/img/diy/3.png");
            }
            array.add(obj);

            this.writeSecTree(list, array);
        }
        request.setAttribute("array", JSONArray.toJSONString(array));
        return "left";
    }

    /**
     * 机关单位内容列表
     *
     * @return
     */
    public String officeContentsList() {
        String catalogID = request.getParameter("theID");
        if (catalogID != null && !"".equals(catalogID)) {
            Catalog catalog = new Catalog();
            catalog.setTheID(Integer.valueOf(catalogID));
            catalog = frontCatalogServices.queryCatalogByBean(catalog);
            request.setAttribute("catalog", catalog);

//			Contents contents = new Contents();
//			contents.setCatalogID(Integer.valueOf(catalogID));
//			contents.setStatus("1");
//			List<Contents> conList = frontContentsServices.queryContentsListByBean(contents);
            
//            List<Contents> conList = new ArrayList<Contents>();
//            conList = this.queryLeafCataContentsList(catalogID, conList);
            
            List<Integer> catalogIDList = new ArrayList<Integer>();
            catalogIDList = this.queryLeafCatalogIDList(catalogID, catalogIDList);
            Integer[] ids = new Integer[catalogIDList.size()];
            for(int i = 0;i < catalogIDList.size();i++){
            	ids[i] = catalogIDList.get(i);
            }
            
            Contents contents = new Contents();
            contents.setIds(ids);
            contents.setStatus("1");
            List<Contents> conList = frontContentsServices.queryContentsByIds(contents);
            request.setAttribute("conList", conList);
        }

        return "list";
    }

    /**
     * 机关单位具体内容
     *
     * @return
     */
    public String officeContentsDetail() {
        String contentsID = request.getParameter("theID");
        if (contentsID != null && !"".equals(contentsID)) {
            Contents contents = new Contents();
            contents.setTheID(Integer.valueOf(contentsID));
            contents = frontContentsServices.queryContentsByBean(contents);

            User user = new User();
            user.setId(Integer.valueOf(contents.getCreater_pid()));
            user = userServices.queryUserByBean(user);
            contents.setUserName(user.getRealName());

            request.setAttribute("contents", contents);
        }
        return "detail";
    }

    private List<Catalog> findChildCatalogs(String theID) {
        Catalog catalog = new Catalog();
        catalog.setParentID(theID);
        catalog.setStatus("1");
        List<Catalog> list = frontCatalogServices.queryCatalogListByBean(catalog);
        return list;
    }

    /**
     * 根据某个catalogID查找其子id的所有内容
     *
     * @param theID
     * @param contentsList
     * @return
     */
    private List<Contents> queryLeafCataContentsList(String theID, List<Contents> contentsList) {
        if (theID != null) {
            Catalog temp = new Catalog();
            temp.setParentID(theID);
            temp.setStatus("1");
            List<Catalog> list = frontCatalogServices.queryCatalogListByBean(temp);
            if (list != null && list.size() > 0) {//存在子栏目
                for (int i = 0; i < list.size(); i++) {
                    Catalog c = list.get(i);
                    contentsList = this.queryLeafCataContentsList(c.getTheID().toString(), contentsList);//递归
                }
            } else {
                //不存在子栏目（即叶节点），直接查询内容
                Contents c = new Contents();
                c.setCatalogID(Integer.valueOf(theID));
                c.setStatus("1");
                List<Contents> tempList = frontContentsServices.queryContentsListByBean(c);
                for (int i = 0; i < tempList.size(); i++) {
                    contentsList.add(tempList.get(i));
                }
            }
        }
        return contentsList;
    }

    /**
     * 加载站点地图页面
     */
    public String sitemapPage() {
        Catalog catalogParam = new Catalog();
        catalogParam.setIsFirstCatalog("1");
        List<Catalog> tempList1 = frontCatalogServices.queryCatalogListByBean(catalogParam);
        List<Catalog> tempList2 = new ArrayList<Catalog>();
        List<Catalog> tempList3 = new ArrayList<Catalog>();
        if (tempList1 != null) {
            for (Catalog catalog1 : tempList1) {
                List<Catalog> catalogList2 = frontCatalogServices.queryCatalogByParentID(String.valueOf(catalog1.getTheID()));
                if (catalogList2 != null) {
                    for (Catalog catalog2 : catalogList2) {
                        List<Catalog> catalogList3 = frontCatalogServices.queryCatalogByParentID(String.valueOf(catalog2.getTheID()));
                        if (catalogList3 != null) {
                            tempList3.addAll(catalogList3);
                        }
                    }
                    tempList2.addAll(catalogList2);
                }
            }
        }

        request.setAttribute("tempList1", tempList1);
        request.setAttribute("tempList2", tempList2);
        request.setAttribute("tempList3", tempList3);
        return "sitemapPage";
    }

    /**
     * 发展改革工作页面
     * @return
     */
    public String workPage(){
    	
    	return "workPage";
    }
    
    /**
     * 政民互动二级页面
     * @return
     */
    public String interactPage(){
    	
    	return "interactPage";
    }
    
    /**
     * 政务公开二级页面
     * @return
     */
    public String govpubPage(){
    	String path = request.getSession().getServletContext().getRealPath("/");
        String propertiesPath = path + "WEB-INF/classes/web_index.properties";
        String value = "";
        Integer[] ids;
        
        Arithmetic des = new Arithmetic();
        
        //时政要闻@catalogID=10
        logger.info(">>>>>>>>>>IndexAction:govpubPage:时政要闻>>>>>>>>>>");
        Contents contents10 = new Contents();
        value = PropertiesUtils.readValue(propertiesPath, "szywCatalogID");
        contents10 = new Contents();
        contents10.setCatalogID(Integer.valueOf(value));
        contents10.setStatus("1");
        contents10.setTopNum("10");
        List<Contents> contents10List = frontContentsServices.queryTopContentsList(contents10);
        Catalog catalog10 = frontCatalogServices.queryCatalogByID(value);
        request.setAttribute("catalog10", catalog10);
        if(contents10List != null && contents10List.size() > 0){
        	for(Contents c : contents10List){
        		c.setDesId(des.getEncString(c.getTheID().toString()));
            }
        }
        request.setAttribute("contents10List", contents10List);
        
        //时政要闻@catalogID=43
        logger.info(">>>>>>>>>>IndexAction:govpubPage:局工作动态>>>>>>>>>>");
        value = PropertiesUtils.readValue(propertiesPath, "jgzdtCatalogID");
        Contents contents43 = new Contents();
        contents43 = new Contents();
        contents43.setCatalogID(Integer.valueOf(value));
        contents43.setStatus("1");
        contents43.setTopNum("10");
        List<Contents> contents43List = frontContentsServices.queryTopContentsList(contents43);
        Catalog catalog43 = frontCatalogServices.queryCatalogByID(value);
        request.setAttribute("catalog43", catalog43);
        if(contents43List != null && contents43List.size() > 0){
        	for(Contents c : contents43List){
        		c.setDesId(des.getEncString(c.getTheID().toString()));
        	}
        }
        request.setAttribute("contents43List", contents43List);

        //新闻图片
        logger.info(">>>>>>>>>>IndexAction:govpubPage:新闻图片>>>>>>>>>>");
        AllClassBean picBean = new AllClassBean();
        value = PropertiesUtils.readValue(propertiesPath, "xwtpCatalogPID");
        picBean.setCatalogPID(value);
        picBean.setIsindex("1");
        picBean.setFileType("1");
        picBean.setTopNum("4");
        List<AllClassBean> picIndexList = frontFileInfoServices.queryTopPicIndex(picBean);
        request.setAttribute("picIndexList", picIndexList);
        
        //通知公告@catalogID=68
        logger.info(">>>>>>>>>>IndexAction:govpubPage:通知公告>>>>>>>>>>");
        Contents contents68 = new Contents();
        Integer zxtzCatalogID = Integer.valueOf(PropertiesUtils.readValue(propertiesPath, "zxtzCatalogID"));
        Integer xmggCatalogID = Integer.valueOf(PropertiesUtils.readValue(propertiesPath, "xmggCatalogID"));
        Integer jfggCatalogID = Integer.valueOf(PropertiesUtils.readValue(propertiesPath, "jfggCatalogID"));
        Integer rsggCatalogID = Integer.valueOf(PropertiesUtils.readValue(propertiesPath, "rsggCatalogID"));
        Integer qtggCatalogID = Integer.valueOf(PropertiesUtils.readValue(propertiesPath, "qtggCatalogID"));
        ids = new Integer[]{zxtzCatalogID, xmggCatalogID, jfggCatalogID, rsggCatalogID, qtggCatalogID};
        contents68.setIds(ids);
        contents68.setStatus("1");
        contents68.setTopNum("8");
        List<Contents> content186List = frontContentsServices.queryContentsByIds(contents68);
        if(content186List.size() > 0){
        	for(Contents c : content186List){
        		c.setDesId(des.getEncString(c.getTheID().toString()));
        	}
        }
        request.setAttribute("content186List", content186List);

        //最新公示@catalogID=180
        logger.info(">>>>>>>>>>IndexAction:govpubPage:最新公示>>>>>>>>>>");
        Contents contents180 = new Contents();
        Integer smgsCatalogID = Integer.valueOf(PropertiesUtils.readValue(propertiesPath, "smgsCatalogID"));
        Integer jfgsCatalogID = Integer.valueOf(PropertiesUtils.readValue(propertiesPath, "jfgsCatalogID"));
        Integer qtgsCatalogID = Integer.valueOf(PropertiesUtils.readValue(propertiesPath, "qtgsCatalogID"));
        ids = new Integer[]{smgsCatalogID, jfgsCatalogID, qtgsCatalogID};
        contents180.setIds(ids);
        contents180.setStatus("1");
        contents180.setTopNum("8");
        List<Contents> content180List = frontContentsServices.queryTopContentsList(contents180);
        if(content180List.size() > 0){
        	for(Contents c : content180List){
        		c.setDesId(des.getEncString(c.getTheID().toString()));
        	}
        }
        request.setAttribute("content180List", content180List);
        
        //政策法规
        logger.info(">>>>>>>>>>IndexAction:govpubPage:政策法规>>>>>>>>>>");
        Contents contents183 = new Contents();
        Integer jfbzCatalogID = Integer.valueOf(PropertiesUtils.readValue(propertiesPath, "jfbzCatalogID"));
        Integer zcfbCatalogID = Integer.valueOf(PropertiesUtils.readValue(propertiesPath, "zcfbCatalogID"));
        ids = new Integer[]{jfbzCatalogID,zcfbCatalogID};
        contents183.setIds(ids);
        contents183.setStatus("1");
        contents183.setTopNum("8");
        List<Contents> content183List = frontContentsServices.queryTopContentsList(contents183);
        if(content183List.size() > 0){
        	for(Contents c : content183List){
        		c.setDesId(des.getEncString(c.getTheID().toString()));
        	}
        }
        request.setAttribute("content183List", content183List);
        
        //党建专题
        logger.info(">>>>>>>>>>IndexAction:govpubPage:党建专题>>>>>>>>>>");
        Contents contentsDjzt = new Contents();
        contentsDjzt.setCatalogID(Integer.valueOf(PropertiesUtils.readValue(propertiesPath, "djztCatalogID")));
        contentsDjzt.setStatus("1");
        contentsDjzt.setTopNum("8");
        List<Contents> djztList = frontContentsServices.queryContentsListByBean(contentsDjzt);
        request.setAttribute("djztList", djztList);
    	return "govpubPage";
    }
    
    /**
     * 根据某个catalogID查找其子栏目id
     * @param catalogID
     * @param ids
     * @return
     */
    public List<Integer> queryLeafCatalogIDList(String catalogID, List<Integer> ids){
    	if(catalogID != null){
    		Catalog temp = new Catalog();
            temp.setParentID(catalogID);
            temp.setStatus("1");
            List<Catalog> list = frontCatalogServices.queryCatalogListByBean(temp);
            if (list != null && list.size() > 0) {//存在子栏目
                for (int i = 0; i < list.size(); i++) {
                    Catalog c = list.get(i);
                    ids = this.queryLeafCatalogIDList(c.getTheID().toString(), ids);//递归
                }
            } else {
                //不存在子栏目（即叶节点），直接加入到集合中
            	ids.add(Integer.valueOf(catalogID));
            	
            }
    	}
    	return ids;
    }
    
    /**
     * 权责清单页面
     * @return
     */
    public String accrualPage(){
    	Accrual accrual = new Accrual();
    	accrual.setStatus("1");
    	accrual.setAccrualType("1");
    	accrual.setPid(0);
    	List<Accrual> list1 = frontAccrualServices.queryAccrualListByBean(accrual);
    	if(list1 != null && list1.size() > 0){
    		List<Accrual> childList1 = new ArrayList<Accrual>();
    		for(int i = 0;i < list1.size();i++){
    			accrual.setPid(list1.get(i).getTheID());
    			childList1 = frontAccrualServices.queryAccrualListByBean(accrual);
    			list1.get(i).setChildList(childList1);
    		}
    	}
    	request.setAttribute("list1", list1);
    	
    	accrual.setAccrualType("2");
    	accrual.setPid(0);
    	List<Accrual> list2 = frontAccrualServices.queryAccrualListByBean(accrual);
    	if(list2 != null && list2.size() > 0){
    		List<Accrual> childList2 = new ArrayList<Accrual>();
    		for(int i = 0;i < list2.size();i++){
    			accrual.setPid(list2.get(i).getTheID());
    			childList2 = frontAccrualServices.queryAccrualListByBean(accrual);
    			list2.get(i).setChildList(childList2);
    		}
    	}
    	request.setAttribute("list2", list2);
    	
    	accrual = new Accrual();
    	accrual.setAccrualType("3");
    	accrual.setStatus("1");
    	List<Accrual> list3 = frontAccrualServices.queryAccrualListByBean(accrual);
    	request.setAttribute("list3", list3);
    	
    	accrual.setAccrualType("4");
    	List<Accrual> list4 = frontAccrualServices.queryAccrualListByBean(accrual);
    	request.setAttribute("list4", list4);
    	
    	accrual.setAccrualType("5");
    	List<Accrual> list5 = frontAccrualServices.queryAccrualListByBean(accrual);
    	request.setAttribute("list5", list5);
    	
    	accrual.setAccrualType("6");
    	List<Accrual> list6 = frontAccrualServices.queryAccrualListByBean(accrual);
    	request.setAttribute("list6", list6);
    	
    	accrual.setAccrualType("7");
    	List<Accrual> list7 = frontAccrualServices.queryAccrualListByBean(accrual);
    	request.setAttribute("list7", list7);
    	
    	accrual.setAccrualType("8");
    	List<Accrual> list8 = frontAccrualServices.queryAccrualListByBean(accrual);
    	request.setAttribute("list8", list8);
    	
    	accrual.setAccrualType("9");
    	List<Accrual> list9 = frontAccrualServices.queryAccrualListByBean(accrual);
    	request.setAttribute("list9", list9);
    	
    	accrual.setAccrualType("10");
    	List<Accrual> list10 = frontAccrualServices.queryAccrualListByBean(accrual);
    	request.setAttribute("list10", list10);
    	return "accrualPage";
    }
    
    public FrontContentsServices getFrontContentsServices() {
        return frontContentsServices;
    }

    public void setFrontContentsServices(FrontContentsServices frontContentsServices) {
        this.frontContentsServices = frontContentsServices;
    }

    public FrontCatalogServices getFrontCatalogServices() {
        return frontCatalogServices;
    }

    public void setFrontCatalogServices(FrontCatalogServices frontCatalogServices) {
        this.frontCatalogServices = frontCatalogServices;
    }

    public FrontVideoServices getFrontVideoServices() {
        return frontVideoServices;
    }

    public void setFrontVideoServices(FrontVideoServices frontVideoServices) {
        this.frontVideoServices = frontVideoServices;
    }

    public FrontFileInfoServices getFrontFileInfoServices() {
        return frontFileInfoServices;
    }

    public void setFrontFileInfoServices(FrontFileInfoServices frontFileInfoServices) {
        this.frontFileInfoServices = frontFileInfoServices;
    }

}
