package com.system.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.system.bean.AllClassBean;
import com.system.mappers.FileInfoMapper;
import com.system.pojo.FileInfo;

@Service("fileInfoServices")
public class FileInfoServicesImpl implements FileInfoServices{

	private FileInfoMapper fileInfoMapper;
	
	public FileInfoMapper getFileInfoMapper() {
		return fileInfoMapper;
	}

	public void setFileInfoMapper(FileInfoMapper fileInfoMapper) {
		this.fileInfoMapper = fileInfoMapper;
	}

	@Override
	public FileInfo queryFileInfoByBean(FileInfo fileInfo) {	
		return fileInfoMapper.queryFileInfoByBean(fileInfo);
	}

	@Override
	public List<FileInfo> queryAllFileInfoList() {	
		return fileInfoMapper.queryAllFileInfoList();
	}

	@Override
	public List<FileInfo> queryFileInfoListByBean(FileInfo fileInfo) {
		return fileInfoMapper.queryFileInfoListByBean(fileInfo);
	}

	@Override
	public void insertFileInfo(FileInfo fileInfo) {
		fileInfoMapper.insertFileInfo(fileInfo);
		
	}

	@Override
	public void updateFileInfo(FileInfo fileInfo) {
		fileInfoMapper.updateFileInfo(fileInfo);
		
	}

	@Override
	public void deleteFileInfo(FileInfo fileInfo) {
		fileInfoMapper.deleteFileInfo(fileInfo);
		
	}

	@Override
	public int countPicIndex(FileInfo fileInfo) {
		return fileInfoMapper.countPicIndex(fileInfo);
	}

	@Override
	public List<AllClassBean> getFileInfoListByBean(AllClassBean bean) {
		return fileInfoMapper.getFileInfoListByBean(bean);
	}

}
