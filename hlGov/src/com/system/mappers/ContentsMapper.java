package com.system.mappers;

import java.util.List;

import com.system.bean.AllClassBean;
import com.system.pojo.Contents;

public interface ContentsMapper {
	public Contents queryContentsByBean(Contents contents);

    public List<Contents> queryAllContentsList();
    
    public List<Contents> queryContentsListByBean(Contents contents);

    public void insertContents(Contents contents);

    public void updateContents(Contents contents);

    public void deleteContents(Contents contents);
    
    public List<AllClassBean> getContentsListByBean(AllClassBean bean);
    
    public List<Contents> queryTopContentsList(Contents contents);

	public void updateTopNewsByCatalogID(Contents contents);
}
