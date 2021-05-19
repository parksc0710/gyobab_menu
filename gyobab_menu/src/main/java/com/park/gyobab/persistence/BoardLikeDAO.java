package com.park.gyobab.persistence;

import java.util.HashMap;
import java.util.List;

import com.park.gyobab.domain.BoardLikeVO;

public interface BoardLikeDAO {
	
	public void insertBoardLike(HashMap<String, Integer> map);
	
	public void deleteBoardLike(int board_like_id);
	
	public List<BoardLikeVO> selectBoardLikes(int board_id) throws Exception;

	public Integer selectBoardLikeCnt(int board_id) throws Exception;
	
}
