package com.web.services;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.system.bean.AllClassBean;
import com.system.pojo.FileInfo;
import com.web.mappers.FrontFileInfoMapper;
/**
 * @author hchch
 *
 * 2014年8月18日
 */
@Service("frontFileInfoServices")
public class FrontFileInfoServicesImpl implements FrontFileInfoServices{

	@Resource(name="frontFileInfoMapper")
	private FrontFileInfoMapper frontFileInfoMapper;
	
	@Override
	public List<FileInfo> front_fileInfoList(FileInfo fileInfo) {
		return frontFileInfoMapper.front_fileInfoList(fileInfo);
	}

	@Override
	public FileInfo queryFileInfoByBean(FileInfo fileInfo) {
		return frontFileInfoMapper.queryFileInfoByBean(fileInfo);
	}

	@Override
	public List<AllClassBean> queryTopPicIndex(AllClassBean bean) {
		return frontFileInfoMapper.queryTopPicIndex(bean);
	}

}
