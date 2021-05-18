package com.park.gyobab.persistence;

import java.util.HashMap;
import java.util.List;

import com.park.gyobab.domain.BoardVO;

public interface BoardDAO {
	
	public void insertBoard(BoardVO vo);
	
	public void deleteBoard(int board_id);
	
	public BoardVO selectBoardById(int board_id) throws Exception;
	
	public BoardVO selectTop1Board(String board_type) throws Exception;
	
	public List<BoardVO> selectBoards(HashMap<String, Object> map) throws Exception;

	public Integer selectBoardCnt(String board_type) throws Exception;
	
	public void updateBoard(BoardVO vo);
	
}
