package com.park.gyobab.persistence;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.park.gyobab.domain.BoardCommentVO;
import com.park.gyobab.domain.BoardVO;

@Repository
public class BoardCommentDAOImpl implements BoardCommentDAO {

	@Inject
	private SqlSession sqlSession;
	
	private static final String namespace = "com.park.gyobab.BoardCommentMapper";

	@Override
	public void insertBoardComment(HashMap<String, Object> map) {
		sqlSession.insert(namespace + ".insertBoardComment", map); 
	}
	
	@Override
	public void insertBoardCommentReply(HashMap<String, Object> map) {
		sqlSession.insert(namespace + ".insertBoardCommentReply", map); 		
	}

	@Override
	public List<BoardCommentVO> selectBoardComments(int board_comment_board) throws Exception {
		List<BoardCommentVO> list = sqlSession.selectList(namespace + ".selectBoardComments", board_comment_board);
		return list;
	}

	@Override
	public void deleteBoardComment(int board_comment_id) {
		sqlSession.update(namespace + ".deleteBoardComment", board_comment_id); 		
	}

	@Override
	public BoardCommentVO selectBoardCommentById(int board_comment_id) throws Exception {
		BoardCommentVO tmpVO = (BoardCommentVO) sqlSession.selectOne(namespace + ".selectBoardCommentById", board_comment_id);
		return tmpVO;
	}

	@Override
	public void updateBoardComment(HashMap<String, Object> map) {
		sqlSession.update(namespace + ".updateBoardComment", map); 			
	}

	@Override
	public Integer selectBoardCommentCntWithCommentParent(int board_comment_parent) throws Exception {
		int cnt = sqlSession.selectOne(namespace + ".selectBoardCommentCntWithCommentParent", board_comment_parent);
		return cnt;
	}

	@Override
	public void deleteBoardCommentWithParent(int board_comment_id) {
		sqlSession.update(namespace + ".deleteBoardCommentWithParent", board_comment_id); 	
	}

	@Override
	public Integer selectBoardCommentCntWithCommentParentAfter(int board_comment_parent) throws Exception {
		int cnt = sqlSession.selectOne(namespace + ".selectBoardCommentCntWithCommentParentAfter", board_comment_parent);
		return cnt;
	}

	@Override
	public void deleteBoardCommentWithParentAfter(int board_comment_parent) {
		sqlSession.update(namespace + ".deleteBoardCommentWithParentAfter", board_comment_parent); 			
	}

}
