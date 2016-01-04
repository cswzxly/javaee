package com.web.services;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageInfo;
import com.system.bean.AllClassBean;
import com.system.pojo.FileInfo;
/**
 * @author hchch
 *
 * 2014年8月18日
 */
@Transactional
public interface FrontFileInfoServices {

	public List<FileInfo> front_fileInfoList(FileInfo fileInfo);
	
	public FileInfo queryFileInfoByBean(FileInfo fileInfo);
	
	public List<AllClassBean> queryTopPicIndex(AllClassBean bean);

	public List<FileInfo> queryfileInfoByIds(FileInfo fileInfo);

	List<FileInfo> queryTopFileInfoList(FileInfo fileInfo);

	public PageInfo<FileInfo> queryfileInfoByIds(FileInfo fileInfo,
			Integer pageNum, Integer pageSize);
}
