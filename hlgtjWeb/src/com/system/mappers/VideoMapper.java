package com.system.mappers;

import java.util.List;

import com.system.bean.AllClassBean;
import com.system.pojo.Video;

public interface VideoMapper {
	public Video queryVideoByBean(Video video);

    public List<Video> queryAllVideoList();
    
    public List<Video> queryVideoListByBean(Video video);

    public void insertVideo(Video video);

    public void updateVideo(Video video);

    public void deleteVideo(Video video);
    
    public List<AllClassBean> getVideoListByBean(AllClassBean bean);
    
    public List<Video> queryTopVideoList(Video video);
}
