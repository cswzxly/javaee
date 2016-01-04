package com.system.mappers;

import java.util.List;
import com.system.pojo.ZlContents;

public interface ZlContentsMapper {
	public ZlContents queryContentsByBean(ZlContents contents);

    public List<ZlContents> queryAllContentsList();
    
    public List<ZlContents> queryContentsListByBean(ZlContents contents);

    public void insertContents(ZlContents contents);

    public void updateContents(ZlContents contents);

    public void deleteContents(ZlContents contents);
}
