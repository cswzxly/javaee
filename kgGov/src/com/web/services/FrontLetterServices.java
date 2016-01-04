package com.web.services;

import java.util.List;

import com.system.pojo.Letter;

public interface FrontLetterServices {
	
	public int front_saveLetter(Letter letter);
	
	public void front_updateLetter(Letter letter);
	
	public List<Letter> frontLetterDetail(Letter letter);
}
