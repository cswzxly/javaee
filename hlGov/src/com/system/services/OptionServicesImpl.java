package com.system.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.system.mappers.OptionMapper;
import com.system.pojo.Option;

@Service("optionServices")
public class OptionServicesImpl implements OptionServices{
	
	private OptionMapper optionMapper;

	@Override
	public Option queryOptionByBean(Option option) {
		return optionMapper.queryOptionByBean(option);
	}

	@Override
	public List<Option> queryAllOptionList() {
		return optionMapper.queryAllOptionList();
	}

	@Override
	public List<Option> queryOptionListByBean(Option option) {
		return optionMapper.queryOptionListByBean(option);
	}

	@Override
	public void insertOption(Option option) {
		optionMapper.insertOption(option);
	}

	@Override
	public void updateOption(Option option) {
		optionMapper.updateOption(option);
	}

	@Override
	public void deleteOption(Option option) {
		optionMapper.deleteOption(option);
	}

	public OptionMapper getOptionMapper() {
		return optionMapper;
	}

	public void setOptionMapper(OptionMapper optionMapper) {
		this.optionMapper = optionMapper;
	}

}
