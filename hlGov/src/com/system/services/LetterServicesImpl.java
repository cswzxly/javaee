package com.system.services;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.system.mappers.LetterMapper;
import com.system.pojo.Letter;
import com.web.mappers.FrontLetterMapper;

@Service("letterServices")
public class LetterServicesImpl implements LetterServices{

	@Resource(name="letterMapper")
	private LetterMapper letterMapper;

	@Override
	public List<Letter> queryLetterList() {
		// TODO Auto-generated method stub
		return letterMapper.queryLetterList();
	}

	@Override
	public Letter queryLetterByBean(int theID) {
		// TODO Auto-generated method stub
		return letterMapper.queryLetterByBean(theID);
	}

	@Override
	public List<Letter> queryLetterLike(Letter letter) {
		// TODO Auto-generated method stub
		return letterMapper.queryLetterLike(letter);
	}

	@Override
	public void updateLetter(Letter letter) {
		// TODO Auto-generated method stub
		letterMapper.updateLetter(letter);
	}
	
}
