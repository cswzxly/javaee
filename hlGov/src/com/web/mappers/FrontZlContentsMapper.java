package com.web.mappers;

import java.util.List;

import com.system.pojo.ZlContents;

public interface FrontZlContentsMapper {

    public List<ZlContents> queryTopZlContentsList(ZlContents zlContents);
    
    public List<ZlContents> queryZlContentsList(ZlContents zlContents);
    
    public ZlContents queryZlContentsByBean(int theID);

}
