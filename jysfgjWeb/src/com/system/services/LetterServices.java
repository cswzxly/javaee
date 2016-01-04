package com.system.services;

import java.util.List;

import com.system.pojo.Letter;

public interface LetterServices {
	
	public List<Letter> queryLetterList();
	
	public Letter queryLetterByBean(int theID);
	
	public List<Letter> queryLetterLike(Letter letter);
	
	public void updateLetter(Letter letter);
	
}
