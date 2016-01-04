package com.web.action;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageInfo;
import com.system.action.BaseAction;
import com.system.pojo.*;
import com.system.services.UserServices;
import com.web.services.FrontCatalogServices;
import com.web.services.FrontContentsServices;
import com.web.services.FrontFileInfoServices;
import com.web.services.FrontVideoServices;
import com.web.utils.Arithmetic;
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
        List<Contents> tempList;
        for (Catalog catalogParam : thirdCatalogList) {
            List<Catalog> forthCatalogList = frontCatalogServices.queryCatalogByParentID(String.valueOf(catalogParam.getTheID()));
            if (forthCatalogList.size() > 0) {
                List<Integer> integers = new ArrayList<Integer>();
                for (Catalog forthCatalog : forthCatalogList) {
                    integers.add(forthCatalog.getTheID());
                }
                Integer[] ids = integers.toArray(new Integer[integers.size()]);
                Contents contentsParam = new Contents();
                contentsParam.setIds(ids);
                contentsParam.setStatus("1");
                contentsParam.setTopNum("5");
                tempList = frontContentsServices.queryContentsByIds(contentsParam);
                for (Contents temp : tempList) {
                    temp.setCatalogID(catalogParam.getTheID());
                    temp.setDesId(des.getEncString(temp.getTheID().toString()));
                }
            } else {
                Contents contentsParam = new Contents();
                contentsParam.setCatalogID(catalogParam.getTheID());
                contentsParam.setStatus("1");
                contentsParam.setTopNum("5");
                tempList = frontContentsServices.queryTopContentsList(contentsParam);
                for (Contents temp : tempList) {
                    temp.setDesId(des.getEncString(temp.getTheID().toString()));
                }
            }
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

    public String fileInfoMainList() {

        String catalogID = request.getParameter("catalogID");
        Arithmetic des = new Arithmetic();
        if (catalogID == null) {
            catalogID = "5";//给一个默认值
        }

        Catalog catalog = this.getCatalogByID(catalogID);
        request.setAttribute("catalog", catalog);

        List<Catalog> thirdCatalogList = this.frontCatalogServices.queryCatalogByParentID(catalogID);

        request.setAttribute("thirdCatalogList", thirdCatalogList);

        List<FileInfo> fileInfoList = new ArrayList<FileInfo>();
        List<FileInfo> tempList;
        for (Catalog catalogParam : thirdCatalogList) {
            List<Catalog> forthCatalogList = frontCatalogServices.queryCatalogByParentID(String.valueOf(catalogParam.getTheID()));
            if (forthCatalogList.size() > 0) {
                List<Integer> integers = new ArrayList<Integer>();
                for (Catalog forthCatalog : forthCatalogList) {
                    integers.add(forthCatalog.getTheID());
                }
                Integer[] ids = integers.toArray(new Integer[integers.size()]);
                FileInfo fileInfo = new FileInfo();
                fileInfo.setIds(ids);
                fileInfo.setIsshow("1");
                fileInfo.setTopNum("5");
                tempList = frontFileInfoServices.queryfileInfoByIds(fileInfo);
                for (FileInfo temp : tempList) {
                    String fileUrl = temp.getFileUrl();
                    String fileType = fileUrl.substring(fileUrl.lastIndexOf(".") + 1).toUpperCase();
                    temp.setFileUrl(fileType + "文件");
                    temp.setCatalogID(catalogParam.getTheID());
                    temp.setDesId(des.getEncString(temp.getTheID().toString()));
                }
            } else {
                FileInfo fileInfo = new FileInfo();
                fileInfo.setCatalogID(catalogParam.getTheID());
                fileInfo.setIsshow("1");
                fileInfo.setTopNum("5");
                tempList = frontFileInfoServices.queryTopFileInfoList(fileInfo);
                for (FileInfo temp : tempList) {
                    String fileUrl = temp.getFileUrl();
                    String fileType = fileUrl.substring(fileUrl.lastIndexOf(".") + 1).toUpperCase();
                    temp.setFileUrl(fileType + "文件");
                    temp.setDesId(des.getEncString(temp.getTheID().toString()));
                }
            }
            if (tempList.size() < 5) {
                FileInfo fileInfo = new FileInfo();
                for (int i = tempList.size(); i < 5; i++) {
                    tempList.add(fileInfo);
                }
            }
            fileInfoList.addAll(tempList);
        }
        request.setAttribute("fileInfoList", fileInfoList);

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
        return "fileInfoMainList";
    }

    /**
     * @return
     */
    public String areaInfoList() {

        String catalogID = request.getParameter("catalogID");
        String type = request.getParameter("type");
        if (type.equals("zwgk") && catalogID == null) {
            catalogID = "9";//给一个默认值
        }
        if (type.equals("xxgk") && catalogID == null) {
            catalogID = "204";//给一个默认值
        }
        if (type.equals("tztb") && catalogID == null) {
            catalogID = "9";//给一个默认值
        }
        if (type.equals("zlxz") && catalogID == null) {
            catalogID = "128";//给一个默认值
        }

        System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>ktip" + catalogID);
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
        for (int i = 0; i < leftCatalogList.size(); i++) {
            System.out.print(leftCatalogList.get(i).getUrl());
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
                for (int i = 0; i < catalogIDList.size(); i++) {
                    ids[i] = catalogIDList.get(i);
                }
                Contents contents = new Contents();
                contents.setIds(ids);
//            	List<Contents> contentsList = frontContentsServices.queryContentsByIds(contents);
                PageInfo<Contents> contentsList = frontContentsServices.queryContentsByIds(contents, getPageNum(), getPageSize());
                if (contentsList != null && contentsList.getList().size() > 0) {
                    for (Contents c : contentsList.getList()) {
                        c.setDesId(des.getEncString(c.getTheID().toString()));
                    }
                }
                request.setAttribute("contentsList", contentsList);
            } else if (catalog.getCatalogType().equals("t_video")) {
                Video video = new Video();
                video.setCatalogID(Integer.valueOf(catalogID));
                video.setStatus("1");
                List<Video> videoList = frontVideoServices.queryVideoListByBean(video);
                if (videoList != null && videoList.size() > 0) {
                    for (Video c : videoList) {
                        c.setDesId(des.getEncString(c.getTheID().toString()));
                    }
                }
                request.setAttribute("videoList", videoList);
            } else if (catalog.getCatalogType().equals("t_fileinfo")) {
                List<Integer> catalogIDList = new ArrayList<Integer>();
                catalogIDList = this.queryLeafCatalogIDList(catalog.getTheID().toString(), catalogIDList);
                Integer[] ids = new Integer[catalogIDList.size()];
                for (int i = 0; i < catalogIDList.size(); i++) {
                    ids[i] = catalogIDList.get(i);
                }
                FileInfo fileInfo = new FileInfo();
                fileInfo.setIds(ids);
                //     fileInfo.setCatalogID(Integer.valueOf(catalogID));
                fileInfo.setFileMode("t_fileinfo");
                fileInfo.setIsshow("1");
                PageInfo<FileInfo> fileInfoList = frontFileInfoServices.queryfileInfoByIds(fileInfo, getPageNum(), 20);
                if (fileInfoList != null && fileInfoList.getList().size() > 0) {
                    for (FileInfo c : fileInfoList.getList()) {
                        String fileUrl = c.getFileUrl();
                        String fileType = fileUrl.substring(fileUrl.lastIndexOf(".") + 1).toUpperCase();
                        c.setFileUrl(fileType + "文件");
                        c.setDesId(des.getEncString(c.getTheID().toString()));
                    }
                }

                request.setAttribute("fileInfoList", fileInfoList);
                this.initTheTitle(catalog);
                return "fileInfoList";
            }
        }
        this.initTheTitle(catalog);
        return "areaInfoList";
    }

    /**
     * 文章内容显示
     *
     * @return
     */
    public String contentsShow() {

        //文章内容
        try {
            String contentsID = request.getParameter("contentsID");
            if (contentsID != null && !"".equals(contentsID)) {
                Arithmetic des = new Arithmetic();
                Contents temp = new Contents();
                contentsID = des.getDesString(contentsID);
                temp.setTheID(Integer.valueOf(contentsID));
                Contents contents = frontContentsServices.queryContentsByBean(temp);
                contents.setVisitCount(contents.getVisitCount() + 1);
                frontContentsServices.updateContents(contents);
                logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> c12345 = " + contents);
                logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> c12345 = " + contents);
                logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> c12345 = " + contents);
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
                fileInfo.setTopNum("1");
                List<FileInfo> picList = frontFileInfoServices.front_fileInfoList(fileInfo);
                request.setAttribute("picList", picList);

                // 查找附件
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
        } catch (Exception e) {
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
        if (videoID != null && !"".equals(videoID)) {
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
     * 针对资料下载栏目
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
                    System.out.println("allTitle:" + list.get(i).getAllTitle());
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
                    Catalog pc = new Catalog();
                    pc.setStatus("1");
                    pc.setTheID(Integer.valueOf(catalog.getParentID()));
                    pc = frontCatalogServices.queryCatalogByBean(pc);
                    contentTitle = pc.getTitle();
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
            for (int i = 0; i < catalogIDList.size(); i++) {
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
            for (int i = 0; i < catalogIDList.size(); i++) {
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
     *
     * @return
     */
    public String workPage() {

        return "workPage";
    }

    /**
     * 政民互动二级页面
     *
     * @return
     */
    public String interactPage() {

        return "interactPage";
    }

    /**
     * 根据某个catalogID查找其子栏目id
     *
     * @param catalogID
     * @param ids
     * @return
     */
    public List<Integer> queryLeafCatalogIDList(String catalogID, List<Integer> ids) {
        if (catalogID != null) {
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
