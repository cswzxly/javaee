package com.web.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.system.pojo.Video;
import com.web.mappers.FrontVideoMapper;

@Service("frontVideoServices")
public class FrontVideoServicesImpl implements FrontVideoServices {
	
	private FrontVideoMapper frontVideoMapper;

	@Override
	public Video queryVideoByBean(Video video) {
		return frontVideoMapper.queryVideoByBean(video);
	}

	@Override
	public List<Video> queryVideoListByBean(Video video) {
		return frontVideoMapper.queryVideoListByBean(video);
	}

	@Override
	public List<Video> queryTopVideoList(Video video) {
		return frontVideoMapper.queryTopVideoList(video);
	}

	public FrontVideoMapper getFrontVideoMapper() {
		return frontVideoMapper;
	}

	public void setFrontVideoMapper(FrontVideoMapper frontVideoMapper) {
		this.frontVideoMapper = frontVideoMapper;
	}
	
}
