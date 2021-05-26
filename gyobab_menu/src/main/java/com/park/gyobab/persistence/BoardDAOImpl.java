package com.park.gyobab.persistence;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.park.gyobab.domain.BoardVO;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Inject
	private SqlSession sqlSession;
	
	private static final String namespace = "com.park.gyobab.BoardMapper";

	@Override
	public void insertBoard(BoardVO vo) {
		sqlSession.insert(namespace + ".insertBoard", vo); 
	}

	@Override
	public void deleteBoard(int board_id) {
		sqlSession.update(namespace + ".deleteBoard", board_id); 
	}

	@Override
	public BoardVO selectBoardById(int board_id) throws Exception {
		BoardVO tmpVO = (BoardVO) sqlSession.selectOne(namespace + ".selectBoardById", board_id);
		return tmpVO;
	}
	
	@Override
	public BoardVO selectTop1Board(String board_type) throws Exception {
		BoardVO tmpVO = (BoardVO) sqlSession.selectOne(namespace + ".selectTop1Board", board_type);
		return tmpVO;
	}

	@Override
	public List<BoardVO> selectBoards(HashMap<String, Object> map) throws Exception {
		List<BoardVO> list = sqlSession.selectList(namespace + ".selectBoards", map);
		return list;
	}

	@Override
	public void updateBoard(BoardVO vo) {
		sqlSession.update(namespace + ".updateBoard", vo); 
	}

	@Override
	public Integer selectBoardCnt(HashMap<String, Object> map) throws Exception {
		int cnt = sqlSession.selectOne(namespace + ".selectBoardCnt", map);
		return cnt;
	}

	@Override
	public List<BoardVO> selectBoardsByMember(HashMap<String, Object> map) throws Exception {
		List<BoardVO> list = sqlSession.selectList(namespace + ".selectBoardsByMember", map);
		return list;
	}

	@Override
	public Integer selectBoardCntByMember(HashMap<String, Object> map) throws Exception {
		int cnt = sqlSession.selectOne(namespace + ".selectBoardCntByMember", map);
		return cnt;
	}


}
