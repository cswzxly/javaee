package com.system.action;

import java.io.*;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.alibaba.fastjson.JSONObject;
import com.system.pojo.FileInfo;
import com.system.services.FileInfoServices;
import com.system.utils.DateUtils;
import org.apache.commons.lang3.StringUtils;

public class FileInfoAction extends BaseAction {
    @Resource(name = "fileInfoServices")
    private FileInfoServices fileInfoServices;
    private Integer theID;
    private Integer contentID;
    private String fileType;
    private String title;
    private String fileUrl;
    private String isshow;
    private String source;
    private Integer sort;
    private String isindex;
    private String fileMode;
    private Integer catalogID;

    private File uploadinfo;
    private String uploadinfoContentType;
    private String uploadinfoFileName;

    public String fileInfoPage() {
        request.setAttribute("contentID", request.getParameter("contentID"));
        String open = request.getParameter("open");
        if (open != null && !"".equals(open)) {
            request.setAttribute("open", open);
        }
        return SUCCESS;
    }

    /**
     * 文件列表
     */
    public void fileInfoList() {
        logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>FileInfoAction:fileInfoList");
        PrintWriter pw = null;
        try {
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            Map<String, Object> map = new HashMap<String, Object>();
            FileInfo fi = new FileInfo();
            if (contentID != null) {
                fi.setContentID(contentID);
            }
            if (catalogID != null) {
                fi.setCatalogID(catalogID);
            }
            if (StringUtils.isNotEmpty(fileMode)) {
                fi.setFileMode(fileMode);
            }
            List<FileInfo> list = fileInfoServices.queryFileInfoListByBean(fi);
            for (FileInfo fInfo : list) {
                fInfo.setFileTypeName(fInfo.getFileType().equals("1") ? "图片" : "文件");
                fInfo.setIsshowName(fInfo.getIsshow().equals("1") ? "是" : "否");
                if(fInfo.getIsindex() != null){
                	fInfo.setIsindexName(fInfo.getIsindex().equals("1") ? "是" : "否");
                }
            }
            map.put("total", list.size());
            map.put("rows", list);
            String open = request.getParameter("open");
            if (open != null && !"".equals(open)) {
                request.setAttribute("open", open);
            }
            String result = JSONObject.toJSONString(map);
            pw.write(result);
        } catch (Exception e) {
            e.printStackTrace();
        }
        pw.flush();
        pw.close();
    }

    /**
     * 保存上传文件
     *
     * @throws IOException
     */
    public void uploader() throws IOException {
        PrintWriter pw = null;
        this.getResponse().setCharacterEncoding("UTF-8");
        pw = this.getResponse().getWriter();
        String ID = request.getParameter("theID");
        String result = "";
        FileOutputStream fos = null;
        FileInputStream fis = null;
        try {
            String urlPath = "uploads/fileInfo/";
            String path = request.getSession().getServletContext().getRealPath("/");
            String realPath = path + urlPath;
            File filePath = new File(realPath);
            if (!filePath.exists()) {
                filePath.mkdirs();
            }
            String suffix = uploadinfoFileName.substring(uploadinfoFileName.lastIndexOf(".")).toLowerCase();
            String fileName = ID + suffix;
            File saveFile = new File(realPath + fileName);
            fos = new FileOutputStream(saveFile);
            fis = new FileInputStream(this.getUploadinfo());
            byte[] b = new byte[fis.available()];
            int readSize = fis.read(b);
            while (readSize > -1) {
                fos.write(b, 0, readSize);
                readSize = fis.read();
            }
            fos.close();
            fis.close();

            FileInfo f = new FileInfo();
            f.setTheID(Integer.valueOf(ID));
            f.setFileUrl(urlPath + fileName);
            fileInfoServices.updateFileInfo(f);
            result = "success";
            pw.write(result);
        } catch (Exception e) {
            e.printStackTrace();
        }
        pw.flush();
        pw.close();
    }

    /**
     * 保存新建文件资料
     */
    public void saveNewFileInfo() {
        PrintWriter pw = null;
        try {

            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            Map<String, Object> map = new HashMap<String, Object>();
            String result;
            FileInfo fileInfo = new FileInfo();
            if (contentID != null) {
                fileInfo.setContentID(contentID);
            }
            if (catalogID != null) {
                fileInfo.setCatalogID(catalogID);
            }
            logger.debug(">>>>>>>>>>>>>>>>>>>>>>>file");
            if (StringUtils.isNotEmpty(fileMode)) {
                logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>fileMode not empty");
                fileInfo.setFileMode(fileMode);
            }
            fileInfo.setTitle(title);
            fileInfo.setSort(Integer.valueOf(sort));
            fileInfo.setIsshow(isshow);
            fileInfo.setFileType(fileType);
            fileInfo.setIsindex(isindex);
            fileInfo.setCreate_date(DateUtils.getNowTime());
            fileInfoServices.insertFileInfo(fileInfo);
            result = "success";
            map.put("result", result);
            map.put("fileInfoID", fileInfo.getTheID());//返回新建记录的id
            String strMap = JSONObject.toJSONString(map);
            pw.write(strMap);
        } catch (Exception e) {
            e.printStackTrace();
        }
        pw.flush();
        pw.close();
    }

    /**
     * 检查图片是否存在首页显示
     */
    public void checkIndex() {
        PrintWriter pw = null;
        try {
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            int count;
            FileInfo fileInfo = new FileInfo();
            fileInfo.setContentID(contentID);
            fileInfo.setIsindex("1");
            count = fileInfoServices.countPicIndex(fileInfo);
            String result = "";
            if (count > 0) {
                result = "1";
            } else {
                result = "0";
            }
            pw.write(result);
        } catch (Exception e) {
            e.printStackTrace();
        }
        pw.flush();
        pw.close();
    }

    /**
     * 删除文件资料
     */
    public void deleteFileInfo() {
        PrintWriter pw = null;
        try {
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            String result;
            FileInfo f = new FileInfo();
            f.setTheID(Integer.valueOf(theID));
            f = fileInfoServices.queryFileInfoByBean(f);
            if (f != null) {
                //删除源文件
                String webappPath = request.getSession().getServletContext().getRealPath("/");
                String filePath = webappPath + f.getFileUrl();
                File file = new File(filePath);
                file.delete();
                fileInfoServices.deleteFileInfo(f);
                result = "success";
            } else {
                result = "fail";
            }
            pw.write(result);
        } catch (Exception e) {
            e.printStackTrace();
        }
        pw.flush();
        pw.close();
    }

    /**
     * 保存编辑的文件资料
     */
    public void saveEditFileInfo() {
        PrintWriter pw = null;
        try {
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            String result;
            FileInfo f = new FileInfo();
            f.setTheID(Integer.valueOf(theID));
            f = fileInfoServices.queryFileInfoByBean(f);
            if (f != null) {
                f.setTitle(title);
                f.setFileType(fileType);
                f.setIsindex("0");
                f.setSort(sort);
                f.setIsshow(isshow);
                fileInfoServices.updateFileInfo(f);
                result = "success";
            } else {
                result = "fail";
            }
            pw.write(result);
        } catch (Exception e) {
            e.printStackTrace();
        }
        pw.flush();
    }

    public void downloadFile() {
        logger.debug(">>>>>>>>>>>>>>>>>下载文件>>>>>>>>>>>>>>>>");
        FileInputStream fis = null;
        BufferedOutputStream bos = null;
        String theID1 = request.getParameter("theID");

        try {
            FileInfo fileInfo = fileInfoServices.queryByID(theID1);
            String fileName = fileInfo.getTitle();
            String filePath = fileInfo.getFileUrl();
            String suffix = filePath.substring(filePath.lastIndexOf(".")).toLowerCase();
            String realPath = request.getSession().getServletContext().getRealPath("/") + filePath;

            String isoFileName = new String(fileName.getBytes("gb2312"), "iso-8859-1");

            response.setContentType("bin;charset=UTF-8");
            response.addHeader("Content-Disposition", "attachment;filename=\"" + isoFileName + suffix + "\"");

            fis = new FileInputStream(realPath);
            bos = new BufferedOutputStream(response.getOutputStream());

            byte[] bytes = new byte[1024];
            while (fis.read(bytes) != -1) {
                bos.write(bytes);
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (fis != null) {
                try {
                    fis.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            if (bos != null) {
                try {
                    bos.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public Integer getTheID() {
        return theID;
    }

    public void setTheID(Integer theID) {
        this.theID = theID;
    }

    public Integer getContentID() {
        return contentID;
    }

    public void setContentID(Integer contentID) {
        this.contentID = contentID;
    }

    public String getFileType() {
        return fileType;
    }

    public void setFileType(String fileType) {
        this.fileType = fileType;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getFileUrl() {
        return fileUrl;
    }

    public void setFileUrl(String fileUrl) {
        this.fileUrl = fileUrl;
    }

    public String getIsshow() {
        return isshow;
    }

    public void setIsshow(String isshow) {
        this.isshow = isshow;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public FileInfoServices getFileInfoServices() {
        return fileInfoServices;
    }

    public void setFileInfoServices(FileInfoServices fileInfoServices) {
        this.fileInfoServices = fileInfoServices;
    }

    public File getUploadinfo() {
        return uploadinfo;
    }

    public void setUploadinfo(File uploadinfo) {
        this.uploadinfo = uploadinfo;
    }

    public String getUploadinfoContentType() {
        return uploadinfoContentType;
    }

    public void setUploadinfoContentType(String uploadinfoContentType) {
        this.uploadinfoContentType = uploadinfoContentType;
    }

    public String getUploadinfoFileName() {
        return uploadinfoFileName;
    }

    public void setUploadinfoFileName(String uploadinfoFileName) {
        this.uploadinfoFileName = uploadinfoFileName;
    }

    public String getIsindex() {
        return isindex;
    }

    public void setIsindex(String isindex) {
        this.isindex = isindex;
    }

    public String getFileMode() {
        return fileMode;
    }

    public void setFileMode(String fileMode) {
        this.fileMode = fileMode;
    }

    public Integer getCatalogID() {
        return catalogID;
    }

    public void setCatalogID(Integer catalogID) {
        this.catalogID = catalogID;
    }
}
