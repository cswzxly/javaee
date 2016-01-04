package com.web.services;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.system.pojo.Letter;
import com.web.mappers.FrontLetterMapper;

@Service("frontLetterServices")
public class FrontLetterServicesImpl implements FrontLetterServices{

	@Resource(name="frontLetterMapper")
	private FrontLetterMapper frontLetterMapper;

	@Override
	public int front_saveLetter(Letter letter) {
		// TODO Auto-generated method stub
		return frontLetterMapper.front_saveLetter(letter);
	}

	@Override
	public void front_updateLetter(Letter letter) {
		// TODO Auto-generated method stub
		frontLetterMapper.front_updateLetter(letter);
	}

	@Override
	public List<Letter> frontLetterDetail(Letter letter) {
		// TODO Auto-generated method stub
		return frontLetterMapper.front_replayLetter(letter);
	}

	
	
}
