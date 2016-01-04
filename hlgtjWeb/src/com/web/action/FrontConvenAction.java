package com.web.action;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.system.action.BaseAction;
import com.system.pojo.*;
import com.system.services.UserServices;
import com.web.services.FrontCatalogServices;
import com.web.services.FrontContentsServices;
import com.web.services.FrontFileInfoServices;
import com.web.services.FrontVideoServices;
import com.web.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public class FrontConvenAction extends BaseAction {

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

    public String convenList() {
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

        if (catalog != null) {
            if (catalog.getCatalogType().equals("t_contents")) {
//				Contents contents = new Contents();
//				contents.setCatalogID(Integer.valueOf(catalogID));
//				contents.setStatus("1");
//				List<Contents> contentsList = frontContentsServices.queryContentsListByBean(contents);
                List<Contents> contentsList = new ArrayList<Contents>();
                contentsList = this.queryLeafCataContentsList(catalog.getTheID().toString(), contentsList);
                request.setAttribute("contentsList", contentsList);
            } else if (catalog.getCatalogType().equals("t_video")) {
                Video video = new Video();
                video.setCatalogID(Integer.valueOf(catalogID));
                video.setStatus("1");
                List<Video> videoList = frontVideoServices.queryVideoListByBean(video);
                request.setAttribute("videoList", videoList);
            }
        }
        this.initTheTitle(catalog);
        return "convenList";
    }

    /**
     * 文章内容显示
     *
     * @return
     */
    public String contentsShows() {
        //文章内容
        String contentsID = request.getParameter("contentsID");
        Contents temp = new Contents();
        temp.setTheID(Integer.valueOf(contentsID));
        Contents contents = frontContentsServices.queryContentsByBean(temp);

        User user = new User();
        user.setId(Integer.valueOf(contents.getCreater_pid()));
        user = userServices.queryUserByBean(user);
        if (user != null) {
            contents.setUserName(user.getRealName());
            request.setAttribute("contents", contents);
        }

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
        return "contentsShows";
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
            catalog.setStatus("1");
        }
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
                    if (temp.getTitle().length() > 20) {
                        list.get(i).setTitle(temp.getTitle().substring(0, 20) + "...");
                    }
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
