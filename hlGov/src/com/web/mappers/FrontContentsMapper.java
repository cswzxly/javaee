package com.web.mappers;

import java.util.List;
import com.system.pojo.Contents;

public interface FrontContentsMapper {
	public Contents queryContentsByBean(Contents contents);

//    public List<Contents> queryAllContentsList();
    
    public List<Contents> queryContentsListByBean(Contents contents);

//    public void insertContents(Contents contents);

    public void updateContentsViewedNum(Contents contents);

//    public void deleteContents(Contents contents);
    
//    public List<AllClassBean> getContentsListByBean(AllClassBean bean);
    
    public List<Contents> queryTopContentsList(Contents contents);
    
    public List<Contents> queryContentsByCataPid(Contents contents);

	public List<Contents> queryContentsByIds(Contents contents);
}
