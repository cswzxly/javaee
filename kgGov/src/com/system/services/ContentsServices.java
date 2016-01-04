package com.system.services;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.system.bean.AllClassBean;
import com.system.pojo.Contents;
@Transactional
public interface ContentsServices {
	public Contents queryContentsByBean(Contents contents);

    public List<Contents> queryAllContentsList();
    
    public List<Contents> queryContentsListByBean(Contents contents);

    public void insertContents(Contents contents);

    public void updateContents(Contents contents);

    public void deleteContents(Contents contents);
    
    public List<AllClassBean> getContentsListByBean(AllClassBean bean);
    
    public List<Contents> queryTopContentsList(Contents contents);
    
    public void updateTopNewsByCatalogID(Contents contents);
    
    public Integer countContentsByBean(Contents contents);
    
    public void batchDeleteContents(String ids);
}
