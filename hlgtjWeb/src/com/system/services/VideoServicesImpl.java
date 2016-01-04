package com.system.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.system.bean.AllClassBean;
import com.system.mappers.VideoMapper;
import com.system.pojo.Video;

/**
 * @author hchch
 *
 * 2014年8月13日
 */
@Service("videoServices")
public class VideoServicesImpl implements VideoServices{
	
	private VideoMapper videoMapper;

	@Override
	public Video queryVideoByBean(Video video) {
		return videoMapper.queryVideoByBean(video);
	}

	@Override
	public List<Video> queryAllVideoList() {
		return videoMapper.queryAllVideoList();
	}

	@Override
	public List<Video> queryVideoListByBean(Video video) {
		return videoMapper.queryVideoListByBean(video);
	}

	@Override
	public void insertVideo(Video video) {
		videoMapper.insertVideo(video);
	}

	@Override
	public void updateVideo(Video video) {
		videoMapper.updateVideo(video);
	}

	@Override
	public void deleteVideo(Video video) {
		videoMapper.deleteVideo(video);
	}
	
	@Override
	public List<AllClassBean> getVideoListByBean(AllClassBean bean) {
		return videoMapper.getVideoListByBean(bean);
	}

	@Override
	public List<Video> queryTopVideoList(Video video) {
		return videoMapper.queryTopVideoList(video);
	}
	
	public VideoMapper getVideoMapper() {
		return videoMapper;
	}

	public void setVideoMapper(VideoMapper videoMapper) {
		this.videoMapper = videoMapper;
	}

}
