package com.web.mappers;

import java.util.List;
import com.system.pojo.OpenContents;

public interface FrontOpenContentsMapper {

    public List<OpenContents> queryTopOpenContentsList(OpenContents openContents);

    public List<OpenContents> queryOpenContentsList(OpenContents openContents);
    
    public OpenContents frontOpenContentsDetail(int theID);
    
    public List<OpenContents> queryOCListByIDs(String ids);
}
