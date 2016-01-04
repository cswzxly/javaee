package com.system.services;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.system.bean.AllClassBean;
import com.system.pojo.Video;
/**
 * @author hchch
 *
 * 2014年8月13日
 */
@Transactional
public interface VideoServices {
	public Video queryVideoByBean(Video video);

    public List<Video> queryAllVideoList();
    
    public List<Video> queryVideoListByBean(Video video);

    public void insertVideo(Video video);

    public void updateVideo(Video video);

    public void deleteVideo(Video video);
    
    public List<AllClassBean> getVideoListByBean(AllClassBean bean);
    
    public List<Video> queryTopVideoList(Video video);
}
