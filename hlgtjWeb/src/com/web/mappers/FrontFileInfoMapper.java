package com.web.mappers;

import java.util.List;

import com.system.bean.AllClassBean;
import com.system.pojo.FileInfo;

public interface FrontFileInfoMapper {
	
	public List<FileInfo> front_fileInfoList(FileInfo fileInfo);

	public FileInfo queryFileInfoByBean(FileInfo fileInfo);
	
	public List<AllClassBean> queryTopPicIndex(AllClassBean bean);

	List<FileInfo> queryTopFileInfoList(FileInfo fileInfo);

	public List<FileInfo> queryfileInfoByIds(FileInfo fileInfo);
}
