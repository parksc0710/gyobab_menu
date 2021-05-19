package com.park.gyobab.service;

import java.util.HashMap;
import java.util.List;

import com.park.gyobab.domain.BoardLikeVO;
import com.park.gyobab.domain.BoardVO;

public interface BoardLikeService {
	
	public void insertBoardLike(HashMap<String, Integer> map);
	
	public void deleteBoardLike(int board_like_id);
	
	public List<BoardLikeVO> selectBoardLikes(int board_id) throws Exception;

	public Integer selectBoardLikeCnt(int board_id) throws Exception;
	
}
