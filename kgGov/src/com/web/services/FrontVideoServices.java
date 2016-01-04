package com.web.services;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageInfo;
import com.system.pojo.Video;
@Transactional
public interface FrontVideoServices {
	public Video queryVideoByBean(Video video);

    public List<Video> queryVideoListByBean(Video video);
    
    public List<Video> queryTopVideoList(Video video);

	public PageInfo<Video> queryVideoByIds(Video video, Integer pageNum,
			Integer pageSize);

}
