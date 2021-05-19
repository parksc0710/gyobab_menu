package com.park.gyobab.persistence;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.park.gyobab.domain.BoardLikeVO;
import com.park.gyobab.domain.BoardVO;

@Repository
public class BoardLikeDAOImpl implements BoardLikeDAO {

	@Inject
	private SqlSession sqlSession;
	
	private static final String namespace = "com.park.gyobab.BoardLikeMapper";

	@Override
	public void insertBoardLike(HashMap<String, Integer> map) {
		sqlSession.insert(namespace + ".insertBoardLike", map); 		
	}

	@Override
	public void deleteBoardLike(HashMap<String, Integer> map) {
		sqlSession.delete(namespace + ".deleteBoardLike", map); 
	}

	@Override
	public List<BoardLikeVO> selectBoardLikes(int board_id) throws Exception {
		List<BoardLikeVO> list = sqlSession.selectList(namespace + ".selectBoardLikes", board_id);
		return list;
	}

	@Override
	public Integer selectBoardLikeCnt(int board_id) throws Exception {
		int cnt = sqlSession.selectOne(namespace + ".selectBoardLikeCnt", board_id);
		return cnt;
	}

}
