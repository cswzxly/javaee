package com.system.services;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;
import com.system.pojo.Option;
@Transactional
public interface OptionServices {

	public Option queryOptionByBean(Option option);

    public List<Option> queryAllOptionList();
    
    public List<Option> queryOptionListByBean(Option option);

    public void insertOption(Option option);

    public void updateOption(Option option);

    public void deleteOption(Option option);
	
}
