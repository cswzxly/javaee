package com.system.services;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.system.pojo.ZlContents;
@Transactional
public interface ZlContentsServices {
	public ZlContents queryContentsByBean(ZlContents contents);

    public List<ZlContents> queryAllContentsList();
    
    public List<ZlContents> queryContentsListByBean(ZlContents contents);

    public void insertContents(ZlContents contents);

    public void updateContents(ZlContents contents);

    public void deleteContents(ZlContents contents);
}
