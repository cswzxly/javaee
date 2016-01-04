package com.web.mappers;

import java.util.List;

import com.github.pagehelper.Page;
import com.system.pojo.Contents;

public interface FrontContentsMapper {
    void updateContents(Contents contents);

	public Contents queryContentsByBean(Contents contents);

//    public List<Contents> queryAllContentsList();
    
    public List<Contents> queryContentsListByBean(Contents contents);

//    public void insertContents(Contents contents);

//    public void updateContents(Contents contents);

//    public void deleteContents(Contents contents);
    
//    public List<AllClassBean> getContentsListByBean(AllClassBean bean);
    
    public List<Contents> queryTopContentsList(Contents contents);
    
    public List<Contents> queryContentsByCataPid(Contents contents);

    public List<Contents> queryContentsByIds(Integer[] ids);
    
    public Page<Contents> queryContentsByIds(Contents contents);
}
