package com.web.mappers;

import java.util.List;

import com.system.pojo.Letter;

public interface FrontLetterMapper {
	
	public int front_saveLetter(Letter letter);
	
	public void front_updateLetter(Letter letter);
	
	public List<Letter> front_replayLetter(Letter letter);
	
}
