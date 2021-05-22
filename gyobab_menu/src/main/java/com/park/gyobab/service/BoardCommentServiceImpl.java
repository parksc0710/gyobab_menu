package com.park.gyobab.service;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.park.gyobab.domain.BoardCommentVO;
import com.park.gyobab.domain.BoardVO;
import com.park.gyobab.persistence.BoardCommentDAO;

@Service
public class BoardCommentServiceImpl implements BoardCommentService {

	@Inject
	private BoardCommentDAO dao;

	@Override
	public void insertBoardComment(HashMap<String, Object> map) {
		dao.insertBoardComment(map);		
	}
	
	@Override
	public void insertBoardCommentReply(HashMap<String, Object> map) {
		dao.insertBoardCommentReply(map);			
	}

	@Override
	public List<BoardCommentVO> selectBoardComments(int board_comment_board) throws Exception {
		List<BoardCommentVO> list = dao.selectBoardComments(board_comment_board);
		return list;
	}

	@Override
	public void deleteBoardComment(int board_comment_id) {
		dao.deleteBoardComment(board_comment_id);
	}

	@Override
	public BoardCommentVO selectBoardCommentById(int board_comment_id) throws Exception {
		BoardCommentVO tmpVO = dao.selectBoardCommentById(board_comment_id);
		return tmpVO;
	}

	@Override
	public void updateBoardComment(HashMap<String, Object> map) {
		dao.updateBoardComment(map);
	}

	@Override
	public Integer selectBoardCommentCntWithCommentParent(int board_comment_parent) throws Exception {
		int cnt = dao.selectBoardCommentCntWithCommentParent(board_comment_parent); 
		return cnt;
	}

	@Override
	public void deleteBoardCommentWithParent(int board_comment_id) {
		dao.deleteBoardCommentWithParent(board_comment_id);		
	}

	@Override
	public Integer selectBoardCommentCntWithCommentParentAfter(int board_comment_parent) throws Exception {
		int cnt = dao.selectBoardCommentCntWithCommentParentAfter(board_comment_parent); 
		return cnt;
	}

	@Override
	public void deleteBoardCommentWithParentAfter(int board_comment_parent) {
		dao.deleteBoardCommentWithParentAfter(board_comment_parent);	
	}

}
