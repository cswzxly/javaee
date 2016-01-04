package com.system.services;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.system.bean.AllClassBean;
import com.system.pojo.FileInfo;
@Transactional
public interface FileInfoServices {
	public FileInfo queryFileInfoByBean(FileInfo fileInfo);

    public List<FileInfo> queryAllFileInfoList();
    
    public List<FileInfo> queryFileInfoListByBean(FileInfo fileInfo);

    public void insertFileInfo(FileInfo fileInfo);

    public void updateFileInfo(FileInfo fileInfo);

    public void deleteFileInfo(FileInfo fileInfo);
    
    public int countPicIndex(FileInfo fileInfo);
    
    public List<AllClassBean> getFileInfoListByBean(AllClassBean bean);
}
