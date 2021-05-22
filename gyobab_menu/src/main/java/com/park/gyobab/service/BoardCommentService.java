package com.park.gyobab.service;

import java.util.HashMap;
import java.util.List;

import com.park.gyobab.domain.BoardCommentVO;
import com.park.gyobab.domain.BoardVO;

public interface BoardCommentService {
	
	public void insertBoardComment(HashMap<String, Object> map);

	public void insertBoardCommentReply(HashMap<String, Object> map);
	
	public List<BoardCommentVO> selectBoardComments(int board_comment_board) throws Exception;
	
	public void deleteBoardComment(int board_comment_id);
	
	public BoardCommentVO selectBoardCommentById(int board_comment_id) throws Exception;

	public void updateBoardComment(HashMap<String, Object> map);
}