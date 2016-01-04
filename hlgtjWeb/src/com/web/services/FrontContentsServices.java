package com.web.services;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageInfo;
import com.system.pojo.Contents;

/**
 * @author hchch
 *         <p/>
 *         2014年8月18日
 */
@Transactional
public interface FrontContentsServices {
    void updateContents(Contents contents);

    public Contents queryContentsByBean(Contents contents);

    public List<Contents> queryContentsListByBean(Contents contents);

    public List<Contents> queryTopContentsList(Contents contents);

    public List<Contents> queryContentsByCataPid(Contents contents);

//	public PagerModel queryPagerListContents(Contents contents);

    public List<Contents> queryContentsByIds(Contents contents);
    
    public PageInfo<Contents> queryContentsByIds(Contents contents,Integer pageNum,Integer pageSize);
    
}
