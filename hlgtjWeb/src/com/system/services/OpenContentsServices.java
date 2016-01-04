package com.system.services;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.system.bean.AllClassBean;
import com.system.pojo.OpenContents;
@Transactional
public interface OpenContentsServices {
	public OpenContents queryOpenContentsByBean(OpenContents openContents);

    public List<OpenContents> queryAllOpenContentsList();
    
    public List<OpenContents> queryOpenContentsListByBean(OpenContents openContents);

    public void insertOpenContents(OpenContents openContents);

    public void updateOpenContents(OpenContents openContents);

    public void deleteOpenContents(OpenContents openContents);
    
    public List<AllClassBean> getOpenContentsListByBean(AllClassBean bean);
    
    public List<OpenContents> queryTopOpenContentsList(OpenContents openContents);
}
