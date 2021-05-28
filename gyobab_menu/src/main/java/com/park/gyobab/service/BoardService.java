package com.park.gyobab.service;

import java.util.HashMap;
import java.util.List;

import com.park.gyobab.domain.BoardVO;

public interface BoardService {
	
	public void insertBoard(BoardVO vo);
	
	public void deleteBoard(int board_id);
	
	public BoardVO selectBoardById(int board_id) throws Exception;
	
	public BoardVO selectTop1Board(String board_type) throws Exception;
	
	public List<BoardVO> selectBoards(HashMap<String, Object> map) throws Exception;

	public Integer selectBoardCnt(HashMap<String, Object> map) throws Exception;
	
	public List<BoardVO> selectBoardsByMember(HashMap<String, Object> map) throws Exception;

	public Integer selectBoardCntByMember(HashMap<String, Object> map) throws Exception;
	
	public void updateBoard(BoardVO vo);
	
	public void updateViewCnt(int board_id);
}
