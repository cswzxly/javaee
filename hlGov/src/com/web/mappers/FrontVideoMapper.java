package com.web.mappers;

import java.util.List;

import com.system.pojo.Video;

public interface FrontVideoMapper {
	public Video queryVideoByBean(Video video);

//    public List<Video> queryAllVideoList();
    
    public List<Video> queryVideoListByBean(Video video);
//
//    public void insertVideo(Video video);
//
    public void updateVideoViewedNum(Video video);
//
//    public void deleteVideo(Video video);
//    
//    public List<AllClassBean> getVideoListByBean(AllClassBean bean);
    
    public List<Video> queryTopVideoList(Video video);
}
