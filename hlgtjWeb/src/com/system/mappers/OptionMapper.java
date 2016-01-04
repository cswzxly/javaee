package com.system.mappers;

import java.util.List;

import com.system.pojo.Option;

public interface OptionMapper {
	public Option queryOptionByBean(Option option);

    public List<Option> queryAllOptionList();
    
    public List<Option> queryOptionListByBean(Option option);

    public void insertOption(Option option);

    public void updateOption(Option option);

    public void deleteOption(Option option);
    
    public List<Option> queryTopOptionList(Option option);

}
